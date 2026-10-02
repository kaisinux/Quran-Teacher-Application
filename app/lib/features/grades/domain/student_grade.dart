/// Attendance of a student for one session.
///
/// V1 only knows present (10) and absent (0). The enum leaves room for
/// "absent excusé", "retard"… without changing the storage model: the sheet
/// value is derived through [sheetValue].
enum Attendance {
  present('PRESENT', 10),
  absent('ABSENT', 0);

  const Attendance(this.wire, this.sheetValue);

  final String wire;

  /// Value written in the "حضور" column.
  final int sheetValue;

  bool get countsAsPresent => this == present;

  static Attendance fromWire(String wire) => Attendance.values.firstWhere(
        (a) => a.wire == wire,
        orElse: () => throw FormatException('Présence inconnue', wire),
      );

  /// Accepts only 0 or 10 in V1.
  static Attendance fromSheetValue(num value) => switch (value) {
        10 => present,
        0 => absent,
        _ => throw FormatException('Présence doit valoir 0 ou 10', value),
      };
}

/// Grades of one student for one session.
///
/// `null` means "non évalué" (displayed "--"); it is never the same as 0.
class StudentGrade {
  const StudentGrade({
    required this.studentId,
    required this.studentName,
    required this.order,
    this.hifz,
    this.tajwid,
    this.discipline,
    this.attendance = Attendance.absent,
    this.remark,
  });

  /// New entry: absent, nothing evaluated, no remark (never prefilled to 10).
  factory StudentGrade.initial({
    required String studentId,
    required String studentName,
    required int order,
  }) =>
      StudentGrade(studentId: studentId, studentName: studentName, order: order);

  /// Server identifier: `num:<رقم التلميذ>` or `row:<n>` (see architecture §8.4).
  final String studentId;
  final String studentName;

  /// Position in the group sheet. Lists are never sorted alphabetically.
  final int order;

  final double? hifz;
  final double? tajwid;
  final double? discipline;
  final Attendance attendance;
  final String? remark;

  bool get isPresent => attendance.countsAsPresent;

  /// Trimmed remark, `null` when blank.
  String? get normalizedRemark {
    final r = remark?.trim();
    return (r == null || r.isEmpty) ? null : r;
  }

  StudentGrade copyWith({
    double? Function()? hifz,
    double? Function()? tajwid,
    double? Function()? discipline,
    Attendance? attendance,
    String? Function()? remark,
  }) =>
      StudentGrade(
        studentId: studentId,
        studentName: studentName,
        order: order,
        hifz: hifz == null ? this.hifz : hifz(),
        tajwid: tajwid == null ? this.tajwid : tajwid(),
        discipline: discipline == null ? this.discipline : discipline(),
        attendance: attendance ?? this.attendance,
        remark: remark == null ? this.remark : remark(),
      );

  Map<String, Object?> toJson() => {
        'studentId': studentId,
        'studentName': studentName,
        'order': order,
        'hifz': hifz,
        'tajwid': tajwid,
        'discipline': discipline,
        'presence': attendance.sheetValue,
        'remark': normalizedRemark,
      };

  factory StudentGrade.fromJson(Map<String, Object?> json) => StudentGrade(
        studentId: json['studentId']! as String,
        studentName: json['studentName']! as String,
        order: (json['order']! as num).toInt(),
        hifz: (json['hifz'] as num?)?.toDouble(),
        tajwid: (json['tajwid'] as num?)?.toDouble(),
        discipline: (json['discipline'] as num?)?.toDouble(),
        // Empty presence in the sheet = default absent (rule §11).
        attendance: json['presence'] == null
            ? Attendance.absent
            : Attendance.fromSheetValue(json['presence']! as num),
        remark: json['remark'] as String?,
      );

  @override
  bool operator ==(Object other) =>
      other is StudentGrade &&
      other.studentId == studentId &&
      other.studentName == studentName &&
      other.order == order &&
      other.hifz == hifz &&
      other.tajwid == tajwid &&
      other.discipline == discipline &&
      other.attendance == attendance &&
      other.normalizedRemark == normalizedRemark;

  @override
  int get hashCode => Object.hash(studentId, studentName, order, hifz, tajwid,
      discipline, attendance, normalizedRemark);

  @override
  String toString() =>
      'StudentGrade($studentId, h=$hifz, t=$tajwid, d=$discipline, ${attendance.wire})';
}
