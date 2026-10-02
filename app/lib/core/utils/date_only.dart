/// A calendar date without time or time zone.
///
/// Session dates are business identifiers ("le dimanche 27 septembre 2026"),
/// never instants. They travel as `YYYY-MM-DD` strings in the API and in
/// SQLite, so a device time zone change can never shift a session.
class DateOnly implements Comparable<DateOnly> {
  DateOnly(this.year, this.month, this.day)
      : assert(month >= 1 && month <= 12),
        assert(day >= 1 && day <= 31);

  factory DateOnly.fromDateTime(DateTime dt) =>
      DateOnly(dt.year, dt.month, dt.day);

  factory DateOnly.today() => DateOnly.fromDateTime(DateTime.now());

  /// Parses `YYYY-MM-DD`. Throws [FormatException] otherwise.
  factory DateOnly.parse(String iso) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(iso.trim());
    if (match == null) {
      throw FormatException('Date attendue au format YYYY-MM-DD', iso);
    }
    final date = DateOnly(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
    // Rejects impossible dates such as 2026-02-31.
    final utc = date._utc;
    if (utc.month != date.month || utc.day != date.day) {
      throw FormatException('Date invalide', iso);
    }
    return date;
  }

  final int year;
  final int month;
  final int day;

  DateTime get _utc => DateTime.utc(year, month, day);

  /// [DateTime.monday] (1) … [DateTime.sunday] (7).
  int get weekday => _utc.weekday;

  bool get isSunday => weekday == DateTime.sunday;

  DateOnly addDays(int days) =>
      DateOnly.fromDateTime(_utc.add(Duration(days: days)));

  /// Local midnight, for formatting with `intl`.
  DateTime toLocalDateTime() => DateTime(year, month, day);

  String toIso() =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  bool isBefore(DateOnly other) => compareTo(other) < 0;
  bool isAfter(DateOnly other) => compareTo(other) > 0;

  @override
  int compareTo(DateOnly other) => _utc.compareTo(other._utc);

  @override
  bool operator ==(Object other) =>
      other is DateOnly &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => toIso();
}
