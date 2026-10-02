import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../grades/data/grades_repository.dart';
import '../../grades/domain/session_grades.dart';
import '../data/sessions_repository.dart';
import '../domain/school_session.dart';
import '../domain/session_selector.dart';
import '../domain/session_status.dart';

/// A selectable class day + its local copy, if any.
class SessionListItem {
  const SessionListItem(this.day, this.local);

  final SchoolSession day;
  final SessionGrades? local;

  /// Local workflow status wins (it includes unsent edits).
  SessionStatus? get status => local?.status ?? day.serverStatus;

  /// Can be opened: already on the device, or prepared in the sheet.
  bool get canOpen => local != null || day.blockReady;
}

final sessionListProvider = Provider<AsyncValue<List<SessionListItem>>>((ref) {
  final calendar = ref.watch(calendarProvider);
  final locals = ref.watch(localSessionsProvider);
  final today = ref.watch(todayProvider);
  if (calendar.hasError) return AsyncError(calendar.error!, calendar.stackTrace!);
  if (locals.hasError) return AsyncError(locals.error!, locals.stackTrace!);
  if (!calendar.hasValue || !locals.hasValue) return const AsyncLoading();

  final byDate = {for (final s in locals.requireValue) s.sessionDate: s};
  return AsyncData([
    for (final day in SessionSelector.selectable(calendar.requireValue, today))
      SessionListItem(day, byDate[day.date]),
  ]);
});

/// Session proposed on the home screen.
final defaultSessionProvider = Provider<SessionListItem?>((ref) {
  final items = ref.watch(sessionListProvider).value;
  final calendar = ref.watch(calendarProvider).value;
  if (items == null || calendar == null) return null;
  final day = SessionSelector.defaultSession(calendar, ref.watch(todayProvider));
  if (day == null) return null;
  return items.where((i) => i.day.date == day.date).firstOrNull;
});
