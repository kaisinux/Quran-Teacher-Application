import 'package:flutter_test/flutter_test.dart';
import 'package:misk_teacher/features/sessions/domain/session_status.dart';

void main() {
  test('VALIDATED is locked for the teacher', () {
    expect(SessionStatus.validated.isEditableByTeacher, isFalse);
    expect(() => SessionStatus.validated.afterTeacherEdit(), throwsStateError);
  });

  test('a queued upload must be cancelled before editing', () {
    expect(SessionStatus.sent.isEditableByTeacher, isFalse);
  });

  test('editing a synced or returned session makes it a draft again', () {
    for (final s in [
      SessionStatus.draft,
      SessionStatus.ready,
      SessionStatus.synced,
      SessionStatus.needsCorrection,
    ]) {
      expect(s.afterTeacherEdit(), SessionStatus.draft, reason: s.wire);
    }
  });
}
