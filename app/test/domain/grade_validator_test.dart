import 'package:flutter_test/flutter_test.dart';
import 'package:misk_teacher/features/grades/domain/grade_validator.dart';
import 'package:misk_teacher/features/grades/domain/student_grade.dart';

StudentGrade _g({
  double? h,
  double? t,
  double? d,
  bool present = true,
  String? remark,
}) =>
    StudentGrade(
      studentId: 'num:1',
      studentName: 'Élève',
      order: 1,
      hifz: h,
      tajwid: t,
      discipline: d,
      attendance: present ? Attendance.present : Attendance.absent,
      remark: remark,
    );

void main() {
  group('isValidQuarterGrade', () {
    test('accepts every quarter from 0 to 10', () {
      for (var q = 0; q <= 40; q++) {
        expect(GradeValidator.isValidQuarterGrade(q / 4), isTrue, reason: '${q / 4}');
      }
    });

    test('rejects values from the specification', () {
      for (final v in [8.2, 9.1, 10.25, -1.0, -0.25, 11.0, double.nan, double.infinity]) {
        expect(GradeValidator.isValidQuarterGrade(v), isFalse, reason: '$v');
      }
    });
  });

  group('parseGradeInput', () {
    test('"--" and empty mean not evaluated (null), never 0', () {
      expect(GradeValidator.parseGradeInput('--'), isNull);
      expect(GradeValidator.parseGradeInput(''), isNull);
      expect(GradeValidator.parseGradeInput('0'), 0);
    });

    test('accepts comma and dot decimals', () {
      expect(GradeValidator.parseGradeInput('8,75'), 8.75);
      expect(GradeValidator.parseGradeInput(' 9.5 '), 9.5);
    });

    test('rejects invalid input', () {
      for (final s in ['8.2', 'abc', '10.25', '-1']) {
        expect(() => GradeValidator.parseGradeInput(s), throwsFormatException, reason: s);
      }
    });
  });

  group('presence', () {
    test('only 0 or 10, mandatory', () {
      expect(GradeValidator.validatePresence(10), isTrue);
      expect(GradeValidator.validatePresence(0), isTrue);
      expect(GradeValidator.validatePresence(5), isFalse);
      expect(GradeValidator.validatePresence(null), isFalse);
      expect(() => Attendance.fromSheetValue(5), throwsFormatException);
    });

    test('new entry defaults to absent with nothing evaluated', () {
      final g = StudentGrade.initial(studentId: 'num:1', studentName: 'A', order: 1);
      expect(g.attendance, Attendance.absent);
      expect([g.hifz, g.tajwid, g.discipline, g.remark], everyElement(isNull));
    });
  });

  group('discipline remark', () {
    test('required when discipline < 7', () {
      expect(GradeValidator.requiresDisciplineRemark(_g(d: 6.75)), isTrue);
      expect(GradeValidator.requiresDisciplineRemark(_g(d: 7)), isFalse);
      expect(GradeValidator.requiresDisciplineRemark(_g(d: null)), isFalse);
      expect(GradeValidator.requiresDisciplineRemark(_g(d: 0)), isTrue);
    });

    test('blocks submission without remark, blank remark counts as missing', () {
      expect(GradeValidator.canSubmit([_g(d: 5)]), isFalse);
      expect(GradeValidator.canSubmit([_g(d: 5, remark: '   ')]), isFalse);
      expect(GradeValidator.canSubmit([_g(d: 5, remark: 'Bavardages')]), isTrue);
    });

    test('not asked for an absent student', () {
      final issues = GradeValidator.validateStudent(_g(present: false));
      expect(issues, isEmpty);
    });
  });

  group('absence', () {
    test('normalize clears grades of an absent student', () {
      final g = GradeValidator.normalize(_g(h: 9, t: 8, d: 10, present: false));
      expect([g.hifz, g.tajwid, g.discipline], everyElement(isNull));
    });

    test('absent with grades is an error', () {
      final issues = GradeValidator.validateStudent(_g(h: 9, present: false));
      expect(issues.single.code, IssueCode.absentWithGrade);
      expect(issues.single.isBlocking, isTrue);
    });

    test('normalize keeps a present student untouched', () {
      final g = _g(h: 9, t: 8, d: 10);
      expect(GradeValidator.normalize(g), g);
    });
  });

  test('not evaluated grades are warnings, not errors', () {
    final issues = GradeValidator.validateStudent(_g(h: 9));
    expect(issues.map((i) => i.code), everyElement(IssueCode.notEvaluated));
    expect(issues, hasLength(2));
    expect(GradeValidator.canSubmit([_g(h: 9)]), isTrue);
  });

  test('session-level checks: empty and duplicates', () {
    expect(GradeValidator.canSubmit([]), isFalse);
    expect(GradeValidator.canSubmit([_g(h: 9), _g(h: 8)]), isFalse);
  });
}
