import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/grades/data/grades_repository.dart';
import '../../features/grades/domain/grade_validator.dart';
import '../../features/grades/domain/student_grade.dart';
import '../../features/sessions/domain/session_status.dart';
import '../api/api_client.dart';
import '../api/api_models.dart';
import '../auth/auth_controller.dart';
import '../database/app_database.dart';
import '../errors/app_error.dart';
import '../providers.dart';
import '../utils/date_only.dart';

abstract final class OutboxState {
  static const pending = 'PENDING';
  static const inFlight = 'IN_FLIGHT';
  static const done = 'DONE';
  static const failed = 'FAILED';
  static const conflict = 'CONFLICT';
}

/// Outcome of an upload attempt, for the UI.
enum SyncOutcome { synced, queuedOffline, conflict, locked, failed }

class SyncResult {
  const SyncResult(this.outcome, {this.error});
  final SyncOutcome outcome;
  final AppException? error;
}

/// Sends confirmed sessions to the server.
///
/// `submit` freezes a SUBMITTED snapshot and queues it in the outbox in one
/// transaction; the snapshot (never the mutable draft) is what gets uploaded
/// and retried. Nothing local is deleted when a request fails.
class SyncService {
  SyncService(this._db, this._api, this._token, this._clock, this._uuid);

  final AppDatabase _db;
  final ApiClient _api;
  final String Function() _token;
  final DateTime Function() _clock;
  final String Function() _uuid;

  bool _processing = false;

  /// Teacher confirmed "Envoyer".
  Future<SyncResult> submit(String sessionId) async {
    await _db.transaction(() async {
      final session = await _session(sessionId);
      final status = SessionStatus.fromWire(session.status);
      if (status.isLocked) throw const AppException(AppErrorCode.sessionLocked);
      if (status.isPendingUpload) {
        throw const AppException(AppErrorCode.sessionPendingUpload);
      }
      final grades = await _grades(sessionId);
      if (!GradeValidator.canSubmit(grades)) {
        throw const AppException(AppErrorCode.validationFailed);
      }
      final snapshotId = _uuid();
      final now = _clock();
      await _db.into(_db.snapshots).insert(SnapshotsCompanion.insert(
            id: snapshotId,
            sessionId: sessionId,
            kind: SnapshotKind.submitted,
            payloadJson: jsonEncode([for (final g in grades) g.toJson()]),
            serverVersionAt: session.serverVersion,
            createdAt: now,
          ));
      await _db.into(_db.outbox).insert(OutboxCompanion.insert(
            id: _uuid(),
            sessionId: sessionId,
            snapshotId: snapshotId,
            idempotencyKey: _uuid(),
            state: OutboxState.pending,
            createdAt: now,
          ));
      await _updateSession(sessionId, status: SessionStatus.sent);
    });
    final results = await processOutbox(onlySessionId: sessionId);
    return results.isEmpty ? const SyncResult(SyncOutcome.failed) : results.first;
  }

  /// Removes a queued upload that has not been sent yet, back to DRAFT.
  Future<void> cancelPendingUpload(String sessionId) =>
      _db.transaction(() async {
        await (_db.delete(_db.outbox)
              ..where((o) =>
                  o.sessionId.equals(sessionId) &
                  o.state.isIn([OutboxState.pending, OutboxState.failed])))
            .go();
        await _updateSession(sessionId, status: SessionStatus.draft);
      });

  /// Uploads every pending item (also called when the network comes back).
  Future<List<SyncResult>> processOutbox({String? onlySessionId}) async {
    if (_processing) return const [];
    _processing = true;
    try {
      final query = _db.select(_db.outbox)
        // IN_FLIGHT left by a crash is safe to resend (idempotency key).
        ..where((o) => o.state.isIn(
            [OutboxState.pending, OutboxState.inFlight, OutboxState.failed]))
        ..orderBy([(o) => OrderingTerm.asc(o.createdAt)]);
      if (onlySessionId != null) {
        query.where((o) => o.sessionId.equals(onlySessionId));
      }
      return [for (final item in await query.get()) await _upload(item)];
    } finally {
      _processing = false;
    }
  }

  Stream<int> watchPendingUploads() {
    final count = _db.outbox.id.count();
    final query = _db.selectOnly(_db.outbox)
      ..addColumns([count])
      ..where(_db.outbox.state
          .isIn([OutboxState.pending, OutboxState.inFlight, OutboxState.failed]));
    return query.map((r) => r.read(count) ?? 0).watchSingle();
  }

  Future<SyncResult> _upload(OutboxRow item) async {
    final session = await _session(item.sessionId);
    final snapshot = await (_db.select(_db.snapshots)
          ..where((s) => s.id.equals(item.snapshotId)))
        .getSingle();
    final grades = [
      for (final g in jsonDecode(snapshot.payloadJson) as List<Object?>)
        StudentGrade.fromJson(g! as Map<String, Object?>),
    ];
    await _setOutbox(item.id, OutboxState.inFlight, attempts: item.attempts + 1);

    try {
      final result = await _api.submitSession(
        _token(),
        SubmitRequest(
          groupId: session.groupId,
          sessionDate: DateOnly.parse(session.sessionDate),
          baseVersion: session.serverVersion,
          baseHash: session.baseHash,
          idempotencyKey: item.idempotencyKey,
          grades: grades,
        ),
      );
      await _db.transaction(() async {
        await _setOutbox(item.id, OutboxState.done);
        await (_db.update(_db.snapshots)..where((s) => s.id.equals(snapshot.id)))
            .write(const SnapshotsCompanion(result: Value('OK')));
        await _db.into(_db.snapshots).insert(SnapshotsCompanion.insert(
              id: _uuid(),
              sessionId: item.sessionId,
              kind: SnapshotKind.base,
              payloadJson: snapshot.payloadJson,
              serverVersionAt: result.version,
              createdAt: _clock(),
            ));
        await (_db.update(_db.studentGradesLocal)
              ..where((g) => g.sessionId.equals(item.sessionId)))
            .write(const StudentGradesLocalCompanion(dirty: Value(false)));
        await _updateSession(
          item.sessionId,
          status: result.status,
          serverStatus: result.status,
          serverVersion: result.version,
          baseHash: result.baseHash,
          synchronizedAt: _clock(),
          lastSyncError: null,
        );
      });
      return const SyncResult(SyncOutcome.synced);
    } on AppException catch (e) {
      return _handleFailure(item, snapshot, e);
    } on Object catch (e) {
      return _handleFailure(item, snapshot,
          AppException(AppErrorCode.internal, technicalDetails: '$e'));
    }
  }

  Future<SyncResult> _handleFailure(
    OutboxRow item,
    SnapshotRow snapshot,
    AppException e,
  ) async {
    switch (e.code) {
      case AppErrorCode.network ||
            AppErrorCode.timeout ||
            AppErrorCode.authRequired ||
            AppErrorCode.authExpired:
        // Kept queued: resent when the network is back / after sign-in.
        await _setOutbox(item.id, OutboxState.pending, error: e.code.wire);
        await _updateSession(item.sessionId, lastSyncError: e.code.wire);
        return SyncResult(SyncOutcome.queuedOffline, error: e);
      case AppErrorCode.conflict:
        await _db.transaction(() async {
          await _setOutbox(item.id, OutboxState.conflict, error: e.code.wire);
          await _markSnapshot(snapshot.id, 'CONFLICT');
          await _updateSession(item.sessionId,
              status: SessionStatus.draft, lastSyncError: e.code.wire);
        });
        return SyncResult(SyncOutcome.conflict, error: e);
      case AppErrorCode.sessionLocked:
        await _db.transaction(() async {
          await _setOutbox(item.id, OutboxState.done, error: e.code.wire);
          await _markSnapshot(snapshot.id, 'ERROR:${e.code.wire}');
          await _updateSession(item.sessionId,
              status: SessionStatus.validated,
              serverStatus: SessionStatus.validated,
              lastSyncError: e.code.wire);
        });
        return SyncResult(SyncOutcome.locked, error: e);
      default:
        // Transient errors stay queued; others go back to DRAFT so the
        // teacher can act. The draft is never deleted.
        await _db.transaction(() async {
          await _setOutbox(
            item.id,
            e.code.isTransient ? OutboxState.failed : OutboxState.conflict,
            error: e.code.wire,
          );
          if (!e.code.isTransient) {
            await _markSnapshot(snapshot.id, 'ERROR:${e.code.wire}');
          }
          await _updateSession(
            item.sessionId,
            status: e.code.isTransient ? null : SessionStatus.draft,
            lastSyncError: e.code.wire,
          );
        });
        return SyncResult(SyncOutcome.failed, error: e);
    }
  }

  // ------------------------------------------------------------ helpers

  Future<SessionRow> _session(String id) =>
      (_db.select(_db.sessionsLocal)..where((s) => s.id.equals(id))).getSingle();

  Future<List<StudentGrade>> _grades(String sessionId) async => [
        for (final r in await (_db.select(_db.studentGradesLocal)
              ..where((g) => g.sessionId.equals(sessionId))
              ..orderBy([(g) => OrderingTerm.asc(g.sortOrder)]))
            .get())
          GradesRepository.gradeFromRow(r),
      ];

  Future<void> _setOutbox(
    String id,
    String state, {
    int? attempts,
    String? error,
  }) =>
      (_db.update(_db.outbox)..where((o) => o.id.equals(id)))
          .write(OutboxCompanion(
        state: Value(state),
        attempts: attempts == null ? const Value.absent() : Value(attempts),
        lastError: Value(error),
      ));

  Future<void> _markSnapshot(String id, String result) =>
      (_db.update(_db.snapshots)..where((s) => s.id.equals(id)))
          .write(SnapshotsCompanion(result: Value(result)));

  static const _keep = Object();

  /// Updates only the given fields (`lastSyncError: null` clears it).
  Future<void> _updateSession(
    String id, {
    SessionStatus? status,
    SessionStatus? serverStatus,
    int? serverVersion,
    String? baseHash,
    DateTime? synchronizedAt,
    Object? lastSyncError = _keep,
  }) =>
      (_db.update(_db.sessionsLocal)..where((s) => s.id.equals(id)))
          .write(SessionsLocalCompanion(
        status: status == null ? const Value.absent() : Value(status.wire),
        serverStatus:
            serverStatus == null ? const Value.absent() : Value(serverStatus.wire),
        serverVersion:
            serverVersion == null ? const Value.absent() : Value(serverVersion),
        baseHash: baseHash == null ? const Value.absent() : Value(baseHash),
        synchronizedAt:
            synchronizedAt == null ? const Value.absent() : Value(synchronizedAt),
        lastSyncError: identical(lastSyncError, _keep)
            ? const Value.absent()
            : Value(lastSyncError as String?),
        updatedAt: Value(_clock()),
      ));
}

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(
    ref.watch(databaseProvider),
    ref.watch(apiClientProvider),
    ref.watch(authTokenProvider),
    ref.watch(clockProvider),
    ref.watch(uuidProvider),
  ),
);

final pendingUploadsProvider = StreamProvider<int>(
  (ref) => ref.watch(syncServiceProvider).watchPendingUploads(),
);
