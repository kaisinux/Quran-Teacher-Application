import 'dart:convert';

import '../../features/auth/domain/app_user.dart';
import '../../features/grades/domain/grade_validator.dart';
import '../../features/grades/domain/student_grade.dart';
import '../../features/sessions/domain/school_session.dart';
import '../../features/sessions/domain/session_status.dart';
import '../errors/app_error.dart';
import '../utils/date_only.dart';
import 'api_client.dart';
import 'api_models.dart';

/// In-memory stand-in for the Apps Script API (Phase 2).
///
/// It enforces the same server rules as the real backend will: token →
/// user → group (never the group sent by the client), locked sessions,
/// version/hash conflicts, idempotency, grade validation.
/// All data is fictitious.
class MockApiClient implements ApiClient {
  MockApiClient({
    this.latency = const Duration(milliseconds: 350),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now {
    _seed();
  }

  final Duration latency;
  final DateTime Function() _clock;

  /// Simulates the absence of network (toggle from the settings screen).
  bool offline = false;

  static const demoTeacherEmail = 'teacher@example.com';
  static const demoTeacherPin = '12345';
  static const demoAdminEmail = 'admin@example.com';
  static const demoAdminPin = '54321';

  final Map<String, _MockAccount> _accounts = {};
  final Map<String, Group> _groups = {};
  final List<SchoolSession> _calendar = [];
  final Map<String, List<_MockStudent>> _students = {};
  final Map<String, _MockBlock> _blocks = {}; // key: groupId|date
  final Map<String, SubmitResult> _idempotency = {};
  final List<AppNotification> _notifications = [];
  final Map<String, int> _pinFailures = {};
  int _tokenCounter = 0;

  // ---------------------------------------------------------------- auth

  @override
  Future<AuthSession> authGoogle(String idToken) async {
    await _roundTrip();
    // Real backend: tokeninfo check (aud, iss, exp, email_verified).
    const prefix = 'mock-google-id-token:';
    if (!idToken.startsWith(prefix)) {
      throw const AppException(AppErrorCode.invalidCredentials);
    }
    return _issueToken(idToken.substring(prefix.length));
  }

  @override
  Future<AuthSession> authPin({
    required String email,
    required String pin,
  }) async {
    await _roundTrip();
    final key = email.trim().toLowerCase();
    if ((_pinFailures[key] ?? 0) >= 5) {
      throw const AppException(AppErrorCode.rateLimited);
    }
    final account = _accounts[key];
    if (account == null || account.pin != pin) {
      _pinFailures[key] = (_pinFailures[key] ?? 0) + 1;
      // Generic message: never reveal whether the email exists.
      throw const AppException(AppErrorCode.invalidCredentials);
    }
    _pinFailures.remove(key);
    return _issueToken(key);
  }

  AuthSession _issueToken(String email) {
    final account = _accounts[email.trim().toLowerCase()];
    if (account == null || !account.active) {
      throw const AppException(AppErrorCode.notAuthorized);
    }
    _tokenCounter++;
    return AuthSession(
      token: 'mock-token:${account.user.email}:$_tokenCounter',
      expiresAt: _clock().add(const Duration(days: 30)),
      user: account.user,
    );
  }

  @override
  Future<void> logout(String token) => _roundTrip();

  @override
  Future<AppUser> me(String token) async {
    await _roundTrip();
    return _authenticate(token).user;
  }

  _MockAccount _authenticate(String token) {
    final parts = token.split(':');
    if (parts.length != 3 || parts.first != 'mock-token') {
      throw const AppException(AppErrorCode.authRequired);
    }
    final account = _accounts[parts[1]];
    if (account == null || !account.active) {
      throw const AppException(AppErrorCode.notAuthorized);
    }
    return account;
  }

  Teacher _requireTeacher(String token) {
    final user = _authenticate(token).user;
    if (user is! Teacher) throw const AppException(AppErrorCode.notAuthorized);
    return user;
  }

  void _requireAdmin(String token) {
    if (_authenticate(token).user is! AdminUser) {
      throw const AppException(AppErrorCode.notAuthorized);
    }
  }

  // ------------------------------------------------------------ sessions

  @override
  Future<SessionsOverview> listSessions(String token) async {
    await _roundTrip();
    final teacher = _requireTeacher(token);
    return SessionsOverview(
      group: _groups[teacher.groupId]!,
      sessions: [
        for (final day in _calendar)
          SchoolSession(
            date: day.date,
            schoolYear: day.schoolYear,
            term: day.term,
            calendarStatus: day.calendarStatus,
            comment: day.comment,
            blockReady: _blocks.containsKey(_key(teacher.groupId, day.date)),
            serverStatus: _blocks[_key(teacher.groupId, day.date)]?.status,
            serverVersion: _blocks[_key(teacher.groupId, day.date)]?.version ?? 0,
          ),
      ],
    );
  }

  @override
  Future<ServerSession> getSession(String token, DateOnly date) async {
    await _roundTrip();
    final teacher = _requireTeacher(token);
    return _readSession(teacher.groupId, date);
  }

  ServerSession _readSession(String groupId, DateOnly date) {
    final day = _calendar.where((d) => d.date == date).firstOrNull;
    if (day == null) throw const AppException(AppErrorCode.sessionNotFound);
    if (!day.isClassDay) {
      throw const AppException(AppErrorCode.sessionNotAClassDay);
    }
    final block = _blocks[_key(groupId, date)];
    if (block == null) {
      // Row 4 of the sheet has no such date yet (decision Q3).
      throw const AppException(AppErrorCode.sessionBlockNotReady);
    }
    final students = _students[groupId]!;
    return ServerSession(
      groupId: groupId,
      sessionDate: date,
      sessionNumber: block.number,
      status: block.status,
      version: block.version,
      baseHash: block.hash(students),
      correctionComment: block.correctionComment,
      teacherName: _groups[groupId]!.teacherName,
      grades: [
        for (final s in students)
          block.cells[s.id] ??
              StudentGrade.initial(
                studentId: s.id,
                studentName: s.name,
                order: s.order,
              ),
      ],
    );
  }

  @override
  Future<SubmitResult> submitSession(
    String token,
    SubmitRequest request,
  ) async {
    await _roundTrip();
    final teacher = _requireTeacher(token);
    // The group comes from the account; the client value is only checked.
    if (request.groupId != teacher.groupId) {
      throw const AppException(AppErrorCode.forbiddenGroup);
    }
    final previous = _idempotency[request.idempotencyKey];
    if (previous != null) return previous;

    final current = _readSession(teacher.groupId, request.sessionDate);
    final block = _blocks[_key(teacher.groupId, request.sessionDate)]!;
    if (block.status == SessionStatus.validated) {
      throw const AppException(AppErrorCode.sessionLocked);
    }
    if (request.baseVersion != current.version ||
        request.baseHash != current.baseHash) {
      throw AppException(
        AppErrorCode.conflict,
        data: {'serverVersion': current.version},
      );
    }

    final students = {for (final s in _students[teacher.groupId]!) s.id: s};
    for (final grade in request.grades) {
      final student = students[grade.studentId];
      if (student == null) {
        throw AppException(
          AppErrorCode.studentNotFound,
          technicalDetails: grade.studentId,
        );
      }
      if (student.name != grade.studentName) {
        throw AppException(
          AppErrorCode.studentMismatch,
          technicalDetails: grade.studentId,
        );
      }
    }
    if (!GradeValidator.canSubmit(request.grades)) {
      throw const AppException(AppErrorCode.validationFailed);
    }

    for (final grade in request.grades) {
      block.cells[grade.studentId] = grade;
    }
    block
      ..version += 1
      ..status = SessionStatus.synced
      ..correctionComment = null;
    final result = SubmitResult(
      version: block.version,
      baseHash: block.hash(_students[teacher.groupId]!),
      status: SessionStatus.synced,
    );
    _idempotency[request.idempotencyKey] = result;
    return result;
  }

  @override
  Future<List<AppNotification>> listNotifications(
    String token, {
    DateTime? since,
  }) async {
    await _roundTrip();
    final user = _authenticate(token).user;
    if (user is! Teacher) return const [];
    return _notifications
        .where((n) =>
            n.groupId == user.groupId &&
            (since == null || n.createdAt.isAfter(since)))
        .toList();
  }

  // --------------------------------------------------------------- admin

  @override
  Future<List<AdminGroupRow>> adminDashboard(
    String token,
    DateOnly date,
  ) async {
    await _roundTrip();
    _requireAdmin(token);
    return [
      for (final group in _groups.values.where((g) => g.active))
        AdminGroupRow(
          group: group,
          sessionDate: date,
          status: _blocks[_key(group.groupId, date)]?.status,
          blockReady: _blocks.containsKey(_key(group.groupId, date)),
          studentCount: _students[group.groupId]?.length,
        ),
    ];
  }

  @override
  Future<ServerSession> adminGetSession(
    String token, {
    required String groupId,
    required DateOnly date,
  }) async {
    await _roundTrip();
    _requireAdmin(token);
    if (!_groups.containsKey(groupId)) {
      throw const AppException(AppErrorCode.groupNotFound);
    }
    return _readSession(groupId, date);
  }

  @override
  Future<void> adminValidate(
    String token, {
    required String groupId,
    required DateOnly date,
    required int expectedVersion,
  }) async {
    await _roundTrip();
    _requireAdmin(token);
    final block = _adminBlock(groupId, date, expectedVersion);
    block.status = SessionStatus.validated;
    _notify('SESSION_VALIDATED', groupId, date);
  }

  @override
  Future<void> adminRequestCorrection(
    String token, {
    required String groupId,
    required DateOnly date,
    required int expectedVersion,
    required String comment,
  }) async {
    await _roundTrip();
    _requireAdmin(token);
    if (comment.trim().isEmpty) {
      throw const AppException(AppErrorCode.badRequest);
    }
    final block = _adminBlock(groupId, date, expectedVersion);
    block
      ..status = SessionStatus.needsCorrection
      ..correctionComment = comment.trim();
    _notify('SESSION_NEEDS_CORRECTION', groupId, date, comment: comment.trim());
  }

  _MockBlock _adminBlock(String groupId, DateOnly date, int expectedVersion) {
    final block = _blocks[_key(groupId, date)];
    if (block == null) throw const AppException(AppErrorCode.sessionNotFound);
    if (block.status == SessionStatus.validated) {
      throw const AppException(AppErrorCode.sessionLocked);
    }
    if (block.version != expectedVersion) {
      throw AppException(
        AppErrorCode.conflict,
        data: {'serverVersion': block.version},
      );
    }
    return block;
  }

  void _notify(String type, String groupId, DateOnly date, {String? comment}) {
    _notifications.add(AppNotification(
      id: 'n${_notifications.length + 1}',
      type: type,
      createdAt: _clock(),
      groupId: groupId,
      sessionDate: date,
      comment: comment,
    ));
  }

  // ------------------------------------------------------------- helpers

  Future<void> _roundTrip() async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    if (offline) throw const AppException(AppErrorCode.network);
  }

  static String _key(String groupId, DateOnly date) => '$groupId|${date.toIso()}';

  // ---------------------------------------------------------------- seed

  void _seed() {
    void account(AppUser user, String pin) =>
        _accounts[user.email] = _MockAccount(user: user, pin: pin);

    void group(String id, String fr, String ar, String teacher) =>
        _groups[id] = Group(groupId: id, nameFr: fr, nameAr: ar, teacherName: teacher);

    group('G01', 'Hadid 1', 'الحديد 1', 'Enseignant Démo');
    group('G02', 'Hadid 2', 'الحديد 2', 'Enseignant B');
    group('G03', 'Tabarak 1', 'تبارك 1', 'Enseignant C');
    group('G04', 'Amma', 'جزء عم', 'Enseignant D');

    account(
      const Teacher(
        email: demoTeacherEmail,
        displayName: 'Enseignant Démo',
        groupId: 'G01',
        groupName: 'Hadid 1',
      ),
      demoTeacherPin,
    );
    account(
      const AdminUser(email: demoAdminEmail, displayName: 'Administration'),
      demoAdminPin,
    );

    void day(String iso, CalendarDayStatus status, [String? comment]) =>
        _calendar.add(SchoolSession(
          date: DateOnly.parse(iso),
          schoolYear: '2026-2027',
          term: 'T1',
          calendarStatus: status,
          comment: comment,
        ));
    day('2026-09-06', CalendarDayStatus.noClass, 'Pas de cours');
    for (final iso in [
      '2026-09-13', '2026-09-20', '2026-09-27', '2026-10-04', '2026-10-11',
      '2026-10-18', '2026-10-25', '2026-11-01', '2026-11-08', '2026-11-15',
      '2026-11-22', '2026-11-29', '2026-12-06', '2026-12-13',
    ]) {
      day(iso, CalendarDayStatus.classDay);
    }
    day('2026-12-20', CalendarDayStatus.noClass, 'Vacances');

    // Group G01 — the five reference cases of the specification (§39).
    final g01 = _students['G01'] = [
      _MockStudent('num:1', 'أحمد بن علي', 1),
      _MockStudent('num:2', 'Youssef Haddad', 2),
      _MockStudent('num:3', 'مريم السعيدي', 3),
      _MockStudent('num:4', 'Ilyes Trabelsi', 4),
      _MockStudent('num:5', 'سارة منصور', 5),
    ];
    StudentGrade g(
      _MockStudent s, {
      double? h,
      double? t,
      double? d,
      bool present = true,
      String? remark,
    }) =>
        StudentGrade(
          studentId: s.id,
          studentName: s.name,
          order: s.order,
          hifz: h,
          tajwid: t,
          discipline: d,
          attendance: present ? Attendance.present : Attendance.absent,
          remark: remark,
        );

    _blocks[_key('G01', DateOnly.parse('2026-09-13'))] = _MockBlock(1)
      ..status = SessionStatus.validated
      ..version = 2
      ..cells.addAll({
        for (final s in g01) s.id: g(s, h: 9, t: 9, d: 10),
      });
    _blocks[_key('G01', DateOnly.parse('2026-09-20'))] = _MockBlock(2)
      ..status = SessionStatus.synced
      ..version = 1
      ..cells.addAll({
        g01[0].id: g(g01[0], h: 9.5, t: 8.75, d: 10),
        g01[1].id: g(g01[1], h: 8, t: 8, d: 9),
        g01[2].id: g(g01[2], h: 9, t: 9.25, d: 10),
        g01[3].id: g(g01[3], present: false),
        g01[4].id: g(g01[4], h: 7.5, t: 8, d: 8),
      });
    // 2026-09-27: present with all grades / absent / not evaluated /
    // discipline < 7 with remark / discipline < 7 WITHOUT remark (blocks).
    _blocks[_key('G01', DateOnly.parse('2026-09-27'))] = _MockBlock(3)
      ..cells.addAll({
        g01[0].id: g(g01[0], h: 9.75, t: 9.25, d: 10),
        g01[1].id: g(g01[1], present: false),
        g01[2].id: g(g01[2]),
        g01[3].id: g(g01[3], h: 8, t: 8.5, d: 6.5,
            remark: 'Bavardages répétés pendant la récitation.'),
        g01[4].id: g(g01[4], h: 7, t: 7.5, d: 5),
      });

    // Other groups, for the admin dashboard.
    var n = 0;
    for (final groupId in ['G02', 'G03', 'G04']) {
      _students[groupId] = [
        for (var i = 1; i <= 4; i++) _MockStudent('num:$i', 'Élève ${++n}', i),
      ];
    }
    final sep27 = DateOnly.parse('2026-09-27');
    _blocks[_key('G02', sep27)] = _MockBlock(3);
    _blocks[_key('G03', sep27)] = _MockBlock(3)
      ..status = SessionStatus.synced
      ..version = 1
      ..cells.addAll({
        for (final s in _students['G03']!) s.id: g(s, h: 9, t: 8.5, d: 9.5),
      });
    _blocks[_key('G04', sep27)] = _MockBlock(3)
      ..status = SessionStatus.validated
      ..version = 1
      ..cells.addAll({
        for (final s in _students['G04']!) s.id: g(s, h: 10, t: 9, d: 10),
      });
  }
}

class _MockAccount {
  _MockAccount({required this.user, required this.pin});
  final AppUser user;
  final String pin;
  bool active = true;
}

class _MockStudent {
  _MockStudent(this.id, this.name, this.order);
  final String id;
  final String name;
  final int order;
}

/// The 4 columns of one "SÉANCE n" block + the notes of the discipline column.
class _MockBlock {
  _MockBlock(this.number);

  final int number;
  final Map<String, StudentGrade> cells = {};
  SessionStatus? status;
  int version = 0;
  String? correctionComment;

  /// Stand-in for the hash of the block values (real backend: SHA-256).
  String hash(List<_MockStudent> students) {
    final canonical = jsonEncode([
      for (final s in students) cells[s.id]?.toJson(),
    ]);
    var h = 0x811c9dc5;
    for (final unit in utf8.encode(canonical)) {
      h = ((h ^ unit) * 0x01000193) & 0xffffffff;
    }
    return h.toRadixString(16).padLeft(8, '0');
  }
}
