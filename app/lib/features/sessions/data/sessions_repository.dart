import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../../core/utils/date_only.dart';
import '../domain/school_session.dart';
import '../domain/session_status.dart';

const _groupKey = 'teacher.group';

/// Calendar of the teacher's group, cached for offline use.
class SessionsRepository {
  SessionsRepository(this._db, this._api, this._token, this._clock);

  final AppDatabase _db;
  final ApiClient _api;
  final String Function() _token;
  final DateTime Function() _clock;

  /// Downloads `sessions.list` + notifications, replaces the cache and
  /// applies admin decisions (validation, correction) to local sessions.
  Future<void> refresh() async {
    final overview = await _api.listSessions(_token());
    final notifications = await _api.listNotifications(
      _token(),
      since: await _lastNotificationAt(),
    );
    final now = _clock();
    await _db.transaction(() async {
      for (final n in notifications) {
        await _db.into(_db.notifications).insertOnConflictUpdate(
              NotificationsCompanion.insert(
                id: n.id,
                type: n.type,
                sessionDate: Value(n.sessionDate?.toIso()),
                comment: Value(n.comment),
                createdAt: n.createdAt,
              ),
            );
      }
      for (final s in overview.sessions) {
        await _reconcileLocal(overview.group.groupId, s);
      }
      await _db.delete(_db.calendarCache).go();
      await _db.batch((b) => b.insertAll(_db.calendarCache, [
            for (final s in overview.sessions)
              CalendarCacheCompanion.insert(
                date: s.date.toIso(),
                schoolYear: s.schoolYear,
                term: s.term,
                calendarStatus: s.calendarStatus.wire,
                comment: Value(s.comment),
                blockReady: Value(s.blockReady),
                serverStatus: Value(s.serverStatus?.wire),
                serverVersion: Value(s.serverVersion),
                fetchedAt: now,
              ),
          ]));
      await _db.writeKv(_groupKey, jsonEncode(overview.group.toJson()));
    });
  }

  /// Admin decisions win over local state: VALIDATED locks the session;
  /// NEEDS_CORRECTION replaces SYNCED when the teacher has no local edits.
  Future<void> _reconcileLocal(String groupId, SchoolSession s) async {
    final serverStatus = s.serverStatus;
    if (serverStatus == null) return;
    final local = await (_db.select(_db.sessionsLocal)
          ..where((l) =>
              l.groupId.equals(groupId) & l.sessionDate.equals(s.date.toIso())))
        .getSingleOrNull();
    if (local == null) return;
    final localStatus = SessionStatus.fromWire(local.status);
    final SessionStatus? next = switch (serverStatus) {
      SessionStatus.validated => SessionStatus.validated,
      SessionStatus.needsCorrection when localStatus == SessionStatus.synced =>
        SessionStatus.needsCorrection,
      _ => null,
    };
    await (_db.update(_db.sessionsLocal)..where((l) => l.id.equals(local.id)))
        .write(SessionsLocalCompanion(
      serverStatus: Value(serverStatus.wire),
      status: next == null ? const Value.absent() : Value(next.wire),
    ));
  }

  Future<DateTime?> _lastNotificationAt() async {
    final latest = await (_db.select(_db.notifications)
          ..orderBy([(n) => OrderingTerm.desc(n.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return latest?.createdAt;
  }

  Stream<List<NotificationRow>> watchUnreadNotifications() =>
      (_db.select(_db.notifications)
            ..where((n) => n.read.equals(false))
            ..orderBy([(n) => OrderingTerm.desc(n.createdAt)]))
          .watch();

  Future<void> markNotificationRead(String id) =>
      (_db.update(_db.notifications)..where((n) => n.id.equals(id)))
          .write(const NotificationsCompanion(read: Value(true)));

  Stream<List<SchoolSession>> watchCalendar() =>
      (_db.select(_db.calendarCache)..orderBy([(c) => OrderingTerm.asc(c.date)]))
          .watch()
          .map((rows) => [for (final r in rows) _toDomain(r)]);

  Future<Group?> cachedGroup() async {
    final raw = await _db.readKv(_groupKey);
    return raw == null
        ? null
        : Group.fromJson(jsonDecode(raw) as Map<String, Object?>);
  }

  static SchoolSession _toDomain(CalendarRow r) => SchoolSession(
        date: DateOnly.parse(r.date),
        schoolYear: r.schoolYear,
        term: r.term,
        calendarStatus: CalendarDayStatus.fromWire(r.calendarStatus),
        comment: r.comment,
        blockReady: r.blockReady,
        serverStatus: SessionStatus.tryFromWire(r.serverStatus),
        serverVersion: r.serverVersion,
      );
}

final sessionsRepositoryProvider = Provider<SessionsRepository>(
  (ref) => SessionsRepository(
    ref.watch(databaseProvider),
    ref.watch(apiClientProvider),
    ref.watch(authTokenProvider),
    ref.watch(clockProvider),
  ),
);

final calendarProvider = StreamProvider<List<SchoolSession>>(
  (ref) => ref.watch(sessionsRepositoryProvider).watchCalendar(),
);

final unreadNotificationsProvider = StreamProvider<List<NotificationRow>>(
  (ref) => ref.watch(sessionsRepositoryProvider).watchUnreadNotifications(),
);

/// Refreshes calendar + notifications; failures (offline) keep the cache.
final calendarRefreshProvider = FutureProvider<void>(
  (ref) => ref.watch(sessionsRepositoryProvider).refresh(),
);
