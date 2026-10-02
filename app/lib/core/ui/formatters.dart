import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/grades/domain/grade_validator.dart';
import '../../l10n/gen/app_localizations.dart';
import '../errors/app_error.dart';
import '../utils/date_only.dart';

/// "--" for not evaluated, otherwise 9 / 8.5 / 8.75 (locale decimal sign).
String formatGrade(BuildContext context, double? value) {
  if (value == null) return '--';
  final locale = Localizations.localeOf(context).toLanguageTag();
  return NumberFormat('0.##', locale).format(value);
}

/// "dimanche 27 septembre 2026" / "الأحد 27 سبتمبر 2026".
String formatSessionDate(BuildContext context, DateOnly date) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMMMMEEEEd(locale).format(date.toLocalDateTime());
}

String formatShortDate(BuildContext context, DateOnly date) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.MMMMd(locale).format(date.toLocalDateTime());
}

String formatDateTime(BuildContext context, DateTime dateTime) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMMMd(locale).add_Hm().format(dateTime.toLocal());
}

/// Understandable message for an error; technical details are logged, never
/// shown ("Error 500" never reaches the teacher).
String appErrorMessage(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context);
  if (error is! AppException) return l10n.errorInternal;
  return switch (error.code) {
    AppErrorCode.network => l10n.errorNetwork,
    AppErrorCode.timeout => l10n.errorTimeout,
    AppErrorCode.invalidCredentials => l10n.errorInvalidCredentials,
    AppErrorCode.notAuthorized => l10n.errorNotAuthorized,
    AppErrorCode.authRequired || AppErrorCode.authExpired => l10n.errorAuthExpired,
    AppErrorCode.rateLimited => l10n.errorRateLimited,
    AppErrorCode.forbiddenGroup => l10n.errorForbiddenGroup,
    AppErrorCode.groupNotFound ||
    AppErrorCode.spreadsheetNotFound ||
    AppErrorCode.sheetTabNotFound =>
      l10n.errorSheetNotFound,
    AppErrorCode.sessionNotFound => l10n.errorSessionNotFound,
    AppErrorCode.sessionNotAClassDay => l10n.errorNotAClassDay,
    AppErrorCode.sessionBlockNotReady => l10n.errorBlockNotReady,
    AppErrorCode.studentNotFound ||
    AppErrorCode.studentMismatch =>
      l10n.errorStudentMismatch,
    AppErrorCode.sheetStructureInvalid => l10n.errorSheetStructure,
    AppErrorCode.validationFailed => l10n.errorValidation,
    AppErrorCode.sessionLocked => l10n.lockedMessage,
    AppErrorCode.sessionPendingUpload => l10n.pendingUploadMessage,
    AppErrorCode.conflict => l10n.errorConflict,
    AppErrorCode.lockTimeout => l10n.errorLockTimeout,
    AppErrorCode.offlineNoLocalCopy => l10n.errorOfflineNoCopy,
    AppErrorCode.badRequest || AppErrorCode.internal => l10n.errorInternal,
  };
}

String issueMessage(AppLocalizations l10n, ValidationIssue issue) =>
    switch (issue.code) {
      IssueCode.invalidGradeValue => l10n.issueInvalidGrade,
      IssueCode.absentWithGrade => l10n.issueAbsentWithGrade,
      IssueCode.missingDisciplineRemark => l10n.issueMissingRemark,
      IssueCode.notEvaluated => l10n.issueNotEvaluated,
      IssueCode.duplicateStudent => l10n.issueDuplicate,
      IssueCode.noStudents => l10n.issueNoStudents,
    };

String fieldLabel(AppLocalizations l10n, GradeField field) => switch (field) {
      GradeField.hifz => l10n.fieldHifz,
      GradeField.tajwid => l10n.fieldTajwid,
      GradeField.discipline => l10n.fieldDiscipline,
      GradeField.presence => l10n.fieldPresence,
      GradeField.remark => l10n.fieldRemark,
    };
