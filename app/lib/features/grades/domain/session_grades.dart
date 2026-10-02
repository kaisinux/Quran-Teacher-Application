import '../../../core/utils/date_only.dart';
import '../../sessions/domain/session_status.dart';
import 'grade_validator.dart';
import 'student_grade.dart';

/// A session of a group with all its grades, as stored on the device.
class SessionGrades {
  const SessionGrades({
    required this.localId,
    required this.groupId,
    required this.sessionDate,
    required this.status,
    required this.grades,
    this.sessionNumber,
    this.serverStatus,
    this.serverVersion = 0,
    this.baseHash,
    this.correctionComment,
    this.pendingChanges = 0,
    this.lastSyncError,
    this.updatedAt,
    this.synchronizedAt,
  });

  final String localId;
  final String groupId;
  final DateOnly sessionDate;
  final int? sessionNumber;

  /// Workflow status shown to the teacher.
  final SessionStatus status;

  /// Last status confirmed by the server.
  final SessionStatus? serverStatus;

  /// Version downloaded (0 = never sent). Sent back to detect conflicts.
  final int serverVersion;

  /// Hash of the sheet block when downloaded (detects manual sheet edits).
  final String? baseHash;

  final String? correctionComment;

  /// Students changed locally since the last download / sync.
  final int pendingChanges;
  final String? lastSyncError;
  final DateTime? updatedAt;
  final DateTime? synchronizedAt;

  /// Always in sheet order.
  final List<StudentGrade> grades;

  bool get isEditable => status.isEditableByTeacher;

  SessionSummary get summary => SessionSummary.of(grades);
}

/// Figures shown before sending and on the admin dashboard.
class SessionSummary {
  const SessionSummary({
    required this.students,
    required this.present,
    required this.absent,
    required this.notEvaluated,
    required this.disciplineRemarks,
    required this.blockingIssues,
  });

  factory SessionSummary.of(List<StudentGrade> grades) {
    final issues = GradeValidator.validateSessionBeforeSubmit(grades);
    final present = grades.where((g) => g.isPresent).toList();
    return SessionSummary(
      students: grades.length,
      present: present.length,
      absent: grades.length - present.length,
      notEvaluated: issues.where((i) => i.code == IssueCode.notEvaluated).length,
      disciplineRemarks: present
          .where((g) =>
              GradeValidator.requiresDisciplineRemark(g) &&
              g.normalizedRemark != null)
          .length,
      blockingIssues: issues.where((i) => i.isBlocking).length,
    );
  }

  final int students;
  final int present;
  final int absent;

  /// Number of "--" grades among present students.
  final int notEvaluated;

  /// Discipline < 7 with the mandatory remark.
  final int disciplineRemarks;
  final int blockingIssues;

  bool get canSubmit => blockingIssues == 0;
}
