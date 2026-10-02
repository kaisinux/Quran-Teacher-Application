import '../../../core/utils/date_only.dart';
import 'session_status.dart';

/// One row of `Calendrier`, enriched by the server for the teacher's group.
class SchoolSession {
  const SchoolSession({
    required this.date,
    required this.schoolYear,
    required this.term,
    required this.calendarStatus,
    this.comment,
    this.blockReady = false,
    this.serverStatus,
    this.serverVersion = 0,
  });

  final DateOnly date;
  final String schoolYear; // "2026-2027"
  final String term; // "T1"
  final CalendarDayStatus calendarStatus;
  final String? comment;

  /// The date is written in row 4 of a block of the group sheet
  /// (sheets are prepared by hand — decision Q3).
  final bool blockReady;

  final SessionStatus? serverStatus;
  final int serverVersion;

  bool get isClassDay => calendarStatus == CalendarDayStatus.classDay;

  factory SchoolSession.fromJson(Map<String, Object?> json) => SchoolSession(
        date: DateOnly.parse(json['date']! as String),
        schoolYear: json['schoolYear']! as String,
        term: json['term']! as String,
        calendarStatus: CalendarDayStatus.fromWire(json['calendarStatus']! as String),
        comment: json['comment'] as String?,
        blockReady: json['blockReady'] as bool? ?? false,
        serverStatus: SessionStatus.tryFromWire(json['serverStatus'] as String?),
        serverVersion: (json['serverVersion'] as num?)?.toInt() ?? 0,
      );

  Map<String, Object?> toJson() => {
        'date': date.toIso(),
        'schoolYear': schoolYear,
        'term': term,
        'calendarStatus': calendarStatus.wire,
        'comment': comment,
        'blockReady': blockReady,
        'serverStatus': serverStatus?.wire,
        'serverVersion': serverVersion,
      };
}

class Group {
  const Group({
    required this.groupId,
    required this.nameFr,
    required this.nameAr,
    this.teacherName,
    this.active = true,
  });

  final String groupId; // "G05"
  final String nameFr;
  final String nameAr;
  final String? teacherName;
  final bool active;

  factory Group.fromJson(Map<String, Object?> json) => Group(
        groupId: json['groupId']! as String,
        nameFr: json['nameFr'] as String? ?? json['groupId']! as String,
        nameAr: json['nameAr'] as String? ?? '',
        teacherName: json['teacherName'] as String?,
        active: json['active'] as bool? ?? true,
      );

  Map<String, Object?> toJson() => {
        'groupId': groupId,
        'nameFr': nameFr,
        'nameAr': nameAr,
        'teacherName': teacherName,
        'active': active,
      };
}
