import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:misk_teacher/core/api/api_models.dart';
import 'package:misk_teacher/core/utils/date_only.dart';
import 'package:misk_teacher/features/auth/domain/app_user.dart';
import 'package:misk_teacher/features/grades/domain/student_grade.dart';
import 'package:misk_teacher/features/sessions/domain/session_status.dart';

void main() {
  test('StudentGrade JSON matches the API payload; null stays null', () {
    const g = StudentGrade(
      studentId: 'num:2',
      studentName: 'محمد',
      order: 2,
      attendance: Attendance.absent,
    );
    final json = g.toJson();
    expect(json, {
      'studentId': 'num:2',
      'studentName': 'محمد',
      'order': 2,
      'hifz': null,
      'tajwid': null,
      'discipline': null,
      'presence': 0,
      'remark': null,
    });
    expect(StudentGrade.fromJson(jsonDecode(jsonEncode(json)) as Map<String, Object?>), g);
  });

  test('presence 10 ↔ present, quarter grades preserved', () {
    final g = StudentGrade.fromJson({
      'studentId': 'num:1',
      'studentName': 'أحمد',
      'order': 1,
      'hifz': 9.75,
      'tajwid': 9.25,
      'discipline': 10,
      'presence': 10,
      'remark': null,
    });
    expect(g.isPresent, isTrue);
    expect(g.hifz, 9.75);
    expect(g.discipline, 10.0);
    expect(g.toJson()['presence'], 10);
  });

  test('empty presence in the sheet defaults to absent', () {
    final g = StudentGrade.fromJson({'studentId': 'row:9', 'studentName': 'X', 'order': 9});
    expect(g.attendance, Attendance.absent);
  });

  test('SubmitRequest round trip', () {
    final request = SubmitRequest(
      groupId: 'G01',
      sessionDate: DateOnly.parse('2026-09-27'),
      baseVersion: 3,
      baseHash: 'abc',
      idempotencyKey: 'k1',
      grades: const [StudentGrade(studentId: 'num:1', studentName: 'A', order: 1, hifz: 8.5)],
    );
    final copy = SubmitRequest.fromJson(
        jsonDecode(jsonEncode(request.toJson())) as Map<String, Object?>);
    expect(copy.sessionDate, request.sessionDate);
    expect(copy.baseVersion, 3);
    expect(copy.grades.single, request.grades.single);
  });

  test('statuses use the wire names of the specification', () {
    expect(SessionStatus.values.map((s) => s.wire),
        ['DRAFT', 'READY', 'SENT', 'SYNCED', 'NEEDS_CORRECTION', 'VALIDATED']);
    expect(SessionStatus.fromWire('NEEDS_CORRECTION'), SessionStatus.needsCorrection);
  });

  test('AppUser JSON', () {
    const t = Teacher(email: 'a@b.c', displayName: 'A', groupId: 'G05', groupName: 'Rahman-1');
    expect(AppUser.fromJson(t.toJson()), isA<Teacher>());
    expect((AppUser.fromJson(t.toJson()) as Teacher).groupId, 'G05');
    const admin = AdminUser(email: 'x@y.z', displayName: 'X');
    expect(AppUser.fromJson(admin.toJson()), isA<AdminUser>());
  });
}
