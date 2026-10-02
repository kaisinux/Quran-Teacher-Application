/// Error codes shared with the Apps Script API (`error.code`).
///
/// The UI never shows a raw HTTP status: each code maps to a localized,
/// actionable message (see `appErrorMessage`).
enum AppErrorCode {
  network('NETWORK'),
  timeout('TIMEOUT'),
  badRequest('BAD_REQUEST'),
  authRequired('AUTH_REQUIRED'),
  authExpired('AUTH_EXPIRED'),
  invalidCredentials('INVALID_CREDENTIALS'),
  notAuthorized('NOT_AUTHORIZED'),
  forbiddenGroup('FORBIDDEN_GROUP'),
  rateLimited('RATE_LIMITED'),
  groupNotFound('GROUP_NOT_FOUND'),
  spreadsheetNotFound('SPREADSHEET_NOT_FOUND'),
  sheetTabNotFound('SHEET_TAB_NOT_FOUND'),
  sessionNotFound('SESSION_NOT_FOUND'),
  sessionNotAClassDay('SESSION_NOT_A_CLASS_DAY'),
  sessionBlockNotReady('SESSION_BLOCK_NOT_READY'),
  studentNotFound('STUDENT_NOT_FOUND'),
  studentMismatch('STUDENT_MISMATCH'),
  sheetStructureInvalid('SHEET_STRUCTURE_INVALID'),
  validationFailed('VALIDATION_FAILED'),
  sessionLocked('SESSION_LOCKED'),
  sessionPendingUpload('SESSION_PENDING_UPLOAD'),
  conflict('CONFLICT'),
  lockTimeout('LOCK_TIMEOUT'),
  offlineNoLocalCopy('OFFLINE_NO_LOCAL_COPY'),
  internal('INTERNAL');

  const AppErrorCode(this.wire);

  /// Value used in the JSON envelope.
  final String wire;

  static AppErrorCode fromWire(String? wire) => AppErrorCode.values.firstWhere(
        (c) => c.wire == wire,
        orElse: () => AppErrorCode.internal,
      );

  /// Errors worth an automatic retry of a pending upload.
  bool get isTransient =>
      this == network ||
      this == timeout ||
      this == lockTimeout ||
      this == internal;
}

class AppException implements Exception {
  const AppException(this.code, {this.technicalDetails, this.data});

  final AppErrorCode code;

  /// Logged, never shown as-is to the teacher.
  final String? technicalDetails;

  /// Structured payload (e.g. current server version on a conflict).
  final Map<String, Object?>? data;

  @override
  String toString() =>
      'AppException(${code.wire}${technicalDetails == null ? '' : ': $technicalDetails'})';
}
