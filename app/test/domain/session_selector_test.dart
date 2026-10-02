import 'package:flutter_test/flutter_test.dart';
import 'package:misk_teacher/core/utils/date_only.dart';
import 'package:misk_teacher/features/sessions/domain/school_session.dart';
import 'package:misk_teacher/features/sessions/domain/session_selector.dart';
import 'package:misk_teacher/features/sessions/domain/session_status.dart';

SchoolSession _day(String iso, {bool cours = true}) => SchoolSession(
      date: DateOnly.parse(iso),
      schoolYear: '2026-2027',
      term: 'T1',
      calendarStatus: cours ? CalendarDayStatus.classDay : CalendarDayStatus.noClass,
    );

void main() {
  final calendar = [
    _day('2026-09-06', cours: false),
    _day('2026-09-13'),
    _day('2026-09-20'),
    _day('2026-09-27'),
    _day('2026-10-04'),
    _day('2026-10-11', cours: false),
    _day('2026-10-18'),
  ];

  DateOnly d(String iso) => DateOnly.parse(iso);

  test('on a Sunday with class: proposes today', () {
    expect(SessionSelector.defaultSession(calendar, d('2026-09-27'))!.date, d('2026-09-27'));
  });

  test('on a weekday: proposes the previous class Sunday', () {
    // Friday 2026-10-02.
    expect(SessionSelector.defaultSession(calendar, d('2026-10-02'))!.date, d('2026-09-27'));
  });

  test('never proposes a Sunday without class', () {
    // Sunday 2026-10-11 is PAS_COURS → previous class day.
    expect(SessionSelector.defaultSession(calendar, d('2026-10-11'))!.date, d('2026-10-04'));
    expect(SessionSelector.defaultSession(calendar, d('2026-10-14'))!.date, d('2026-10-04'));
  });

  test('null before the first class day', () {
    expect(SessionSelector.defaultSession(calendar, d('2026-09-08')), isNull);
  });

  test('selectable: class days up to today, newest first', () {
    final list = SessionSelector.selectable(calendar, d('2026-10-02'));
    expect(list.map((s) => s.date.toIso()), ['2026-09-27', '2026-09-20', '2026-09-13']);
  });

  test('DateOnly parsing and weekday', () {
    expect(d('2026-09-27').isSunday, isTrue);
    expect(d('2026-09-28').isSunday, isFalse);
    expect(() => DateOnly.parse('2026-02-31'), throwsFormatException);
    expect(() => DateOnly.parse('27-09-2026'), throwsFormatException);
  });
}
