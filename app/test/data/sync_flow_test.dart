import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misk_teacher/core/api/api_models.dart';
import 'package:misk_teacher/core/api/mock_api_client.dart';
import 'package:misk_teacher/core/database/app_database.dart';
import 'package:misk_teacher/core/errors/app_error.dart';
import 'package:misk_teacher/core/sync/sync_service.dart';
import 'package:misk_teacher/core/utils/date_only.dart';
import 'package:misk_teacher/features/grades/data/grades_repository.dart';
import 'package:misk_teacher/features/grades/domain/student_grade.dart';
import 'package:misk_teacher/features/sessions/domain/session_status.dart';
import 'package:uuid/uuid.dart';

/// One teacher device: its own database, sharing the mock server.
class _Device {
  _Device(this.api, this.token)
      : db = AppDatabase(DatabaseConnection(
          NativeDatabase.memory(),
          closeStreamsSynchronously: true,
        )) {
    grades = GradesRepository(db, api, () => token, DateTime.now, const Uuid().v4);
    sync = SyncService(db, api, () => token, DateTime.now, const Uuid().v4);
  }

  final MockApiClient api;
  final String token;
  final AppDatabase db;
  late final GradesRepository grades;
  late final SyncService sync;

  Future<List<StudentGrade>> gradesOf(String id) async =>
      (await grades.watchSession(id).first)!.grades;

  Future<SessionStatus> statusOf(String id) async =>
      (await grades.watchSession(id).first)!.status;
}

final sep27 = DateOnly.parse('2026-09-27');

void main() {
  // Two simulated devices = two separate in-memory databases, on purpose.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late MockApiClient api;
  late String teacherToken;
  late String adminToken;
  late _Device device;

  setUp(() async {
    api = MockApiClient(latency: Duration.zero);
    teacherToken = (await api.authPin(
      email: MockApiClient.demoTeacherEmail,
      pin: MockApiClient.demoTeacherPin,
    ))
        .token;
    adminToken = (await api.authPin(
      email: MockApiClient.demoAdminEmail,
      pin: MockApiClient.demoAdminPin,
    ))
        .token;
    device = _Device(api, teacherToken);
  });

  tearDown(() => device.db.close());

  /// Fixes the blocking case of the mock data (discipline 5 without remark).
  Future<String> openValidSession(_Device d) async {
    final id = await d.grades.openSession('G01', sep27);
    final sara = (await d.gradesOf(id))[4];
    await d.grades.updateGrade(id, sara.copyWith(remark: () => 'Agitation.'));
    return id;
  }

  test('download keeps sheet order and the five reference cases', () async {
    final id = await device.grades.openSession('G01', sep27);
    final grades = await device.gradesOf(id);
    expect(grades.map((g) => g.order), [1, 2, 3, 4, 5]);
    expect(grades[1].isPresent, isFalse);
    expect([grades[2].hifz, grades[2].tajwid, grades[2].discipline], everyElement(isNull));
    expect(grades[3].remark, isNotNull);
    expect(await device.statusOf(id), SessionStatus.draft);
  });

  test('discipline < 7 without remark blocks the upload', () async {
    final id = await device.grades.openSession('G01', sep27);
    expect(
      () => device.sync.submit(id),
      throwsA(isA<AppException>()
          .having((e) => e.code, 'code', AppErrorCode.validationFailed)),
    );
  });

  test('submit → SYNCED, then edit → DRAFT and resubmit without conflict', () async {
    final id = await openValidSession(device);
    expect((await device.grades.watchSession(id).first)!.pendingChanges, 1);

    final first = await device.sync.submit(id);
    expect(first.outcome, SyncOutcome.synced);
    var session = (await device.grades.watchSession(id).first)!;
    expect(session.status, SessionStatus.synced);
    expect(session.serverVersion, 1);
    expect(session.pendingChanges, 0);

    final ahmed = session.grades.first;
    await device.grades.updateGrade(id, ahmed.copyWith(hifz: () => 8.5));
    expect(await device.statusOf(id), SessionStatus.draft);

    final second = await device.sync.submit(id);
    expect(second.outcome, SyncOutcome.synced);
    session = (await device.grades.watchSession(id).first)!;
    expect(session.serverVersion, 2);
    expect(session.grades.first.hifz, 8.5);
  });

  test('marking a student absent clears his grades locally', () async {
    final id = await device.grades.openSession('G01', sep27);
    final ahmed = (await device.gradesOf(id)).first;
    await device.grades.updateGrade(id, ahmed.copyWith(attendance: Attendance.absent));
    final updated = (await device.gradesOf(id)).first;
    expect([updated.hifz, updated.tajwid, updated.discipline], everyElement(isNull));
  });

  test('newer server version → CONFLICT, local values kept, reload restores', () async {
    final other = _Device(api, teacherToken);
    addTearDown(other.db.close);

    final id = await openValidSession(device);
    final otherId = await openValidSession(other);
    expect((await other.sync.submit(otherId)).outcome, SyncOutcome.synced);

    final ahmed = (await device.gradesOf(id)).first;
    await device.grades.updateGrade(id, ahmed.copyWith(tajwid: () => 6));
    final result = await device.sync.submit(id);
    expect(result.outcome, SyncOutcome.conflict);
    expect(await device.statusOf(id), SessionStatus.draft);
    expect((await device.gradesOf(id)).first.tajwid, 6, reason: 'never overwritten');

    await device.grades.reloadFromServer(id);
    final reloaded = (await device.grades.watchSession(id).first)!;
    expect(reloaded.serverVersion, 1);
    expect(reloaded.grades.first.tajwid, 9.25);
    final kept = await (device.db.select(device.db.snapshots)
          ..where((s) => s.kind.equals(SnapshotKind.conflictLocal)))
        .get();
    expect(kept, hasLength(1));
  });

  test('offline: upload queued, editing blocked, sent when back online', () async {
    final id = await openValidSession(device);
    api.offline = true;
    final queued = await device.sync.submit(id);
    expect(queued.outcome, SyncOutcome.queuedOffline);
    expect(await device.statusOf(id), SessionStatus.sent);
    expect(
      () async => device.grades.updateGrade(id, (await device.gradesOf(id)).first),
      throwsA(isA<AppException>()
          .having((e) => e.code, 'code', AppErrorCode.sessionPendingUpload)),
    );

    api.offline = false;
    final results = await device.sync.processOutbox();
    expect(results.single.outcome, SyncOutcome.synced);
    expect(await device.statusOf(id), SessionStatus.synced);
  });

  test('cancel a queued upload goes back to DRAFT', () async {
    final id = await openValidSession(device);
    api.offline = true;
    await device.sync.submit(id);
    await device.sync.cancelPendingUpload(id);
    expect(await device.statusOf(id), SessionStatus.draft);
    expect(await device.sync.processOutbox(), isEmpty);
  });

  test('VALIDATED by the admin: upload refused and session locked', () async {
    final id = await openValidSession(device);
    await device.sync.submit(id);
    final server = await api.adminGetSession(adminToken, groupId: 'G01', date: sep27);
    await api.adminValidate(adminToken,
        groupId: 'G01', date: sep27, expectedVersion: server.version);

    // A second device still holding a draft.
    final other = _Device(api, teacherToken);
    addTearDown(other.db.close);
    // Opening reads the locked status from the server.
    final otherId = await other.grades.openSession('G01', sep27);
    expect(await other.statusOf(otherId), SessionStatus.validated);
    expect(
      () async => other.grades.updateGrade(otherId, (await other.gradesOf(otherId)).first),
      throwsA(isA<AppException>()
          .having((e) => e.code, 'code', AppErrorCode.sessionLocked)),
    );

    // The first device edits its stale copy then tries to send.
    final ahmed = (await device.gradesOf(id)).first;
    await device.grades.updateGrade(id, ahmed.copyWith(hifz: () => 7));
    final result = await device.sync.submit(id);
    expect(result.outcome, SyncOutcome.locked);
    expect(await device.statusOf(id), SessionStatus.validated);
  });

  group('server authorization (mock mirrors the backend rules)', () {
    test('a teacher cannot write another group', () async {
      final session = await api.getSession(teacherToken, sep27);
      expect(
        () => api.submitSession(
          teacherToken,
          SubmitRequest(
            groupId: 'G02',
            sessionDate: sep27,
            baseVersion: session.version,
            baseHash: session.baseHash,
            idempotencyKey: 'x',
            grades: const [],
          ),
        ),
        throwsA(isA<AppException>()
            .having((e) => e.code, 'code', AppErrorCode.forbiddenGroup)),
      );
    });

    test('a teacher cannot call admin actions', () {
      expect(
        () => api.adminDashboard(teacherToken, sep27),
        throwsA(isA<AppException>()
            .having((e) => e.code, 'code', AppErrorCode.notAuthorized)),
      );
    });

    test('an unknown PIN is rejected, then rate limited', () async {
      for (var i = 0; i < 5; i++) {
        await expectLater(
          api.authPin(email: MockApiClient.demoTeacherEmail, pin: '00000'),
          throwsA(isA<AppException>()
              .having((e) => e.code, 'code', AppErrorCode.invalidCredentials)),
        );
      }
      await expectLater(
        api.authPin(
            email: MockApiClient.demoTeacherEmail, pin: MockApiClient.demoTeacherPin),
        throwsA(isA<AppException>()
            .having((e) => e.code, 'code', AppErrorCode.rateLimited)),
      );
    });

    test('a block without date in row 4 is not ready', () {
      expect(
        () => api.getSession(teacherToken, DateOnly.parse('2026-10-04')),
        throwsA(isA<AppException>()
            .having((e) => e.code, 'code', AppErrorCode.sessionBlockNotReady)),
      );
    });

    test('same idempotency key twice: written once', () async {
      final s = await api.getSession(teacherToken, DateOnly.parse('2026-09-20'));
      final request = SubmitRequest(
        groupId: 'G01',
        sessionDate: s.sessionDate,
        baseVersion: s.version,
        baseHash: s.baseHash,
        idempotencyKey: 'same',
        grades: s.grades,
      );
      final a = await api.submitSession(teacherToken, request);
      final b = await api.submitSession(teacherToken, request);
      expect(b.version, a.version);
    });
  });
}
