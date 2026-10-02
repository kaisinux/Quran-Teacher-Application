import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_models.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/database/app_database.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/providers.dart';
import '../../../core/utils/date_only.dart';
import '../../sessions/domain/session_status.dart';
import '../domain/grade_validator.dart';
import '../domain/session_grades.dart';
import '../domain/student_grade.dart';

abstract final class SnapshotKind {
  static const base = 'BASE';
  static const submitted = 'SUBMITTED';
  static const conflictLocal = 'CONFLICT_LOCAL';
}

/// Local-first access to the grades of a session.
///
/// Every edit is written to SQLite immediately, in a transaction. Nothing
/// is sent to the server from here (see `SyncService`).
class GradesRepository {
  GradesRepository(this._db, this._api, this._token, this._clock, this._uuid);

  final AppDatabase _db;
  final ApiClient _api;
  final String Function() _token;
  final DateTime Function() _clock;
  final String Function() _uuid;

  /// Returns the local id of the session, downloading it when needed.
  /// Offline without a local copy → `OFFLINE_NO_LOCAL_COPY`.
  Future<String> openSession(String groupId, DateOnly date) async {
    final existing = await _findRow(groupId, date);
    if (existing != null) return existing.id;
    final ServerSession server;
    try {
      server = await _api.getSession(_token(), date);
    } on AppException catch (e) {
      if (e.code == AppErrorCode.network || e.code == AppErrorCode.timeout) {
        throw const AppException(AppErrorCode.offlineNoLocalCopy);
      }
      rethrow;
    }
    return _db.transaction(() async {
      final id = _uuid();
      await _insertServerSession(id, server);
      return id;
    });
  }

  /// Replaces local data with the server state (after a conflict, or on
  /// request). Local values are kept in a CONFLICT_LOCAL snapshot.
  Future<void> reloadFromServer(String sessionId) async {
    final row = await _row(sessionId);
    final server = await _api.getSession(_token(), DateOnly.parse(row.sessionDate));
    final local = await _grades(sessionId);
    await _db.transaction(() async {
      await _addSnapshot(sessionId, SnapshotKind.conflictLocal, local,
          row.serverVersion);
      await (_db.delete(_db.outbox)..where((o) => o.sessionId.equals(sessionId)))
          .go();
      await _insertServerSession(sessionId, server, replace: true);
    });
  }

  Stream<SessionGrades?> watchSession(String sessionId) {
    final sessionQuery = _db.select(_db.sessionsLocal)
      ..where((s) => s.id.equals(sessionId));
    return sessionQuery.watchSingleOrNull().asyncMap((row) async {
      if (row == null) return null;
      return _toDomain(row, await _gradeRows(sessionId));
    });
  }

  /// Sessions stored on the device, newest first ("Mes séances").
  Stream<List<SessionGrades>> watchLocalSessions() {
    final query = _db.select(_db.sessionsLocal)
      ..orderBy([(s) => OrderingTerm.desc(s.sessionDate)]);
    return query.watch().asyncMap((rows) async => [
          for (final row in rows) _toDomain(row, await _gradeRows(row.id)),
        ]);
  }

  /// Number of locally modified students not yet synchronized.
  Stream<int> watchPendingChanges() {
    final count = _db.studentGradesLocal.studentId.count();
    final query = _db.selectOnly(_db.studentGradesLocal)
      ..addColumns([count])
      ..where(_db.studentGradesLocal.dirty.equals(true));
    return query.map((r) => r.read(count) ?? 0).watchSingle();
  }

  /// Saves one student's grades (automatic absence rule applied).
  Future<void> updateGrade(String sessionId, StudentGrade grade) =>
      _db.transaction(() async {
        final row = await _row(sessionId);
        final status = SessionStatus.fromWire(row.status);
        if (status.isLocked) {
          throw const AppException(AppErrorCode.sessionLocked);
        }
        if (status.isPendingUpload) {
          throw const AppException(AppErrorCode.sessionPendingUpload);
        }
        final normalized = GradeValidator.normalize(grade);
        final now = _clock();
        await (_db.update(_db.studentGradesLocal)
              ..where((g) =>
                  g.sessionId.equals(sessionId) &
                  g.studentId.equals(grade.studentId)))
            .write(StudentGradesLocalCompanion(
          hifz: Value(normalized.hifz),
          tajwid: Value(normalized.tajwid),
          discipline: Value(normalized.discipline),
          attendance: Value(normalized.attendance.wire),
          remark: Value(normalized.normalizedRemark),
          dirty: const Value(true),
          updatedAt: Value(now),
        ));
        await (_db.update(_db.sessionsLocal)..where((s) => s.id.equals(sessionId)))
            .write(SessionsLocalCompanion(
          status: Value(status.afterTeacherEdit().wire),
          updatedAt: Value(now),
        ));
      });

  /// "Vérifier la séance" succeeded: DRAFT → READY.
  Future<List<ValidationIssue>> review(String sessionId) async {
    final row = await _row(sessionId);
    final grades = await _grades(sessionId);
    final issues = GradeValidator.validateSessionBeforeSubmit(grades);
    final status = SessionStatus.fromWire(row.status);
    if (!issues.any((i) => i.isBlocking) && status == SessionStatus.draft) {
      await _setStatus(sessionId, SessionStatus.ready);
    }
    return issues;
  }

  // ------------------------------------------------------------ internals

  Future<SessionRow?> _findRow(String groupId, DateOnly date) =>
      (_db.select(_db.sessionsLocal)
            ..where((s) =>
                s.groupId.equals(groupId) & s.sessionDate.equals(date.toIso())))
          .getSingleOrNull();

  Future<SessionRow> _row(String sessionId) async {
    final row = await (_db.select(_db.sessionsLocal)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();
    if (row == null) throw const AppException(AppErrorCode.sessionNotFound);
    return row;
  }

  Future<List<GradeRow>> _gradeRows(String sessionId) =>
      (_db.select(_db.studentGradesLocal)
            ..where((g) => g.sessionId.equals(sessionId))
            ..orderBy([(g) => OrderingTerm.asc(g.sortOrder)]))
          .get();

  Future<List<StudentGrade>> _grades(String sessionId) async =>
      [for (final r in await _gradeRows(sessionId)) gradeFromRow(r)];

  Future<void> _setStatus(String sessionId, SessionStatus status) =>
      (_db.update(_db.sessionsLocal)..where((s) => s.id.equals(sessionId)))
          .write(SessionsLocalCompanion(
        status: Value(status.wire),
        updatedAt: Value(_clock()),
      ));

  /// Stores a server session under [id]. With [replace], the existing row
  /// is updated in place so its snapshots survive.
  Future<void> _insertServerSession(
    String id,
    ServerSession server, {
    bool replace = false,
  }) async {
    final now = _clock();
    final session = SessionsLocalCompanion(
      id: Value(id),
      groupId: Value(server.groupId),
      sessionDate: Value(server.sessionDate.toIso()),
      sessionNumber: Value(server.sessionNumber),
      status: Value((server.status ?? SessionStatus.draft).wire),
      serverStatus: Value(server.status?.wire),
      serverVersion: Value(server.version),
      baseHash: Value(server.baseHash),
      correctionComment: Value(server.correctionComment),
      lastSyncError: const Value(null),
      updatedAt: Value(now),
      synchronizedAt: Value(server.status == null ? null : now),
    );
    if (replace) {
      await (_db.update(_db.sessionsLocal)..where((s) => s.id.equals(id)))
          .write(session);
      await (_db.delete(_db.studentGradesLocal)
            ..where((g) => g.sessionId.equals(id)))
          .go();
    } else {
      await _db
          .into(_db.sessionsLocal)
          .insert(session.copyWith(createdAt: Value(now)));
    }
    await _db.batch((b) => b.insertAll(_db.studentGradesLocal, [
          for (final g in server.grades)
            StudentGradesLocalCompanion.insert(
              sessionId: id,
              studentId: g.studentId,
              studentName: g.studentName,
              sortOrder: g.order,
              hifz: Value(g.hifz),
              tajwid: Value(g.tajwid),
              discipline: Value(g.discipline),
              attendance: g.attendance.wire,
              remark: Value(g.normalizedRemark),
              updatedAt: now,
            ),
        ]));
    await _addSnapshot(id, SnapshotKind.base, server.grades, server.version);
  }

  Future<void> _addSnapshot(
    String sessionId,
    String kind,
    List<StudentGrade> grades,
    int version,
  ) =>
      _db.into(_db.snapshots).insert(SnapshotsCompanion.insert(
            id: _uuid(),
            sessionId: sessionId,
            kind: kind,
            payloadJson: jsonEncode([for (final g in grades) g.toJson()]),
            serverVersionAt: version,
            createdAt: _clock(),
          ));

  static StudentGrade gradeFromRow(GradeRow r) => StudentGrade(
        studentId: r.studentId,
        studentName: r.studentName,
        order: r.sortOrder,
        hifz: r.hifz,
        tajwid: r.tajwid,
        discipline: r.discipline,
        attendance: Attendance.fromWire(r.attendance),
        remark: r.remark,
      );

  static SessionGrades _toDomain(SessionRow row, List<GradeRow> grades) =>
      SessionGrades(
        localId: row.id,
        groupId: row.groupId,
        sessionDate: DateOnly.parse(row.sessionDate),
        sessionNumber: row.sessionNumber,
        status: SessionStatus.fromWire(row.status),
        serverStatus: SessionStatus.tryFromWire(row.serverStatus),
        serverVersion: row.serverVersion,
        baseHash: row.baseHash,
        correctionComment: row.correctionComment,
        pendingChanges: grades.where((g) => g.dirty).length,
        lastSyncError: row.lastSyncError,
        updatedAt: row.updatedAt,
        synchronizedAt: row.synchronizedAt,
        grades: [for (final g in grades) gradeFromRow(g)],
      );
}

final gradesRepositoryProvider = Provider<GradesRepository>(
  (ref) => GradesRepository(
    ref.watch(databaseProvider),
    ref.watch(apiClientProvider),
    ref.watch(authTokenProvider),
    ref.watch(clockProvider),
    ref.watch(uuidProvider),
  ),
);

final sessionGradesProvider =
    StreamProvider.family<SessionGrades?, String>(
  (ref, sessionId) =>
      ref.watch(gradesRepositoryProvider).watchSession(sessionId),
);

final localSessionsProvider = StreamProvider<List<SessionGrades>>(
  (ref) => ref.watch(gradesRepositoryProvider).watchLocalSessions(),
);

final pendingChangesProvider = StreamProvider<int>(
  (ref) => ref.watch(gradesRepositoryProvider).watchPendingChanges(),
);
