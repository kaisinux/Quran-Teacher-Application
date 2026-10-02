/// Workflow status of a session.
///
/// `draft`, `ready` and `sent` only exist on the device. `synced`,
/// `needsCorrection` and `validated` come from the server.
enum SessionStatus {
  draft('DRAFT'),
  ready('READY'),
  sent('SENT'),
  synced('SYNCED'),
  needsCorrection('NEEDS_CORRECTION'),
  validated('VALIDATED');

  const SessionStatus(this.wire);
  final String wire;

  static SessionStatus fromWire(String wire) => SessionStatus.values.firstWhere(
        (s) => s.wire == wire,
        orElse: () => throw FormatException('Statut inconnu', wire),
      );

  static SessionStatus? tryFromWire(String? wire) =>
      wire == null ? null : fromWire(wire);

  /// A validated session is locked for the teacher.
  bool get isLocked => this == validated;

  /// Upload confirmed, waiting in the outbox: edits would diverge from the
  /// frozen snapshot, so the teacher must cancel the upload first.
  bool get isPendingUpload => this == sent;

  bool get isEditableByTeacher => !isLocked && !isPendingUpload;

  /// Status after the teacher changes a grade.
  SessionStatus afterTeacherEdit() {
    if (!isEditableByTeacher) {
      throw StateError('Séance non modifiable ($wire)');
    }
    return draft;
  }
}

/// Status of a calendar Sunday in `Calendrier` (`COURS` / `PAS_COURS`).
enum CalendarDayStatus {
  classDay('COURS'),
  noClass('PAS_COURS');

  const CalendarDayStatus(this.wire);
  final String wire;

  static CalendarDayStatus fromWire(String wire) =>
      CalendarDayStatus.values.firstWhere(
        (s) => s.wire == wire.trim().toUpperCase(),
        orElse: () => throw FormatException('Statut calendrier inconnu', wire),
      );
}
