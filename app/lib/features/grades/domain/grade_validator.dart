import 'student_grade.dart';

enum GradeField { hifz, tajwid, discipline, presence, remark }

enum IssueSeverity { error, warning }

enum IssueCode {
  /// Value outside 0..10 or not a multiple of 0.25.
  invalidGradeValue,

  /// Absent student with a grade (must be "--").
  absentWithGrade,

  /// Discipline < 7 without a remark.
  missingDisciplineRemark,

  /// Present student with an unevaluated grade (allowed, reported).
  notEvaluated,

  /// Same student twice in a session.
  duplicateStudent,

  /// Empty session.
  noStudents,
}

class ValidationIssue {
  const ValidationIssue({
    required this.code,
    required this.severity,
    this.studentId,
    this.field,
  });

  final IssueCode code;
  final IssueSeverity severity;
  final String? studentId;
  final GradeField? field;

  bool get isBlocking => severity == IssueSeverity.error;

  @override
  String toString() => 'ValidationIssue(${code.name}, $studentId, ${field?.name})';
}

/// Single source of truth for grade rules on the device.
///
/// The Apps Script backend runs a mirror of these rules on every upload;
/// both are tested against the same fixtures.
abstract final class GradeValidator {
  static const double minGrade = 0;
  static const double maxGrade = 10;
  static const double step = 0.25;
  static const double disciplineRemarkThreshold = 7;

  /// 0, 0.25, 0.5 … 10. Rejects 8.2, 10.25, -1, NaN.
  static bool isValidQuarterGrade(double value) {
    if (value.isNaN || value.isInfinite) return false;
    if (value < minGrade || value > maxGrade) return false;
    final quarters = value / step;
    return (quarters - quarters.roundToDouble()).abs() < 1e-9;
  }

  /// Optional grade: `null` ("--") or a valid quarter grade.
  static bool isValidOptionalGrade(double? value) =>
      value == null || isValidQuarterGrade(value);

  /// Presence is mandatory and is 0 or 10 in V1.
  static bool validatePresence(num? rawValue) =>
      rawValue != null && (rawValue == 0 || rawValue == 10);

  /// A remark is mandatory when discipline is a real number below 7.
  static bool requiresDisciplineRemark(StudentGrade grade) {
    final discipline = grade.discipline;
    return grade.isPresent &&
        discipline != null &&
        discipline < disciplineRemarkThreshold;
  }

  /// An absent student has no Hifz/Tajwid/Discipline.
  static bool validateAbsentStudent(StudentGrade grade) =>
      grade.isPresent ||
      (grade.hifz == null && grade.tajwid == null && grade.discipline == null);

  /// Applies automatic rules after an edit: marking a student absent clears
  /// the three grades.
  static StudentGrade normalize(StudentGrade grade) {
    if (grade.isPresent) return grade;
    if (validateAbsentStudent(grade)) return grade;
    return grade.copyWith(
      hifz: () => null,
      tajwid: () => null,
      discipline: () => null,
    );
  }

  /// Parses a teacher entry ("8,75", "8.75", "--", ""). Returns `null` for
  /// "not evaluated"; throws [FormatException] for anything invalid.
  static double? parseGradeInput(String input) {
    final text = input.trim();
    if (text.isEmpty || text == '--' || text == '-') return null;
    final value = double.tryParse(text.replaceAll(',', '.'));
    if (value == null || !isValidQuarterGrade(value)) {
      throw FormatException('Note invalide', input);
    }
    return value;
  }

  /// Issues for one student.
  static List<ValidationIssue> validateStudent(StudentGrade grade) {
    final issues = <ValidationIssue>[];
    void add(IssueCode code, IssueSeverity severity, GradeField field) =>
        issues.add(ValidationIssue(
          code: code,
          severity: severity,
          studentId: grade.studentId,
          field: field,
        ));

    final fields = {
      GradeField.hifz: grade.hifz,
      GradeField.tajwid: grade.tajwid,
      GradeField.discipline: grade.discipline,
    };
    for (final entry in fields.entries) {
      if (!isValidOptionalGrade(entry.value)) {
        add(IssueCode.invalidGradeValue, IssueSeverity.error, entry.key);
      }
    }

    if (!grade.isPresent) {
      if (!validateAbsentStudent(grade)) {
        add(IssueCode.absentWithGrade, IssueSeverity.error, GradeField.presence);
      }
      return issues;
    }

    if (requiresDisciplineRemark(grade) && grade.normalizedRemark == null) {
      add(IssueCode.missingDisciplineRemark, IssueSeverity.error,
          GradeField.remark);
    }
    for (final entry in fields.entries) {
      if (entry.value == null) {
        add(IssueCode.notEvaluated, IssueSeverity.warning, entry.key);
      }
    }
    return issues;
  }

  /// Everything that must be checked before "Envoyer".
  static List<ValidationIssue> validateSessionBeforeSubmit(
    List<StudentGrade> grades,
  ) {
    if (grades.isEmpty) {
      return const [
        ValidationIssue(code: IssueCode.noStudents, severity: IssueSeverity.error),
      ];
    }
    final issues = <ValidationIssue>[];
    final seen = <String>{};
    for (final grade in grades) {
      if (!seen.add(grade.studentId)) {
        issues.add(ValidationIssue(
          code: IssueCode.duplicateStudent,
          severity: IssueSeverity.error,
          studentId: grade.studentId,
        ));
      }
      issues.addAll(validateStudent(grade));
    }
    return issues;
  }

  static bool canSubmit(List<StudentGrade> grades) =>
      !validateSessionBeforeSubmit(grades).any((i) => i.isBlocking);
}
