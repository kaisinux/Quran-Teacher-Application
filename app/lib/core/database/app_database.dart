import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// One downloaded session of the teacher's group (architecture §5).
@DataClassName('SessionRow')
class SessionsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text()();

  /// `YYYY-MM-DD`.
  TextColumn get sessionDate => text()();
  IntColumn get sessionNumber => integer().nullable()();

  /// `SessionStatus.wire`.
  TextColumn get status => text()();
  TextColumn get serverStatus => text().nullable()();
  IntColumn get serverVersion => integer().withDefault(const Constant(0))();
  TextColumn get baseHash => text().nullable()();
  TextColumn get correctionComment => text().nullable()();
  TextColumn get lastSyncError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get synchronizedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {groupId, sessionDate},
      ];
}

@DataClassName('GradeRow')
class StudentGradesLocal extends Table {
  TextColumn get sessionId =>
      text().references(SessionsLocal, #id, onDelete: KeyAction.cascade)();
  TextColumn get studentId => text()();
  TextColumn get studentName => text()();

  /// Sheet order, never alphabetical.
  IntColumn get sortOrder => integer()();
  RealColumn get hifz => real().nullable()();
  RealColumn get tajwid => real().nullable()();
  RealColumn get discipline => real().nullable()();

  /// `Attendance.wire`.
  TextColumn get attendance => text()();
  TextColumn get remark => text().nullable()();

  /// Changed locally since the last download / sync.
  BoolColumn get dirty => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {sessionId, studentId};
}

/// Frozen copies: BASE (server state), SUBMITTED (what is/was uploaded),
/// CONFLICT_LOCAL (local values kept after a conflict).
@DataClassName('SnapshotRow')
class Snapshots extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(SessionsLocal, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  TextColumn get payloadJson => text()();
  IntColumn get serverVersionAt => integer()();
  TextColumn get result => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Confirmed uploads waiting for (or done with) the server.
@DataClassName('OutboxRow')
class Outbox extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(SessionsLocal, #id, onDelete: KeyAction.cascade)();
  TextColumn get snapshotId => text().references(Snapshots, #id)();
  TextColumn get idempotencyKey => text().unique()();

  /// PENDING | IN_FLIGHT | DONE | FAILED | CONFLICT.
  TextColumn get state => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CalendarRow')
class CalendarCache extends Table {
  TextColumn get date => text()();
  TextColumn get schoolYear => text()();
  TextColumn get term => text()();
  TextColumn get calendarStatus => text()();
  TextColumn get comment => text().nullable()();
  BoolColumn get blockReady => boolean().withDefault(const Constant(false))();
  TextColumn get serverStatus => text().nullable()();
  IntColumn get serverVersion => integer().withDefault(const Constant(0))();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}

@DataClassName('NotificationRow')
class Notifications extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get sessionDate => text().nullable()();
  TextColumn get comment => text().nullable()();
  BoolColumn get read => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Small settings: locale, deviceId, cached profile, last sync…
@DataClassName('KvRow')
class Kv extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [
  SessionsLocal,
  StudentGradesLocal,
  Snapshots,
  Outbox,
  CalendarCache,
  Notifications,
  Kv,
])
class AppDatabase extends _$AppDatabase {
  /// Tests pass an in-memory executor.
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(driftDatabase(name: 'misk_teacher'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<String?> readKv(String key) async =>
      (await (select(kv)..where((t) => t.key.equals(key))).getSingleOrNull())
          ?.value;

  Future<void> writeKv(String key, String? value) async {
    if (value == null) {
      await (delete(kv)..where((t) => t.key.equals(key))).go();
    } else {
      await into(kv).insertOnConflictUpdate(KvRow(key: key, value: value));
    }
  }

  /// Wipes all user data (logout); device preferences (`app.*`) are kept.
  /// Callers must check the outbox first.
  Future<void> wipe() => transaction(() async {
        for (final table in allTables.toList().reversed) {
          if (table == kv) {
            await (delete(kv)..where((t) => t.key.like('app.%').not())).go();
          } else {
            await delete(table).go();
          }
        }
      });
}
