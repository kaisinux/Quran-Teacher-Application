import '../../features/grades/domain/student_grade.dart';
import '../../features/sessions/domain/school_session.dart';
import '../../features/sessions/domain/session_status.dart';
import '../utils/date_only.dart';

/// `sessions.list`: the teacher's group and its calendar.
class SessionsOverview {
  const SessionsOverview({required this.group, required this.sessions});

  final Group group;
  final List<SchoolSession> sessions;

  factory SessionsOverview.fromJson(Map<String, Object?> json) =>
      SessionsOverview(
        group: Group.fromJson(json['group']! as Map<String, Object?>),
        sessions: [
          for (final s in json['sessions']! as List<Object?>)
            SchoolSession.fromJson(s! as Map<String, Object?>),
        ],
      );
}

/// `session.get` / `admin.session.get`: one session as stored in the sheet.
class ServerSession {
  const ServerSession({
    required this.groupId,
    required this.sessionDate,
    required this.version,
    required this.baseHash,
    required this.grades,
    this.sessionNumber,
    this.status,
    this.correctionComment,
    this.teacherName,
  });

  final String groupId;
  final DateOnly sessionDate;
  final int? sessionNumber;

  /// `null` when never sent through the app.
  final SessionStatus? status;
  final int version;
  final String baseHash;
  final String? correctionComment;
  final String? teacherName;

  /// In sheet order.
  final List<StudentGrade> grades;

  factory ServerSession.fromJson(Map<String, Object?> json) => ServerSession(
        groupId: json['groupId']! as String,
        sessionDate: DateOnly.parse(json['sessionDate']! as String),
        sessionNumber: (json['sessionNumber'] as num?)?.toInt(),
        status: SessionStatus.tryFromWire(json['status'] as String?),
        version: (json['version'] as num?)?.toInt() ?? 0,
        baseHash: json['baseHash']! as String,
        correctionComment: json['correctionComment'] as String?,
        teacherName: json['teacherName'] as String?,
        grades: [
          for (final g in json['grades']! as List<Object?>)
            StudentGrade.fromJson(g! as Map<String, Object?>),
        ],
      );

  Map<String, Object?> toJson() => {
        'groupId': groupId,
        'sessionDate': sessionDate.toIso(),
        'sessionNumber': sessionNumber,
        'status': status?.wire,
        'version': version,
        'baseHash': baseHash,
        'correctionComment': correctionComment,
        'teacherName': teacherName,
        'grades': [for (final g in grades) g.toJson()],
      };
}

/// `session.submit` parameters. Matches the payload of the specification
/// plus the conflict/idempotency fields.
class SubmitRequest {
  const SubmitRequest({
    required this.groupId,
    required this.sessionDate,
    required this.baseVersion,
    required this.baseHash,
    required this.idempotencyKey,
    required this.grades,
  });

  final String groupId;
  final DateOnly sessionDate;
  final int baseVersion;
  final String? baseHash;
  final String idempotencyKey;
  final List<StudentGrade> grades;

  Map<String, Object?> toJson() => {
        'groupId': groupId,
        'sessionDate': sessionDate.toIso(),
        'baseVersion': baseVersion,
        'baseHash': baseHash,
        'idempotencyKey': idempotencyKey,
        'grades': [for (final g in grades) g.toJson()],
      };

  factory SubmitRequest.fromJson(Map<String, Object?> json) => SubmitRequest(
        groupId: json['groupId']! as String,
        sessionDate: DateOnly.parse(json['sessionDate']! as String),
        baseVersion: (json['baseVersion']! as num).toInt(),
        baseHash: json['baseHash'] as String?,
        idempotencyKey: json['idempotencyKey']! as String,
        grades: [
          for (final g in json['grades']! as List<Object?>)
            StudentGrade.fromJson(g! as Map<String, Object?>),
        ],
      );
}

class SubmitResult {
  const SubmitResult({
    required this.version,
    required this.baseHash,
    required this.status,
  });

  final int version;
  final String baseHash;
  final SessionStatus status;

  factory SubmitResult.fromJson(Map<String, Object?> json) => SubmitResult(
        version: (json['version']! as num).toInt(),
        baseHash: json['baseHash']! as String,
        status: SessionStatus.fromWire(json['status']! as String),
      );
}

/// One line of the admin dashboard.
class AdminGroupRow {
  const AdminGroupRow({
    required this.group,
    required this.sessionDate,
    this.status,
    this.blockReady = true,
    this.studentCount,
  });

  final Group group;
  final DateOnly sessionDate;

  /// `null` = not sent yet.
  final SessionStatus? status;
  final bool blockReady;
  final int? studentCount;

  factory AdminGroupRow.fromJson(Map<String, Object?> json) => AdminGroupRow(
        group: Group.fromJson(json['group']! as Map<String, Object?>),
        sessionDate: DateOnly.parse(json['sessionDate']! as String),
        status: SessionStatus.tryFromWire(json['status'] as String?),
        blockReady: json['blockReady'] as bool? ?? true,
        studentCount: (json['studentCount'] as num?)?.toInt(),
      );
}

/// In-app notification (V1: no push).
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.createdAt,
    this.groupId,
    this.sessionDate,
    this.comment,
  });

  final String id;

  /// `SESSION_VALIDATED` | `SESSION_NEEDS_CORRECTION`.
  final String type;
  final DateTime createdAt;
  final String? groupId;
  final DateOnly? sessionDate;
  final String? comment;

  factory AppNotification.fromJson(Map<String, Object?> json) => AppNotification(
        id: json['id']! as String,
        type: json['type']! as String,
        createdAt: DateTime.parse(json['createdAt']! as String),
        groupId: json['groupId'] as String?,
        sessionDate: json['sessionDate'] == null
            ? null
            : DateOnly.parse(json['sessionDate']! as String),
        comment: json['comment'] as String?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type,
        'createdAt': createdAt.toUtc().toIso8601String(),
        'groupId': groupId,
        'sessionDate': sessionDate?.toIso(),
        'comment': comment,
      };
}
