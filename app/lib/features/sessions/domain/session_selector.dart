import '../../../core/utils/date_only.dart';
import 'school_session.dart';

/// Chooses which session to propose to the teacher.
abstract final class SessionSelector {
  /// Sessions the teacher may open: class days up to today, newest first.
  ///
  /// Days marked `PAS_COURS` are never offered.
  static List<SchoolSession> selectable(
    List<SchoolSession> calendar,
    DateOnly today,
  ) {
    final result = calendar
        .where((s) => s.isClassDay && !s.date.isAfter(today))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return result;
  }

  /// Default proposal:
  /// - today, if today is a Sunday with class;
  /// - otherwise the latest class day before today.
  ///
  /// Returns `null` when no class day exists yet.
  static SchoolSession? defaultSession(
    List<SchoolSession> calendar,
    DateOnly today,
  ) {
    final candidates = selectable(calendar, today);
    for (final session in candidates) {
      if (session.date == today && !today.isSunday) continue;
      return session;
    }
    return null;
  }
}
