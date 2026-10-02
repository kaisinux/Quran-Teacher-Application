// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionsLocalTable extends SessionsLocal
    with TableInfo<$SessionsLocalTable, SessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<String> sessionDate = GeneratedColumn<String>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionNumberMeta = const VerificationMeta(
    'sessionNumber',
  );
  @override
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
    'session_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverStatusMeta = const VerificationMeta(
    'serverStatus',
  );
  @override
  late final GeneratedColumn<String> serverStatus = GeneratedColumn<String>(
    'server_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _baseHashMeta = const VerificationMeta(
    'baseHash',
  );
  @override
  late final GeneratedColumn<String> baseHash = GeneratedColumn<String>(
    'base_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _correctionCommentMeta = const VerificationMeta(
    'correctionComment',
  );
  @override
  late final GeneratedColumn<String> correctionComment =
      GeneratedColumn<String>(
        'correction_comment',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSyncErrorMeta = const VerificationMeta(
    'lastSyncError',
  );
  @override
  late final GeneratedColumn<String> lastSyncError = GeneratedColumn<String>(
    'last_sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _synchronizedAtMeta = const VerificationMeta(
    'synchronizedAt',
  );
  @override
  late final GeneratedColumn<DateTime> synchronizedAt =
      GeneratedColumn<DateTime>(
        'synchronized_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    groupId,
    sessionDate,
    sessionNumber,
    status,
    serverStatus,
    serverVersion,
    baseHash,
    correctionComment,
    lastSyncError,
    createdAt,
    updatedAt,
    synchronizedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
        _sessionNumberMeta,
        sessionNumber.isAcceptableOrUnknown(
          data['session_number']!,
          _sessionNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('server_status')) {
      context.handle(
        _serverStatusMeta,
        serverStatus.isAcceptableOrUnknown(
          data['server_status']!,
          _serverStatusMeta,
        ),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('base_hash')) {
      context.handle(
        _baseHashMeta,
        baseHash.isAcceptableOrUnknown(data['base_hash']!, _baseHashMeta),
      );
    }
    if (data.containsKey('correction_comment')) {
      context.handle(
        _correctionCommentMeta,
        correctionComment.isAcceptableOrUnknown(
          data['correction_comment']!,
          _correctionCommentMeta,
        ),
      );
    }
    if (data.containsKey('last_sync_error')) {
      context.handle(
        _lastSyncErrorMeta,
        lastSyncError.isAcceptableOrUnknown(
          data['last_sync_error']!,
          _lastSyncErrorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('synchronized_at')) {
      context.handle(
        _synchronizedAtMeta,
        synchronizedAt.isAcceptableOrUnknown(
          data['synchronized_at']!,
          _synchronizedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {groupId, sessionDate},
  ];
  @override
  SessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_date'],
      )!,
      sessionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      serverStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_status'],
      ),
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      )!,
      baseHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_hash'],
      ),
      correctionComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correction_comment'],
      ),
      lastSyncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sync_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      synchronizedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synchronized_at'],
      ),
    );
  }

  @override
  $SessionsLocalTable createAlias(String alias) {
    return $SessionsLocalTable(attachedDatabase, alias);
  }
}

class SessionRow extends DataClass implements Insertable<SessionRow> {
  final String id;
  final String groupId;

  /// `YYYY-MM-DD`.
  final String sessionDate;
  final int? sessionNumber;

  /// `SessionStatus.wire`.
  final String status;
  final String? serverStatus;
  final int serverVersion;
  final String? baseHash;
  final String? correctionComment;
  final String? lastSyncError;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? synchronizedAt;
  const SessionRow({
    required this.id,
    required this.groupId,
    required this.sessionDate,
    this.sessionNumber,
    required this.status,
    this.serverStatus,
    required this.serverVersion,
    this.baseHash,
    this.correctionComment,
    this.lastSyncError,
    required this.createdAt,
    required this.updatedAt,
    this.synchronizedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['session_date'] = Variable<String>(sessionDate);
    if (!nullToAbsent || sessionNumber != null) {
      map['session_number'] = Variable<int>(sessionNumber);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || serverStatus != null) {
      map['server_status'] = Variable<String>(serverStatus);
    }
    map['server_version'] = Variable<int>(serverVersion);
    if (!nullToAbsent || baseHash != null) {
      map['base_hash'] = Variable<String>(baseHash);
    }
    if (!nullToAbsent || correctionComment != null) {
      map['correction_comment'] = Variable<String>(correctionComment);
    }
    if (!nullToAbsent || lastSyncError != null) {
      map['last_sync_error'] = Variable<String>(lastSyncError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || synchronizedAt != null) {
      map['synchronized_at'] = Variable<DateTime>(synchronizedAt);
    }
    return map;
  }

  SessionsLocalCompanion toCompanion(bool nullToAbsent) {
    return SessionsLocalCompanion(
      id: Value(id),
      groupId: Value(groupId),
      sessionDate: Value(sessionDate),
      sessionNumber: sessionNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionNumber),
      status: Value(status),
      serverStatus: serverStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(serverStatus),
      serverVersion: Value(serverVersion),
      baseHash: baseHash == null && nullToAbsent
          ? const Value.absent()
          : Value(baseHash),
      correctionComment: correctionComment == null && nullToAbsent
          ? const Value.absent()
          : Value(correctionComment),
      lastSyncError: lastSyncError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      synchronizedAt: synchronizedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(synchronizedAt),
    );
  }

  factory SessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRow(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      sessionDate: serializer.fromJson<String>(json['sessionDate']),
      sessionNumber: serializer.fromJson<int?>(json['sessionNumber']),
      status: serializer.fromJson<String>(json['status']),
      serverStatus: serializer.fromJson<String?>(json['serverStatus']),
      serverVersion: serializer.fromJson<int>(json['serverVersion']),
      baseHash: serializer.fromJson<String?>(json['baseHash']),
      correctionComment: serializer.fromJson<String?>(
        json['correctionComment'],
      ),
      lastSyncError: serializer.fromJson<String?>(json['lastSyncError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      synchronizedAt: serializer.fromJson<DateTime?>(json['synchronizedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'sessionDate': serializer.toJson<String>(sessionDate),
      'sessionNumber': serializer.toJson<int?>(sessionNumber),
      'status': serializer.toJson<String>(status),
      'serverStatus': serializer.toJson<String?>(serverStatus),
      'serverVersion': serializer.toJson<int>(serverVersion),
      'baseHash': serializer.toJson<String?>(baseHash),
      'correctionComment': serializer.toJson<String?>(correctionComment),
      'lastSyncError': serializer.toJson<String?>(lastSyncError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'synchronizedAt': serializer.toJson<DateTime?>(synchronizedAt),
    };
  }

  SessionRow copyWith({
    String? id,
    String? groupId,
    String? sessionDate,
    Value<int?> sessionNumber = const Value.absent(),
    String? status,
    Value<String?> serverStatus = const Value.absent(),
    int? serverVersion,
    Value<String?> baseHash = const Value.absent(),
    Value<String?> correctionComment = const Value.absent(),
    Value<String?> lastSyncError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> synchronizedAt = const Value.absent(),
  }) => SessionRow(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    sessionDate: sessionDate ?? this.sessionDate,
    sessionNumber: sessionNumber.present
        ? sessionNumber.value
        : this.sessionNumber,
    status: status ?? this.status,
    serverStatus: serverStatus.present ? serverStatus.value : this.serverStatus,
    serverVersion: serverVersion ?? this.serverVersion,
    baseHash: baseHash.present ? baseHash.value : this.baseHash,
    correctionComment: correctionComment.present
        ? correctionComment.value
        : this.correctionComment,
    lastSyncError: lastSyncError.present
        ? lastSyncError.value
        : this.lastSyncError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    synchronizedAt: synchronizedAt.present
        ? synchronizedAt.value
        : this.synchronizedAt,
  );
  SessionRow copyWithCompanion(SessionsLocalCompanion data) {
    return SessionRow(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      status: data.status.present ? data.status.value : this.status,
      serverStatus: data.serverStatus.present
          ? data.serverStatus.value
          : this.serverStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      baseHash: data.baseHash.present ? data.baseHash.value : this.baseHash,
      correctionComment: data.correctionComment.present
          ? data.correctionComment.value
          : this.correctionComment,
      lastSyncError: data.lastSyncError.present
          ? data.lastSyncError.value
          : this.lastSyncError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      synchronizedAt: data.synchronizedAt.present
          ? data.synchronizedAt.value
          : this.synchronizedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRow(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('status: $status, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('baseHash: $baseHash, ')
          ..write('correctionComment: $correctionComment, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('synchronizedAt: $synchronizedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    groupId,
    sessionDate,
    sessionNumber,
    status,
    serverStatus,
    serverVersion,
    baseHash,
    correctionComment,
    lastSyncError,
    createdAt,
    updatedAt,
    synchronizedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRow &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.sessionDate == this.sessionDate &&
          other.sessionNumber == this.sessionNumber &&
          other.status == this.status &&
          other.serverStatus == this.serverStatus &&
          other.serverVersion == this.serverVersion &&
          other.baseHash == this.baseHash &&
          other.correctionComment == this.correctionComment &&
          other.lastSyncError == this.lastSyncError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.synchronizedAt == this.synchronizedAt);
}

class SessionsLocalCompanion extends UpdateCompanion<SessionRow> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> sessionDate;
  final Value<int?> sessionNumber;
  final Value<String> status;
  final Value<String?> serverStatus;
  final Value<int> serverVersion;
  final Value<String?> baseHash;
  final Value<String?> correctionComment;
  final Value<String?> lastSyncError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> synchronizedAt;
  final Value<int> rowid;
  const SessionsLocalCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.serverStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.baseHash = const Value.absent(),
    this.correctionComment = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.synchronizedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsLocalCompanion.insert({
    required String id,
    required String groupId,
    required String sessionDate,
    this.sessionNumber = const Value.absent(),
    required String status,
    this.serverStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.baseHash = const Value.absent(),
    this.correctionComment = const Value.absent(),
    this.lastSyncError = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.synchronizedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       groupId = Value(groupId),
       sessionDate = Value(sessionDate),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SessionRow> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? sessionDate,
    Expression<int>? sessionNumber,
    Expression<String>? status,
    Expression<String>? serverStatus,
    Expression<int>? serverVersion,
    Expression<String>? baseHash,
    Expression<String>? correctionComment,
    Expression<String>? lastSyncError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? synchronizedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (sessionDate != null) 'session_date': sessionDate,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (status != null) 'status': status,
      if (serverStatus != null) 'server_status': serverStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (baseHash != null) 'base_hash': baseHash,
      if (correctionComment != null) 'correction_comment': correctionComment,
      if (lastSyncError != null) 'last_sync_error': lastSyncError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (synchronizedAt != null) 'synchronized_at': synchronizedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? groupId,
    Value<String>? sessionDate,
    Value<int?>? sessionNumber,
    Value<String>? status,
    Value<String?>? serverStatus,
    Value<int>? serverVersion,
    Value<String?>? baseHash,
    Value<String?>? correctionComment,
    Value<String?>? lastSyncError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? synchronizedAt,
    Value<int>? rowid,
  }) {
    return SessionsLocalCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      sessionDate: sessionDate ?? this.sessionDate,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      status: status ?? this.status,
      serverStatus: serverStatus ?? this.serverStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      baseHash: baseHash ?? this.baseHash,
      correctionComment: correctionComment ?? this.correctionComment,
      lastSyncError: lastSyncError ?? this.lastSyncError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      synchronizedAt: synchronizedAt ?? this.synchronizedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<String>(sessionDate.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (serverStatus.present) {
      map['server_status'] = Variable<String>(serverStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (baseHash.present) {
      map['base_hash'] = Variable<String>(baseHash.value);
    }
    if (correctionComment.present) {
      map['correction_comment'] = Variable<String>(correctionComment.value);
    }
    if (lastSyncError.present) {
      map['last_sync_error'] = Variable<String>(lastSyncError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (synchronizedAt.present) {
      map['synchronized_at'] = Variable<DateTime>(synchronizedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsLocalCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('status: $status, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('baseHash: $baseHash, ')
          ..write('correctionComment: $correctionComment, ')
          ..write('lastSyncError: $lastSyncError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('synchronizedAt: $synchronizedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudentGradesLocalTable extends StudentGradesLocal
    with TableInfo<$StudentGradesLocalTable, GradeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentGradesLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions_local (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentNameMeta = const VerificationMeta(
    'studentName',
  );
  @override
  late final GeneratedColumn<String> studentName = GeneratedColumn<String>(
    'student_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hifzMeta = const VerificationMeta('hifz');
  @override
  late final GeneratedColumn<double> hifz = GeneratedColumn<double>(
    'hifz',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tajwidMeta = const VerificationMeta('tajwid');
  @override
  late final GeneratedColumn<double> tajwid = GeneratedColumn<double>(
    'tajwid',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disciplineMeta = const VerificationMeta(
    'discipline',
  );
  @override
  late final GeneratedColumn<double> discipline = GeneratedColumn<double>(
    'discipline',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attendanceMeta = const VerificationMeta(
    'attendance',
  );
  @override
  late final GeneratedColumn<String> attendance = GeneratedColumn<String>(
    'attendance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    studentId,
    studentName,
    sortOrder,
    hifz,
    tajwid,
    discipline,
    attendance,
    remark,
    dirty,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_grades_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('student_name')) {
      context.handle(
        _studentNameMeta,
        studentName.isAcceptableOrUnknown(
          data['student_name']!,
          _studentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studentNameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('hifz')) {
      context.handle(
        _hifzMeta,
        hifz.isAcceptableOrUnknown(data['hifz']!, _hifzMeta),
      );
    }
    if (data.containsKey('tajwid')) {
      context.handle(
        _tajwidMeta,
        tajwid.isAcceptableOrUnknown(data['tajwid']!, _tajwidMeta),
      );
    }
    if (data.containsKey('discipline')) {
      context.handle(
        _disciplineMeta,
        discipline.isAcceptableOrUnknown(data['discipline']!, _disciplineMeta),
      );
    }
    if (data.containsKey('attendance')) {
      context.handle(
        _attendanceMeta,
        attendance.isAcceptableOrUnknown(data['attendance']!, _attendanceMeta),
      );
    } else if (isInserting) {
      context.missing(_attendanceMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, studentId};
  @override
  GradeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradeRow(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      studentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      hifz: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hifz'],
      ),
      tajwid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tajwid'],
      ),
      discipline: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discipline'],
      ),
      attendance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance'],
      )!,
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentGradesLocalTable createAlias(String alias) {
    return $StudentGradesLocalTable(attachedDatabase, alias);
  }
}

class GradeRow extends DataClass implements Insertable<GradeRow> {
  final String sessionId;
  final String studentId;
  final String studentName;

  /// Sheet order, never alphabetical.
  final int sortOrder;
  final double? hifz;
  final double? tajwid;
  final double? discipline;

  /// `Attendance.wire`.
  final String attendance;
  final String? remark;

  /// Changed locally since the last download / sync.
  final bool dirty;
  final DateTime updatedAt;
  const GradeRow({
    required this.sessionId,
    required this.studentId,
    required this.studentName,
    required this.sortOrder,
    this.hifz,
    this.tajwid,
    this.discipline,
    required this.attendance,
    this.remark,
    required this.dirty,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['student_id'] = Variable<String>(studentId);
    map['student_name'] = Variable<String>(studentName);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || hifz != null) {
      map['hifz'] = Variable<double>(hifz);
    }
    if (!nullToAbsent || tajwid != null) {
      map['tajwid'] = Variable<double>(tajwid);
    }
    if (!nullToAbsent || discipline != null) {
      map['discipline'] = Variable<double>(discipline);
    }
    map['attendance'] = Variable<String>(attendance);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    map['dirty'] = Variable<bool>(dirty);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentGradesLocalCompanion toCompanion(bool nullToAbsent) {
    return StudentGradesLocalCompanion(
      sessionId: Value(sessionId),
      studentId: Value(studentId),
      studentName: Value(studentName),
      sortOrder: Value(sortOrder),
      hifz: hifz == null && nullToAbsent ? const Value.absent() : Value(hifz),
      tajwid: tajwid == null && nullToAbsent
          ? const Value.absent()
          : Value(tajwid),
      discipline: discipline == null && nullToAbsent
          ? const Value.absent()
          : Value(discipline),
      attendance: Value(attendance),
      remark: remark == null && nullToAbsent
          ? const Value.absent()
          : Value(remark),
      dirty: Value(dirty),
      updatedAt: Value(updatedAt),
    );
  }

  factory GradeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradeRow(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      studentId: serializer.fromJson<String>(json['studentId']),
      studentName: serializer.fromJson<String>(json['studentName']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      hifz: serializer.fromJson<double?>(json['hifz']),
      tajwid: serializer.fromJson<double?>(json['tajwid']),
      discipline: serializer.fromJson<double?>(json['discipline']),
      attendance: serializer.fromJson<String>(json['attendance']),
      remark: serializer.fromJson<String?>(json['remark']),
      dirty: serializer.fromJson<bool>(json['dirty']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'studentId': serializer.toJson<String>(studentId),
      'studentName': serializer.toJson<String>(studentName),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'hifz': serializer.toJson<double?>(hifz),
      'tajwid': serializer.toJson<double?>(tajwid),
      'discipline': serializer.toJson<double?>(discipline),
      'attendance': serializer.toJson<String>(attendance),
      'remark': serializer.toJson<String?>(remark),
      'dirty': serializer.toJson<bool>(dirty),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GradeRow copyWith({
    String? sessionId,
    String? studentId,
    String? studentName,
    int? sortOrder,
    Value<double?> hifz = const Value.absent(),
    Value<double?> tajwid = const Value.absent(),
    Value<double?> discipline = const Value.absent(),
    String? attendance,
    Value<String?> remark = const Value.absent(),
    bool? dirty,
    DateTime? updatedAt,
  }) => GradeRow(
    sessionId: sessionId ?? this.sessionId,
    studentId: studentId ?? this.studentId,
    studentName: studentName ?? this.studentName,
    sortOrder: sortOrder ?? this.sortOrder,
    hifz: hifz.present ? hifz.value : this.hifz,
    tajwid: tajwid.present ? tajwid.value : this.tajwid,
    discipline: discipline.present ? discipline.value : this.discipline,
    attendance: attendance ?? this.attendance,
    remark: remark.present ? remark.value : this.remark,
    dirty: dirty ?? this.dirty,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GradeRow copyWithCompanion(StudentGradesLocalCompanion data) {
    return GradeRow(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      studentName: data.studentName.present
          ? data.studentName.value
          : this.studentName,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      hifz: data.hifz.present ? data.hifz.value : this.hifz,
      tajwid: data.tajwid.present ? data.tajwid.value : this.tajwid,
      discipline: data.discipline.present
          ? data.discipline.value
          : this.discipline,
      attendance: data.attendance.present
          ? data.attendance.value
          : this.attendance,
      remark: data.remark.present ? data.remark.value : this.remark,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradeRow(')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId, ')
          ..write('studentName: $studentName, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('hifz: $hifz, ')
          ..write('tajwid: $tajwid, ')
          ..write('discipline: $discipline, ')
          ..write('attendance: $attendance, ')
          ..write('remark: $remark, ')
          ..write('dirty: $dirty, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sessionId,
    studentId,
    studentName,
    sortOrder,
    hifz,
    tajwid,
    discipline,
    attendance,
    remark,
    dirty,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeRow &&
          other.sessionId == this.sessionId &&
          other.studentId == this.studentId &&
          other.studentName == this.studentName &&
          other.sortOrder == this.sortOrder &&
          other.hifz == this.hifz &&
          other.tajwid == this.tajwid &&
          other.discipline == this.discipline &&
          other.attendance == this.attendance &&
          other.remark == this.remark &&
          other.dirty == this.dirty &&
          other.updatedAt == this.updatedAt);
}

class StudentGradesLocalCompanion extends UpdateCompanion<GradeRow> {
  final Value<String> sessionId;
  final Value<String> studentId;
  final Value<String> studentName;
  final Value<int> sortOrder;
  final Value<double?> hifz;
  final Value<double?> tajwid;
  final Value<double?> discipline;
  final Value<String> attendance;
  final Value<String?> remark;
  final Value<bool> dirty;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudentGradesLocalCompanion({
    this.sessionId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.studentName = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.hifz = const Value.absent(),
    this.tajwid = const Value.absent(),
    this.discipline = const Value.absent(),
    this.attendance = const Value.absent(),
    this.remark = const Value.absent(),
    this.dirty = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentGradesLocalCompanion.insert({
    required String sessionId,
    required String studentId,
    required String studentName,
    required int sortOrder,
    this.hifz = const Value.absent(),
    this.tajwid = const Value.absent(),
    this.discipline = const Value.absent(),
    required String attendance,
    this.remark = const Value.absent(),
    this.dirty = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       studentId = Value(studentId),
       studentName = Value(studentName),
       sortOrder = Value(sortOrder),
       attendance = Value(attendance),
       updatedAt = Value(updatedAt);
  static Insertable<GradeRow> custom({
    Expression<String>? sessionId,
    Expression<String>? studentId,
    Expression<String>? studentName,
    Expression<int>? sortOrder,
    Expression<double>? hifz,
    Expression<double>? tajwid,
    Expression<double>? discipline,
    Expression<String>? attendance,
    Expression<String>? remark,
    Expression<bool>? dirty,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (studentId != null) 'student_id': studentId,
      if (studentName != null) 'student_name': studentName,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (hifz != null) 'hifz': hifz,
      if (tajwid != null) 'tajwid': tajwid,
      if (discipline != null) 'discipline': discipline,
      if (attendance != null) 'attendance': attendance,
      if (remark != null) 'remark': remark,
      if (dirty != null) 'dirty': dirty,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentGradesLocalCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? studentId,
    Value<String>? studentName,
    Value<int>? sortOrder,
    Value<double?>? hifz,
    Value<double?>? tajwid,
    Value<double?>? discipline,
    Value<String>? attendance,
    Value<String?>? remark,
    Value<bool>? dirty,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StudentGradesLocalCompanion(
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      sortOrder: sortOrder ?? this.sortOrder,
      hifz: hifz ?? this.hifz,
      tajwid: tajwid ?? this.tajwid,
      discipline: discipline ?? this.discipline,
      attendance: attendance ?? this.attendance,
      remark: remark ?? this.remark,
      dirty: dirty ?? this.dirty,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (studentName.present) {
      map['student_name'] = Variable<String>(studentName.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (hifz.present) {
      map['hifz'] = Variable<double>(hifz.value);
    }
    if (tajwid.present) {
      map['tajwid'] = Variable<double>(tajwid.value);
    }
    if (discipline.present) {
      map['discipline'] = Variable<double>(discipline.value);
    }
    if (attendance.present) {
      map['attendance'] = Variable<String>(attendance.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentGradesLocalCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId, ')
          ..write('studentName: $studentName, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('hifz: $hifz, ')
          ..write('tajwid: $tajwid, ')
          ..write('discipline: $discipline, ')
          ..write('attendance: $attendance, ')
          ..write('remark: $remark, ')
          ..write('dirty: $dirty, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SnapshotsTable extends Snapshots
    with TableInfo<$SnapshotsTable, SnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions_local (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverVersionAtMeta = const VerificationMeta(
    'serverVersionAt',
  );
  @override
  late final GeneratedColumn<int> serverVersionAt = GeneratedColumn<int>(
    'server_version_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    kind,
    payloadJson,
    serverVersionAt,
    result,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<SnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('server_version_at')) {
      context.handle(
        _serverVersionAtMeta,
        serverVersionAt.isAcceptableOrUnknown(
          data['server_version_at']!,
          _serverVersionAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serverVersionAtMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      serverVersionAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version_at'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SnapshotsTable createAlias(String alias) {
    return $SnapshotsTable(attachedDatabase, alias);
  }
}

class SnapshotRow extends DataClass implements Insertable<SnapshotRow> {
  final String id;
  final String sessionId;
  final String kind;
  final String payloadJson;
  final int serverVersionAt;
  final String? result;
  final DateTime createdAt;
  const SnapshotRow({
    required this.id,
    required this.sessionId,
    required this.kind,
    required this.payloadJson,
    required this.serverVersionAt,
    this.result,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['kind'] = Variable<String>(kind);
    map['payload_json'] = Variable<String>(payloadJson);
    map['server_version_at'] = Variable<int>(serverVersionAt);
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SnapshotsCompanion toCompanion(bool nullToAbsent) {
    return SnapshotsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      kind: Value(kind),
      payloadJson: Value(payloadJson),
      serverVersionAt: Value(serverVersionAt),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      createdAt: Value(createdAt),
    );
  }

  factory SnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SnapshotRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      kind: serializer.fromJson<String>(json['kind']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      serverVersionAt: serializer.fromJson<int>(json['serverVersionAt']),
      result: serializer.fromJson<String?>(json['result']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'kind': serializer.toJson<String>(kind),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'serverVersionAt': serializer.toJson<int>(serverVersionAt),
      'result': serializer.toJson<String?>(result),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SnapshotRow copyWith({
    String? id,
    String? sessionId,
    String? kind,
    String? payloadJson,
    int? serverVersionAt,
    Value<String?> result = const Value.absent(),
    DateTime? createdAt,
  }) => SnapshotRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    kind: kind ?? this.kind,
    payloadJson: payloadJson ?? this.payloadJson,
    serverVersionAt: serverVersionAt ?? this.serverVersionAt,
    result: result.present ? result.value : this.result,
    createdAt: createdAt ?? this.createdAt,
  );
  SnapshotRow copyWithCompanion(SnapshotsCompanion data) {
    return SnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      kind: data.kind.present ? data.kind.value : this.kind,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      serverVersionAt: data.serverVersionAt.present
          ? data.serverVersionAt.value
          : this.serverVersionAt,
      result: data.result.present ? data.result.value : this.result,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('kind: $kind, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('serverVersionAt: $serverVersionAt, ')
          ..write('result: $result, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    kind,
    payloadJson,
    serverVersionAt,
    result,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SnapshotRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.kind == this.kind &&
          other.payloadJson == this.payloadJson &&
          other.serverVersionAt == this.serverVersionAt &&
          other.result == this.result &&
          other.createdAt == this.createdAt);
}

class SnapshotsCompanion extends UpdateCompanion<SnapshotRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> kind;
  final Value<String> payloadJson;
  final Value<int> serverVersionAt;
  final Value<String?> result;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SnapshotsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.kind = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.serverVersionAt = const Value.absent(),
    this.result = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SnapshotsCompanion.insert({
    required String id,
    required String sessionId,
    required String kind,
    required String payloadJson,
    required int serverVersionAt,
    this.result = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       kind = Value(kind),
       payloadJson = Value(payloadJson),
       serverVersionAt = Value(serverVersionAt),
       createdAt = Value(createdAt);
  static Insertable<SnapshotRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? kind,
    Expression<String>? payloadJson,
    Expression<int>? serverVersionAt,
    Expression<String>? result,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (kind != null) 'kind': kind,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (serverVersionAt != null) 'server_version_at': serverVersionAt,
      if (result != null) 'result': result,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SnapshotsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? kind,
    Value<String>? payloadJson,
    Value<int>? serverVersionAt,
    Value<String?>? result,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SnapshotsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      kind: kind ?? this.kind,
      payloadJson: payloadJson ?? this.payloadJson,
      serverVersionAt: serverVersionAt ?? this.serverVersionAt,
      result: result ?? this.result,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (serverVersionAt.present) {
      map['server_version_at'] = Variable<int>(serverVersionAt.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('kind: $kind, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('serverVersionAt: $serverVersionAt, ')
          ..write('result: $result, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxTable extends Outbox with TableInfo<$OutboxTable, OutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions_local (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _snapshotIdMeta = const VerificationMeta(
    'snapshotId',
  );
  @override
  late final GeneratedColumn<String> snapshotId = GeneratedColumn<String>(
    'snapshot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES snapshots (id)',
    ),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    snapshotId,
    idempotencyKey,
    state,
    attempts,
    nextAttemptAt,
    lastError,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('snapshot_id')) {
      context.handle(
        _snapshotIdMeta,
        snapshotId.isAcceptableOrUnknown(data['snapshot_id']!, _snapshotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotIdMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      snapshotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_id'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OutboxTable createAlias(String alias) {
    return $OutboxTable(attachedDatabase, alias);
  }
}

class OutboxRow extends DataClass implements Insertable<OutboxRow> {
  final String id;
  final String sessionId;
  final String snapshotId;
  final String idempotencyKey;

  /// PENDING | IN_FLIGHT | DONE | FAILED | CONFLICT.
  final String state;
  final int attempts;
  final DateTime? nextAttemptAt;
  final String? lastError;
  final DateTime createdAt;
  const OutboxRow({
    required this.id,
    required this.sessionId,
    required this.snapshotId,
    required this.idempotencyKey,
    required this.state,
    required this.attempts,
    this.nextAttemptAt,
    this.lastError,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['snapshot_id'] = Variable<String>(snapshotId);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['state'] = Variable<String>(state);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OutboxCompanion toCompanion(bool nullToAbsent) {
    return OutboxCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      snapshotId: Value(snapshotId),
      idempotencyKey: Value(idempotencyKey),
      state: Value(state),
      attempts: Value(attempts),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory OutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      snapshotId: serializer.fromJson<String>(json['snapshotId']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      state: serializer.fromJson<String>(json['state']),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'snapshotId': serializer.toJson<String>(snapshotId),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'state': serializer.toJson<String>(state),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OutboxRow copyWith({
    String? id,
    String? sessionId,
    String? snapshotId,
    String? idempotencyKey,
    String? state,
    int? attempts,
    Value<DateTime?> nextAttemptAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
  }) => OutboxRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    snapshotId: snapshotId ?? this.snapshotId,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    state: state ?? this.state,
    attempts: attempts ?? this.attempts,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
  );
  OutboxRow copyWithCompanion(OutboxCompanion data) {
    return OutboxRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      snapshotId: data.snapshotId.present
          ? data.snapshotId.value
          : this.snapshotId,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      state: data.state.present ? data.state.value : this.state,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('state: $state, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    snapshotId,
    idempotencyKey,
    state,
    attempts,
    nextAttemptAt,
    lastError,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.snapshotId == this.snapshotId &&
          other.idempotencyKey == this.idempotencyKey &&
          other.state == this.state &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class OutboxCompanion extends UpdateCompanion<OutboxRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> snapshotId;
  final Value<String> idempotencyKey;
  final Value<String> state;
  final Value<int> attempts;
  final Value<DateTime?> nextAttemptAt;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OutboxCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.snapshotId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.state = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutboxCompanion.insert({
    required String id,
    required String sessionId,
    required String snapshotId,
    required String idempotencyKey,
    required String state,
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       snapshotId = Value(snapshotId),
       idempotencyKey = Value(idempotencyKey),
       state = Value(state),
       createdAt = Value(createdAt);
  static Insertable<OutboxRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? snapshotId,
    Expression<String>? idempotencyKey,
    Expression<String>? state,
    Expression<int>? attempts,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (snapshotId != null) 'snapshot_id': snapshotId,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (state != null) 'state': state,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutboxCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? snapshotId,
    Value<String>? idempotencyKey,
    Value<String>? state,
    Value<int>? attempts,
    Value<DateTime?>? nextAttemptAt,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return OutboxCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      snapshotId: snapshotId ?? this.snapshotId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      state: state ?? this.state,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (snapshotId.present) {
      map['snapshot_id'] = Variable<String>(snapshotId.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('state: $state, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarCacheTable extends CalendarCache
    with TableInfo<$CalendarCacheTable, CalendarRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolYearMeta = const VerificationMeta(
    'schoolYear',
  );
  @override
  late final GeneratedColumn<String> schoolYear = GeneratedColumn<String>(
    'school_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
    'term',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calendarStatusMeta = const VerificationMeta(
    'calendarStatus',
  );
  @override
  late final GeneratedColumn<String> calendarStatus = GeneratedColumn<String>(
    'calendar_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockReadyMeta = const VerificationMeta(
    'blockReady',
  );
  @override
  late final GeneratedColumn<bool> blockReady = GeneratedColumn<bool>(
    'block_ready',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("block_ready" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _serverStatusMeta = const VerificationMeta(
    'serverStatus',
  );
  @override
  late final GeneratedColumn<String> serverStatus = GeneratedColumn<String>(
    'server_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    schoolYear,
    term,
    calendarStatus,
    comment,
    blockReady,
    serverStatus,
    serverVersion,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('school_year')) {
      context.handle(
        _schoolYearMeta,
        schoolYear.isAcceptableOrUnknown(data['school_year']!, _schoolYearMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolYearMeta);
    }
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('calendar_status')) {
      context.handle(
        _calendarStatusMeta,
        calendarStatus.isAcceptableOrUnknown(
          data['calendar_status']!,
          _calendarStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calendarStatusMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('block_ready')) {
      context.handle(
        _blockReadyMeta,
        blockReady.isAcceptableOrUnknown(data['block_ready']!, _blockReadyMeta),
      );
    }
    if (data.containsKey('server_status')) {
      context.handle(
        _serverStatusMeta,
        serverStatus.isAcceptableOrUnknown(
          data['server_status']!,
          _serverStatusMeta,
        ),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  CalendarRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarRow(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      schoolYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_year'],
      )!,
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
      )!,
      calendarStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_status'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      blockReady: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}block_ready'],
      )!,
      serverStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_status'],
      ),
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CalendarCacheTable createAlias(String alias) {
    return $CalendarCacheTable(attachedDatabase, alias);
  }
}

class CalendarRow extends DataClass implements Insertable<CalendarRow> {
  final String date;
  final String schoolYear;
  final String term;
  final String calendarStatus;
  final String? comment;
  final bool blockReady;
  final String? serverStatus;
  final int serverVersion;
  final DateTime fetchedAt;
  const CalendarRow({
    required this.date,
    required this.schoolYear,
    required this.term,
    required this.calendarStatus,
    this.comment,
    required this.blockReady,
    this.serverStatus,
    required this.serverVersion,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['school_year'] = Variable<String>(schoolYear);
    map['term'] = Variable<String>(term);
    map['calendar_status'] = Variable<String>(calendarStatus);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['block_ready'] = Variable<bool>(blockReady);
    if (!nullToAbsent || serverStatus != null) {
      map['server_status'] = Variable<String>(serverStatus);
    }
    map['server_version'] = Variable<int>(serverVersion);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CalendarCacheCompanion toCompanion(bool nullToAbsent) {
    return CalendarCacheCompanion(
      date: Value(date),
      schoolYear: Value(schoolYear),
      term: Value(term),
      calendarStatus: Value(calendarStatus),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      blockReady: Value(blockReady),
      serverStatus: serverStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(serverStatus),
      serverVersion: Value(serverVersion),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CalendarRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarRow(
      date: serializer.fromJson<String>(json['date']),
      schoolYear: serializer.fromJson<String>(json['schoolYear']),
      term: serializer.fromJson<String>(json['term']),
      calendarStatus: serializer.fromJson<String>(json['calendarStatus']),
      comment: serializer.fromJson<String?>(json['comment']),
      blockReady: serializer.fromJson<bool>(json['blockReady']),
      serverStatus: serializer.fromJson<String?>(json['serverStatus']),
      serverVersion: serializer.fromJson<int>(json['serverVersion']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'schoolYear': serializer.toJson<String>(schoolYear),
      'term': serializer.toJson<String>(term),
      'calendarStatus': serializer.toJson<String>(calendarStatus),
      'comment': serializer.toJson<String?>(comment),
      'blockReady': serializer.toJson<bool>(blockReady),
      'serverStatus': serializer.toJson<String?>(serverStatus),
      'serverVersion': serializer.toJson<int>(serverVersion),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CalendarRow copyWith({
    String? date,
    String? schoolYear,
    String? term,
    String? calendarStatus,
    Value<String?> comment = const Value.absent(),
    bool? blockReady,
    Value<String?> serverStatus = const Value.absent(),
    int? serverVersion,
    DateTime? fetchedAt,
  }) => CalendarRow(
    date: date ?? this.date,
    schoolYear: schoolYear ?? this.schoolYear,
    term: term ?? this.term,
    calendarStatus: calendarStatus ?? this.calendarStatus,
    comment: comment.present ? comment.value : this.comment,
    blockReady: blockReady ?? this.blockReady,
    serverStatus: serverStatus.present ? serverStatus.value : this.serverStatus,
    serverVersion: serverVersion ?? this.serverVersion,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CalendarRow copyWithCompanion(CalendarCacheCompanion data) {
    return CalendarRow(
      date: data.date.present ? data.date.value : this.date,
      schoolYear: data.schoolYear.present
          ? data.schoolYear.value
          : this.schoolYear,
      term: data.term.present ? data.term.value : this.term,
      calendarStatus: data.calendarStatus.present
          ? data.calendarStatus.value
          : this.calendarStatus,
      comment: data.comment.present ? data.comment.value : this.comment,
      blockReady: data.blockReady.present
          ? data.blockReady.value
          : this.blockReady,
      serverStatus: data.serverStatus.present
          ? data.serverStatus.value
          : this.serverStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarRow(')
          ..write('date: $date, ')
          ..write('schoolYear: $schoolYear, ')
          ..write('term: $term, ')
          ..write('calendarStatus: $calendarStatus, ')
          ..write('comment: $comment, ')
          ..write('blockReady: $blockReady, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    date,
    schoolYear,
    term,
    calendarStatus,
    comment,
    blockReady,
    serverStatus,
    serverVersion,
    fetchedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarRow &&
          other.date == this.date &&
          other.schoolYear == this.schoolYear &&
          other.term == this.term &&
          other.calendarStatus == this.calendarStatus &&
          other.comment == this.comment &&
          other.blockReady == this.blockReady &&
          other.serverStatus == this.serverStatus &&
          other.serverVersion == this.serverVersion &&
          other.fetchedAt == this.fetchedAt);
}

class CalendarCacheCompanion extends UpdateCompanion<CalendarRow> {
  final Value<String> date;
  final Value<String> schoolYear;
  final Value<String> term;
  final Value<String> calendarStatus;
  final Value<String?> comment;
  final Value<bool> blockReady;
  final Value<String?> serverStatus;
  final Value<int> serverVersion;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const CalendarCacheCompanion({
    this.date = const Value.absent(),
    this.schoolYear = const Value.absent(),
    this.term = const Value.absent(),
    this.calendarStatus = const Value.absent(),
    this.comment = const Value.absent(),
    this.blockReady = const Value.absent(),
    this.serverStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarCacheCompanion.insert({
    required String date,
    required String schoolYear,
    required String term,
    required String calendarStatus,
    this.comment = const Value.absent(),
    this.blockReady = const Value.absent(),
    this.serverStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       schoolYear = Value(schoolYear),
       term = Value(term),
       calendarStatus = Value(calendarStatus),
       fetchedAt = Value(fetchedAt);
  static Insertable<CalendarRow> custom({
    Expression<String>? date,
    Expression<String>? schoolYear,
    Expression<String>? term,
    Expression<String>? calendarStatus,
    Expression<String>? comment,
    Expression<bool>? blockReady,
    Expression<String>? serverStatus,
    Expression<int>? serverVersion,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (schoolYear != null) 'school_year': schoolYear,
      if (term != null) 'term': term,
      if (calendarStatus != null) 'calendar_status': calendarStatus,
      if (comment != null) 'comment': comment,
      if (blockReady != null) 'block_ready': blockReady,
      if (serverStatus != null) 'server_status': serverStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarCacheCompanion copyWith({
    Value<String>? date,
    Value<String>? schoolYear,
    Value<String>? term,
    Value<String>? calendarStatus,
    Value<String?>? comment,
    Value<bool>? blockReady,
    Value<String?>? serverStatus,
    Value<int>? serverVersion,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return CalendarCacheCompanion(
      date: date ?? this.date,
      schoolYear: schoolYear ?? this.schoolYear,
      term: term ?? this.term,
      calendarStatus: calendarStatus ?? this.calendarStatus,
      comment: comment ?? this.comment,
      blockReady: blockReady ?? this.blockReady,
      serverStatus: serverStatus ?? this.serverStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (schoolYear.present) {
      map['school_year'] = Variable<String>(schoolYear.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (calendarStatus.present) {
      map['calendar_status'] = Variable<String>(calendarStatus.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (blockReady.present) {
      map['block_ready'] = Variable<bool>(blockReady.value);
    }
    if (serverStatus.present) {
      map['server_status'] = Variable<String>(serverStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarCacheCompanion(')
          ..write('date: $date, ')
          ..write('schoolYear: $schoolYear, ')
          ..write('term: $term, ')
          ..write('calendarStatus: $calendarStatus, ')
          ..write('comment: $comment, ')
          ..write('blockReady: $blockReady, ')
          ..write('serverStatus: $serverStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, NotificationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<String> sessionDate = GeneratedColumn<String>(
    'session_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<bool> read = GeneratedColumn<bool>(
    'read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    sessionDate,
    comment,
    read,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('read')) {
      context.handle(
        _readMeta,
        read.isAcceptableOrUnknown(data['read']!, _readMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_date'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      read: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class NotificationRow extends DataClass implements Insertable<NotificationRow> {
  final String id;
  final String type;
  final String? sessionDate;
  final String? comment;
  final bool read;
  final DateTime createdAt;
  const NotificationRow({
    required this.id,
    required this.type,
    this.sessionDate,
    this.comment,
    required this.read,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || sessionDate != null) {
      map['session_date'] = Variable<String>(sessionDate);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    map['read'] = Variable<bool>(read);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      type: Value(type),
      sessionDate: sessionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionDate),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      read: Value(read),
      createdAt: Value(createdAt),
    );
  }

  factory NotificationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      sessionDate: serializer.fromJson<String?>(json['sessionDate']),
      comment: serializer.fromJson<String?>(json['comment']),
      read: serializer.fromJson<bool>(json['read']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'sessionDate': serializer.toJson<String?>(sessionDate),
      'comment': serializer.toJson<String?>(comment),
      'read': serializer.toJson<bool>(read),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NotificationRow copyWith({
    String? id,
    String? type,
    Value<String?> sessionDate = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    bool? read,
    DateTime? createdAt,
  }) => NotificationRow(
    id: id ?? this.id,
    type: type ?? this.type,
    sessionDate: sessionDate.present ? sessionDate.value : this.sessionDate,
    comment: comment.present ? comment.value : this.comment,
    read: read ?? this.read,
    createdAt: createdAt ?? this.createdAt,
  );
  NotificationRow copyWithCompanion(NotificationsCompanion data) {
    return NotificationRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      comment: data.comment.present ? data.comment.value : this.comment,
      read: data.read.present ? data.read.value : this.read,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('comment: $comment, ')
          ..write('read: $read, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, sessionDate, comment, read, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.sessionDate == this.sessionDate &&
          other.comment == this.comment &&
          other.read == this.read &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<NotificationRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<String?> sessionDate;
  final Value<String?> comment;
  final Value<bool> read;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.read = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String type,
    this.sessionDate = const Value.absent(),
    this.comment = const Value.absent(),
    this.read = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<NotificationRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? sessionDate,
    Expression<String>? comment,
    Expression<bool>? read,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (sessionDate != null) 'session_date': sessionDate,
      if (comment != null) 'comment': comment,
      if (read != null) 'read': read,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String?>? sessionDate,
    Value<String?>? comment,
    Value<bool>? read,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      sessionDate: sessionDate ?? this.sessionDate,
      comment: comment ?? this.comment,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<String>(sessionDate.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (read.present) {
      map['read'] = Variable<bool>(read.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('comment: $comment, ')
          ..write('read: $read, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KvTable extends Kv with TableInfo<$KvTable, KvRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KvTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kv';
  @override
  VerificationContext validateIntegrity(
    Insertable<KvRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KvRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KvRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KvTable createAlias(String alias) {
    return $KvTable(attachedDatabase, alias);
  }
}

class KvRow extends DataClass implements Insertable<KvRow> {
  final String key;
  final String value;
  const KvRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KvCompanion toCompanion(bool nullToAbsent) {
    return KvCompanion(key: Value(key), value: Value(value));
  }

  factory KvRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KvRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KvRow copyWith({String? key, String? value}) =>
      KvRow(key: key ?? this.key, value: value ?? this.value);
  KvRow copyWithCompanion(KvCompanion data) {
    return KvRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KvRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KvRow && other.key == this.key && other.value == this.value);
}

class KvCompanion extends UpdateCompanion<KvRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KvCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KvCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KvRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KvCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KvCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KvCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsLocalTable sessionsLocal = $SessionsLocalTable(this);
  late final $StudentGradesLocalTable studentGradesLocal =
      $StudentGradesLocalTable(this);
  late final $SnapshotsTable snapshots = $SnapshotsTable(this);
  late final $OutboxTable outbox = $OutboxTable(this);
  late final $CalendarCacheTable calendarCache = $CalendarCacheTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $KvTable kv = $KvTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessionsLocal,
    studentGradesLocal,
    snapshots,
    outbox,
    calendarCache,
    notifications,
    kv,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions_local',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('student_grades_local', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions_local',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('snapshots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions_local',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('outbox', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SessionsLocalTableCreateCompanionBuilder =
    SessionsLocalCompanion Function({
      required String id,
      required String groupId,
      required String sessionDate,
      Value<int?> sessionNumber,
      required String status,
      Value<String?> serverStatus,
      Value<int> serverVersion,
      Value<String?> baseHash,
      Value<String?> correctionComment,
      Value<String?> lastSyncError,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> synchronizedAt,
      Value<int> rowid,
    });
typedef $$SessionsLocalTableUpdateCompanionBuilder =
    SessionsLocalCompanion Function({
      Value<String> id,
      Value<String> groupId,
      Value<String> sessionDate,
      Value<int?> sessionNumber,
      Value<String> status,
      Value<String?> serverStatus,
      Value<int> serverVersion,
      Value<String?> baseHash,
      Value<String?> correctionComment,
      Value<String?> lastSyncError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> synchronizedAt,
      Value<int> rowid,
    });

final class $$SessionsLocalTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsLocalTable, SessionRow> {
  $$SessionsLocalTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StudentGradesLocalTable, List<GradeRow>>
  _studentGradesLocalRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.studentGradesLocal,
        aliasName: 'sessions_local__id__student_grades_local__session_id',
      );

  $$StudentGradesLocalTableProcessedTableManager get studentGradesLocalRefs {
    final manager = $$StudentGradesLocalTableTableManager(
      $_db,
      $_db.studentGradesLocal,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentGradesLocalRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SnapshotsTable, List<SnapshotRow>>
  _snapshotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.snapshots,
    aliasName: 'sessions_local__id__snapshots__session_id',
  );

  $$SnapshotsTableProcessedTableManager get snapshotsRefs {
    final manager = $$SnapshotsTableTableManager(
      $_db,
      $_db.snapshots,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_snapshotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OutboxTable, List<OutboxRow>> _outboxRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.outbox,
    aliasName: 'sessions_local__id__outbox__session_id',
  );

  $$OutboxTableProcessedTableManager get outboxRefs {
    final manager = $$OutboxTableTableManager(
      $_db,
      $_db.outbox,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_outboxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsLocalTable> {
  $$SessionsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseHash => $composableBuilder(
    column: $table.baseHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctionComment => $composableBuilder(
    column: $table.correctionComment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get synchronizedAt => $composableBuilder(
    column: $table.synchronizedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studentGradesLocalRefs(
    Expression<bool> Function($$StudentGradesLocalTableFilterComposer f) f,
  ) {
    final $$StudentGradesLocalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentGradesLocal,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentGradesLocalTableFilterComposer(
            $db: $db,
            $table: $db.studentGradesLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> snapshotsRefs(
    Expression<bool> Function($$SnapshotsTableFilterComposer f) f,
  ) {
    final $$SnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.snapshots,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.snapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> outboxRefs(
    Expression<bool> Function($$OutboxTableFilterComposer f) f,
  ) {
    final $$OutboxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outbox,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutboxTableFilterComposer(
            $db: $db,
            $table: $db.outbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsLocalTable> {
  $$SessionsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseHash => $composableBuilder(
    column: $table.baseHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctionComment => $composableBuilder(
    column: $table.correctionComment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get synchronizedAt => $composableBuilder(
    column: $table.synchronizedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsLocalTable> {
  $$SessionsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseHash =>
      $composableBuilder(column: $table.baseHash, builder: (column) => column);

  GeneratedColumn<String> get correctionComment => $composableBuilder(
    column: $table.correctionComment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncError => $composableBuilder(
    column: $table.lastSyncError,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get synchronizedAt => $composableBuilder(
    column: $table.synchronizedAt,
    builder: (column) => column,
  );

  Expression<T> studentGradesLocalRefs<T extends Object>(
    Expression<T> Function($$StudentGradesLocalTableAnnotationComposer a) f,
  ) {
    final $$StudentGradesLocalTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.studentGradesLocal,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StudentGradesLocalTableAnnotationComposer(
                $db: $db,
                $table: $db.studentGradesLocal,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> snapshotsRefs<T extends Object>(
    Expression<T> Function($$SnapshotsTableAnnotationComposer a) f,
  ) {
    final $$SnapshotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.snapshots,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SnapshotsTableAnnotationComposer(
            $db: $db,
            $table: $db.snapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> outboxRefs<T extends Object>(
    Expression<T> Function($$OutboxTableAnnotationComposer a) f,
  ) {
    final $$OutboxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outbox,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutboxTableAnnotationComposer(
            $db: $db,
            $table: $db.outbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsLocalTable,
          SessionRow,
          $$SessionsLocalTableFilterComposer,
          $$SessionsLocalTableOrderingComposer,
          $$SessionsLocalTableAnnotationComposer,
          $$SessionsLocalTableCreateCompanionBuilder,
          $$SessionsLocalTableUpdateCompanionBuilder,
          (SessionRow, $$SessionsLocalTableReferences),
          SessionRow,
          PrefetchHooks Function({
            bool studentGradesLocalRefs,
            bool snapshotsRefs,
            bool outboxRefs,
          })
        > {
  $$SessionsLocalTableTableManager(_$AppDatabase db, $SessionsLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<String> sessionDate = const Value.absent(),
                Value<int?> sessionNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> serverStatus = const Value.absent(),
                Value<int> serverVersion = const Value.absent(),
                Value<String?> baseHash = const Value.absent(),
                Value<String?> correctionComment = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> synchronizedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsLocalCompanion(
                id: id,
                groupId: groupId,
                sessionDate: sessionDate,
                sessionNumber: sessionNumber,
                status: status,
                serverStatus: serverStatus,
                serverVersion: serverVersion,
                baseHash: baseHash,
                correctionComment: correctionComment,
                lastSyncError: lastSyncError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                synchronizedAt: synchronizedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String groupId,
                required String sessionDate,
                Value<int?> sessionNumber = const Value.absent(),
                required String status,
                Value<String?> serverStatus = const Value.absent(),
                Value<int> serverVersion = const Value.absent(),
                Value<String?> baseHash = const Value.absent(),
                Value<String?> correctionComment = const Value.absent(),
                Value<String?> lastSyncError = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> synchronizedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsLocalCompanion.insert(
                id: id,
                groupId: groupId,
                sessionDate: sessionDate,
                sessionNumber: sessionNumber,
                status: status,
                serverStatus: serverStatus,
                serverVersion: serverVersion,
                baseHash: baseHash,
                correctionComment: correctionComment,
                lastSyncError: lastSyncError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                synchronizedAt: synchronizedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsLocalTable, SessionRow>(table),
                  $$SessionsLocalTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentGradesLocalRefs = false,
                snapshotsRefs = false,
                outboxRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentGradesLocalRefs) db.studentGradesLocal,
                    if (snapshotsRefs) db.snapshots,
                    if (outboxRefs) db.outbox,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentGradesLocalRefs)
                        await $_getPrefetchedData<
                          SessionRow,
                          $SessionsLocalTable,
                          GradeRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsLocalTableReferences
                              ._studentGradesLocalRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsLocalTableReferences(
                                db,
                                table,
                                p0,
                              ).studentGradesLocalRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (snapshotsRefs)
                        await $_getPrefetchedData<
                          SessionRow,
                          $SessionsLocalTable,
                          SnapshotRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsLocalTableReferences
                              ._snapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsLocalTableReferences(
                                db,
                                table,
                                p0,
                              ).snapshotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (outboxRefs)
                        await $_getPrefetchedData<
                          SessionRow,
                          $SessionsLocalTable,
                          OutboxRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsLocalTableReferences
                              ._outboxRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsLocalTableReferences(
                                db,
                                table,
                                p0,
                              ).outboxRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsLocalTable,
      SessionRow,
      $$SessionsLocalTableFilterComposer,
      $$SessionsLocalTableOrderingComposer,
      $$SessionsLocalTableAnnotationComposer,
      $$SessionsLocalTableCreateCompanionBuilder,
      $$SessionsLocalTableUpdateCompanionBuilder,
      (SessionRow, $$SessionsLocalTableReferences),
      SessionRow,
      PrefetchHooks Function({
        bool studentGradesLocalRefs,
        bool snapshotsRefs,
        bool outboxRefs,
      })
    >;
typedef $$StudentGradesLocalTableCreateCompanionBuilder =
    StudentGradesLocalCompanion Function({
      required String sessionId,
      required String studentId,
      required String studentName,
      required int sortOrder,
      Value<double?> hifz,
      Value<double?> tajwid,
      Value<double?> discipline,
      required String attendance,
      Value<String?> remark,
      Value<bool> dirty,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StudentGradesLocalTableUpdateCompanionBuilder =
    StudentGradesLocalCompanion Function({
      Value<String> sessionId,
      Value<String> studentId,
      Value<String> studentName,
      Value<int> sortOrder,
      Value<double?> hifz,
      Value<double?> tajwid,
      Value<double?> discipline,
      Value<String> attendance,
      Value<String?> remark,
      Value<bool> dirty,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$StudentGradesLocalTableReferences
    extends BaseReferences<_$AppDatabase, $StudentGradesLocalTable, GradeRow> {
  $$StudentGradesLocalTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsLocalTable _sessionIdTable(_$AppDatabase db) => db
      .sessionsLocal
      .createAlias('student_grades_local__session_id__sessions_local__id');

  $$SessionsLocalTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsLocalTableTableManager(
      $_db,
      $_db.sessionsLocal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentGradesLocalTableFilterComposer
    extends Composer<_$AppDatabase, $StudentGradesLocalTable> {
  $$StudentGradesLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentName => $composableBuilder(
    column: $table.studentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hifz => $composableBuilder(
    column: $table.hifz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tajwid => $composableBuilder(
    column: $table.tajwid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attendance => $composableBuilder(
    column: $table.attendance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsLocalTableFilterComposer get sessionId {
    final $$SessionsLocalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableFilterComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentGradesLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentGradesLocalTable> {
  $$StudentGradesLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentName => $composableBuilder(
    column: $table.studentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hifz => $composableBuilder(
    column: $table.hifz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tajwid => $composableBuilder(
    column: $table.tajwid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendance => $composableBuilder(
    column: $table.attendance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsLocalTableOrderingComposer get sessionId {
    final $$SessionsLocalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableOrderingComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentGradesLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentGradesLocalTable> {
  $$StudentGradesLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get studentName => $composableBuilder(
    column: $table.studentName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<double> get hifz =>
      $composableBuilder(column: $table.hifz, builder: (column) => column);

  GeneratedColumn<double> get tajwid =>
      $composableBuilder(column: $table.tajwid, builder: (column) => column);

  GeneratedColumn<double> get discipline => $composableBuilder(
    column: $table.discipline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attendance => $composableBuilder(
    column: $table.attendance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SessionsLocalTableAnnotationComposer get sessionId {
    final $$SessionsLocalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentGradesLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentGradesLocalTable,
          GradeRow,
          $$StudentGradesLocalTableFilterComposer,
          $$StudentGradesLocalTableOrderingComposer,
          $$StudentGradesLocalTableAnnotationComposer,
          $$StudentGradesLocalTableCreateCompanionBuilder,
          $$StudentGradesLocalTableUpdateCompanionBuilder,
          (GradeRow, $$StudentGradesLocalTableReferences),
          GradeRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$StudentGradesLocalTableTableManager(
    _$AppDatabase db,
    $StudentGradesLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentGradesLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentGradesLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentGradesLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> studentName = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<double?> hifz = const Value.absent(),
                Value<double?> tajwid = const Value.absent(),
                Value<double?> discipline = const Value.absent(),
                Value<String> attendance = const Value.absent(),
                Value<String?> remark = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentGradesLocalCompanion(
                sessionId: sessionId,
                studentId: studentId,
                studentName: studentName,
                sortOrder: sortOrder,
                hifz: hifz,
                tajwid: tajwid,
                discipline: discipline,
                attendance: attendance,
                remark: remark,
                dirty: dirty,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String studentId,
                required String studentName,
                required int sortOrder,
                Value<double?> hifz = const Value.absent(),
                Value<double?> tajwid = const Value.absent(),
                Value<double?> discipline = const Value.absent(),
                required String attendance,
                Value<String?> remark = const Value.absent(),
                Value<bool> dirty = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudentGradesLocalCompanion.insert(
                sessionId: sessionId,
                studentId: studentId,
                studentName: studentName,
                sortOrder: sortOrder,
                hifz: hifz,
                tajwid: tajwid,
                discipline: discipline,
                attendance: attendance,
                remark: remark,
                dirty: dirty,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudentGradesLocalTable, GradeRow>(table),
                  $$StudentGradesLocalTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$StudentGradesLocalTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$StudentGradesLocalTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudentGradesLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentGradesLocalTable,
      GradeRow,
      $$StudentGradesLocalTableFilterComposer,
      $$StudentGradesLocalTableOrderingComposer,
      $$StudentGradesLocalTableAnnotationComposer,
      $$StudentGradesLocalTableCreateCompanionBuilder,
      $$StudentGradesLocalTableUpdateCompanionBuilder,
      (GradeRow, $$StudentGradesLocalTableReferences),
      GradeRow,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$SnapshotsTableCreateCompanionBuilder = SnapshotsCompanion Function({
  required String id,
  required String sessionId,
  required String kind,
  required String payloadJson,
  required int serverVersionAt,
  Value<String?> result,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SnapshotsTableUpdateCompanionBuilder = SnapshotsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> kind,
  Value<String> payloadJson,
  Value<int> serverVersionAt,
  Value<String?> result,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SnapshotsTableReferences
    extends BaseReferences<_$AppDatabase, $SnapshotsTable, SnapshotRow> {
  $$SnapshotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsLocalTable _sessionIdTable(_$AppDatabase db) =>
      db.sessionsLocal.createAlias('snapshots__session_id__sessions_local__id');

  $$SessionsLocalTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsLocalTableTableManager(
      $_db,
      $_db.sessionsLocal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OutboxTable, List<OutboxRow>> _outboxRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.outbox,
    aliasName: 'snapshots__id__outbox__snapshot_id',
  );

  $$OutboxTableProcessedTableManager get outboxRefs {
    final manager = $$OutboxTableTableManager(
      $_db,
      $_db.outbox,
    ).filter((f) => f.snapshotId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_outboxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersionAt => $composableBuilder(
    column: $table.serverVersionAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsLocalTableFilterComposer get sessionId {
    final $$SessionsLocalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableFilterComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> outboxRefs(
    Expression<bool> Function($$OutboxTableFilterComposer f) f,
  ) {
    final $$OutboxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outbox,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutboxTableFilterComposer(
            $db: $db,
            $table: $db.outbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersionAt => $composableBuilder(
    column: $table.serverVersionAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsLocalTableOrderingComposer get sessionId {
    final $$SessionsLocalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableOrderingComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SnapshotsTable> {
  $$SnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersionAt => $composableBuilder(
    column: $table.serverVersionAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SessionsLocalTableAnnotationComposer get sessionId {
    final $$SessionsLocalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> outboxRefs<T extends Object>(
    Expression<T> Function($$OutboxTableAnnotationComposer a) f,
  ) {
    final $$OutboxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outbox,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OutboxTableAnnotationComposer(
            $db: $db,
            $table: $db.outbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SnapshotsTable,
          SnapshotRow,
          $$SnapshotsTableFilterComposer,
          $$SnapshotsTableOrderingComposer,
          $$SnapshotsTableAnnotationComposer,
          $$SnapshotsTableCreateCompanionBuilder,
          $$SnapshotsTableUpdateCompanionBuilder,
          (SnapshotRow, $$SnapshotsTableReferences),
          SnapshotRow,
          PrefetchHooks Function({bool sessionId, bool outboxRefs})
        > {
  $$SnapshotsTableTableManager(_$AppDatabase db, $SnapshotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> serverVersionAt = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SnapshotsCompanion(
                id: id,
                sessionId: sessionId,
                kind: kind,
                payloadJson: payloadJson,
                serverVersionAt: serverVersionAt,
                result: result,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String kind,
                required String payloadJson,
                required int serverVersionAt,
                Value<String?> result = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SnapshotsCompanion.insert(
                id: id,
                sessionId: sessionId,
                kind: kind,
                payloadJson: payloadJson,
                serverVersionAt: serverVersionAt,
                result: result,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SnapshotsTable, SnapshotRow>(table),
                  $$SnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, outboxRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (outboxRefs) db.outbox],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$SnapshotsTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$SnapshotsTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (outboxRefs)
                    await $_getPrefetchedData<
                      SnapshotRow,
                      $SnapshotsTable,
                      OutboxRow
                    >(
                      currentTable: table,
                      referencedTable: $$SnapshotsTableReferences
                          ._outboxRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SnapshotsTableReferences(db, table, p0).outboxRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.snapshotId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SnapshotsTable,
      SnapshotRow,
      $$SnapshotsTableFilterComposer,
      $$SnapshotsTableOrderingComposer,
      $$SnapshotsTableAnnotationComposer,
      $$SnapshotsTableCreateCompanionBuilder,
      $$SnapshotsTableUpdateCompanionBuilder,
      (SnapshotRow, $$SnapshotsTableReferences),
      SnapshotRow,
      PrefetchHooks Function({bool sessionId, bool outboxRefs})
    >;
typedef $$OutboxTableCreateCompanionBuilder = OutboxCompanion Function({
  required String id,
  required String sessionId,
  required String snapshotId,
  required String idempotencyKey,
  required String state,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$OutboxTableUpdateCompanionBuilder = OutboxCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> snapshotId,
  Value<String> idempotencyKey,
  Value<String> state,
  Value<int> attempts,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$OutboxTableReferences
    extends BaseReferences<_$AppDatabase, $OutboxTable, OutboxRow> {
  $$OutboxTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsLocalTable _sessionIdTable(_$AppDatabase db) =>
      db.sessionsLocal.createAlias('outbox__session_id__sessions_local__id');

  $$SessionsLocalTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsLocalTableTableManager(
      $_db,
      $_db.sessionsLocal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SnapshotsTable _snapshotIdTable(_$AppDatabase db) =>
      db.snapshots.createAlias('outbox__snapshot_id__snapshots__id');

  $$SnapshotsTableProcessedTableManager get snapshotId {
    final $_column = $_itemColumn<String>('snapshot_id')!;

    final manager = $$SnapshotsTableTableManager(
      $_db,
      $_db.snapshots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_snapshotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OutboxTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsLocalTableFilterComposer get sessionId {
    final $$SessionsLocalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableFilterComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SnapshotsTableFilterComposer get snapshotId {
    final $$SnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.snapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.snapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsLocalTableOrderingComposer get sessionId {
    final $$SessionsLocalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableOrderingComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SnapshotsTableOrderingComposer get snapshotId {
    final $$SnapshotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.snapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SnapshotsTableOrderingComposer(
            $db: $db,
            $table: $db.snapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxTable> {
  $$OutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SessionsLocalTableAnnotationComposer get sessionId {
    final $$SessionsLocalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessionsLocal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsLocalTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionsLocal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SnapshotsTableAnnotationComposer get snapshotId {
    final $$SnapshotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.snapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SnapshotsTableAnnotationComposer(
            $db: $db,
            $table: $db.snapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxTable,
          OutboxRow,
          $$OutboxTableFilterComposer,
          $$OutboxTableOrderingComposer,
          $$OutboxTableAnnotationComposer,
          $$OutboxTableCreateCompanionBuilder,
          $$OutboxTableUpdateCompanionBuilder,
          (OutboxRow, $$OutboxTableReferences),
          OutboxRow,
          PrefetchHooks Function({bool sessionId, bool snapshotId})
        > {
  $$OutboxTableTableManager(_$AppDatabase db, $OutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> snapshotId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxCompanion(
                id: id,
                sessionId: sessionId,
                snapshotId: snapshotId,
                idempotencyKey: idempotencyKey,
                state: state,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String snapshotId,
                required String idempotencyKey,
                required String state,
                Value<int> attempts = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => OutboxCompanion.insert(
                id: id,
                sessionId: sessionId,
                snapshotId: snapshotId,
                idempotencyKey: idempotencyKey,
                state: state,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OutboxTable, OutboxRow>(table),
                  $$OutboxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, snapshotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sessionId,
                        referencedTable: $$OutboxTableReferences
                            ._sessionIdTable(db),
                        referencedColumn: $$OutboxTableReferences
                            ._sessionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (snapshotId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.snapshotId,
                        referencedTable: $$OutboxTableReferences
                            ._snapshotIdTable(db),
                        referencedColumn: $$OutboxTableReferences
                            ._snapshotIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxTable,
      OutboxRow,
      $$OutboxTableFilterComposer,
      $$OutboxTableOrderingComposer,
      $$OutboxTableAnnotationComposer,
      $$OutboxTableCreateCompanionBuilder,
      $$OutboxTableUpdateCompanionBuilder,
      (OutboxRow, $$OutboxTableReferences),
      OutboxRow,
      PrefetchHooks Function({bool sessionId, bool snapshotId})
    >;
typedef $$CalendarCacheTableCreateCompanionBuilder =
    CalendarCacheCompanion Function({
      required String date,
      required String schoolYear,
      required String term,
      required String calendarStatus,
      Value<String?> comment,
      Value<bool> blockReady,
      Value<String?> serverStatus,
      Value<int> serverVersion,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$CalendarCacheTableUpdateCompanionBuilder =
    CalendarCacheCompanion Function({
      Value<String> date,
      Value<String> schoolYear,
      Value<String> term,
      Value<String> calendarStatus,
      Value<String?> comment,
      Value<bool> blockReady,
      Value<String?> serverStatus,
      Value<int> serverVersion,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$CalendarCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarCacheTable> {
  $$CalendarCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolYear => $composableBuilder(
    column: $table.schoolYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calendarStatus => $composableBuilder(
    column: $table.calendarStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get blockReady => $composableBuilder(
    column: $table.blockReady,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarCacheTable> {
  $$CalendarCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolYear => $composableBuilder(
    column: $table.schoolYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calendarStatus => $composableBuilder(
    column: $table.calendarStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get blockReady => $composableBuilder(
    column: $table.blockReady,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarCacheTable> {
  $$CalendarCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get schoolYear => $composableBuilder(
    column: $table.schoolYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get calendarStatus => $composableBuilder(
    column: $table.calendarStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get blockReady => $composableBuilder(
    column: $table.blockReady,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverStatus => $composableBuilder(
    column: $table.serverStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CalendarCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarCacheTable,
          CalendarRow,
          $$CalendarCacheTableFilterComposer,
          $$CalendarCacheTableOrderingComposer,
          $$CalendarCacheTableAnnotationComposer,
          $$CalendarCacheTableCreateCompanionBuilder,
          $$CalendarCacheTableUpdateCompanionBuilder,
          (
            CalendarRow,
            BaseReferences<_$AppDatabase, $CalendarCacheTable, CalendarRow>,
          ),
          CalendarRow,
          PrefetchHooks Function()
        > {
  $$CalendarCacheTableTableManager(_$AppDatabase db, $CalendarCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<String> schoolYear = const Value.absent(),
                Value<String> term = const Value.absent(),
                Value<String> calendarStatus = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool> blockReady = const Value.absent(),
                Value<String?> serverStatus = const Value.absent(),
                Value<int> serverVersion = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarCacheCompanion(
                date: date,
                schoolYear: schoolYear,
                term: term,
                calendarStatus: calendarStatus,
                comment: comment,
                blockReady: blockReady,
                serverStatus: serverStatus,
                serverVersion: serverVersion,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required String schoolYear,
                required String term,
                required String calendarStatus,
                Value<String?> comment = const Value.absent(),
                Value<bool> blockReady = const Value.absent(),
                Value<String?> serverStatus = const Value.absent(),
                Value<int> serverVersion = const Value.absent(),
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => CalendarCacheCompanion.insert(
                date: date,
                schoolYear: schoolYear,
                term: term,
                calendarStatus: calendarStatus,
                comment: comment,
                blockReady: blockReady,
                serverStatus: serverStatus,
                serverVersion: serverVersion,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CalendarCacheTable, CalendarRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CalendarCacheTable,
                    CalendarRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarCacheTable,
      CalendarRow,
      $$CalendarCacheTableFilterComposer,
      $$CalendarCacheTableOrderingComposer,
      $$CalendarCacheTableAnnotationComposer,
      $$CalendarCacheTableCreateCompanionBuilder,
      $$CalendarCacheTableUpdateCompanionBuilder,
      (
        CalendarRow,
        BaseReferences<_$AppDatabase, $CalendarCacheTable, CalendarRow>,
      ),
      CalendarRow,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      required String id,
      required String type,
      Value<String?> sessionDate,
      Value<String?> comment,
      Value<bool> read,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String?> sessionDate,
      Value<String?> comment,
      Value<bool> read,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get read => $composableBuilder(
    column: $table.read,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          NotificationRow,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            NotificationRow,
            BaseReferences<_$AppDatabase, $NotificationsTable, NotificationRow>,
          ),
          NotificationRow,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> sessionDate = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool> read = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                type: type,
                sessionDate: sessionDate,
                comment: comment,
                read: read,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                Value<String?> sessionDate = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<bool> read = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                type: type,
                sessionDate: sessionDate,
                comment: comment,
                read: read,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationsTable, NotificationRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationsTable,
                    NotificationRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      NotificationRow,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        NotificationRow,
        BaseReferences<_$AppDatabase, $NotificationsTable, NotificationRow>,
      ),
      NotificationRow,
      PrefetchHooks Function()
    >;
typedef $$KvTableCreateCompanionBuilder = KvCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$KvTableUpdateCompanionBuilder = KvCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$KvTableFilterComposer extends Composer<_$AppDatabase, $KvTable> {
  $$KvTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KvTableOrderingComposer extends Composer<_$AppDatabase, $KvTable> {
  $$KvTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KvTableAnnotationComposer extends Composer<_$AppDatabase, $KvTable> {
  $$KvTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KvTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KvTable,
          KvRow,
          $$KvTableFilterComposer,
          $$KvTableOrderingComposer,
          $$KvTableAnnotationComposer,
          $$KvTableCreateCompanionBuilder,
          $$KvTableUpdateCompanionBuilder,
          (KvRow, BaseReferences<_$AppDatabase, $KvTable, KvRow>),
          KvRow,
          PrefetchHooks Function()
        > {
  $$KvTableTableManager(_$AppDatabase db, $KvTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KvTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KvTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KvTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => KvCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => KvCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KvTable, KvRow>(table),
                  BaseReferences<_$AppDatabase, $KvTable, KvRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KvTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KvTable,
      KvRow,
      $$KvTableFilterComposer,
      $$KvTableOrderingComposer,
      $$KvTableAnnotationComposer,
      $$KvTableCreateCompanionBuilder,
      $$KvTableUpdateCompanionBuilder,
      (KvRow, BaseReferences<_$AppDatabase, $KvTable, KvRow>),
      KvRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsLocalTableTableManager get sessionsLocal =>
      $$SessionsLocalTableTableManager(_db, _db.sessionsLocal);
  $$StudentGradesLocalTableTableManager get studentGradesLocal =>
      $$StudentGradesLocalTableTableManager(_db, _db.studentGradesLocal);
  $$SnapshotsTableTableManager get snapshots =>
      $$SnapshotsTableTableManager(_db, _db.snapshots);
  $$OutboxTableTableManager get outbox =>
      $$OutboxTableTableManager(_db, _db.outbox);
  $$CalendarCacheTableTableManager get calendarCache =>
      $$CalendarCacheTableTableManager(_db, _db.calendarCache);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$KvTableTableManager get kv => $$KvTableTableManager(_db, _db.kv);
}
