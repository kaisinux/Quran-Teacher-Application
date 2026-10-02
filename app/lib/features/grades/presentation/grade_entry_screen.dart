import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/app_error.dart';
import '../../../core/router/app_router.dart';
import '../../../core/sync/sync_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/layout.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../core/ui/sync_indicator.dart';
import '../../../core/utils/date_only.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../sessions/domain/session_status.dart';
import '../data/grades_repository.dart';
import '../domain/session_grades.dart';
import '../domain/student_grade.dart';
import 'grade_providers.dart';
import 'student_grade_page.dart';
import 'widgets/compact_grades_list.dart';
import 'widgets/tablet_grades_table.dart';

class GradeEntryScreen extends ConsumerWidget {
  const GradeEntryScreen({super.key, required this.date});

  final DateOnly date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final opened = ref.watch(openSessionProvider(date));
    return opened.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(formatSessionDate(context, date))),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: Text(formatSessionDate(context, date))),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.error_outline, size: 48, color: context.statusColors.danger),
              const SizedBox(height: 12),
              Text(appErrorMessage(context, e), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => ref.invalidate(openSessionProvider(date)),
                child: Text(l10n.retry),
              ),
            ]),
          ),
        ),
      ),
      data: (sessionId) => _GradeEntryBody(sessionId: sessionId),
    );
  }
}

class _GradeEntryBody extends ConsumerWidget {
  const _GradeEntryBody({required this.sessionId});

  final String sessionId;

  Future<void> _save(BuildContext context, WidgetRef ref, StudentGrade grade) async {
    try {
      await ref.read(gradesRepositoryProvider).updateGrade(sessionId, grade);
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(appErrorMessage(context, e))));
      }
    }
  }

  void _openStudent(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => StudentGradePage(sessionId: sessionId, initialIndex: index),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionGradesProvider(sessionId)).value;
    if (session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatSessionDate(context, session.sessionDate)),
            if (session.sessionNumber != null)
              Text(l10n.sessionNumber(session.sessionNumber!),
                  style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: StatusChip.session(context, session.status, dense: true),
          ),
        ],
      ),
      body: Column(
        children: [
          SessionBanners(session: session),
          Expanded(
            child: context.isTablet
                ? TabletGradesTable(
                    grades: session.grades,
                    enabled: session.isEditable,
                    onChanged: (g) => _save(context, ref, g),
                    onOpenStudent: (i) => _openStudent(context, i),
                  )
                : CompactGradesList(
                    grades: session.grades,
                    onTap: (i) => _openStudent(context, i),
                    onTogglePresence: session.isEditable
                        ? (i) {
                            final g = session.grades[i];
                            _save(context, ref, g.copyWith(
                              attendance: g.isPresent
                                  ? Attendance.absent
                                  : Attendance.present,
                            ));
                          }
                        : null,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Expanded(child: SyncIndicator(pendingChanges: session.pendingChanges)),
              if (session.isEditable)
                FilledButton.icon(
                  onPressed: () => context.push(Routes.review(session.sessionDate)),
                  icon: const Icon(Icons.fact_check_outlined),
                  label: Text(l10n.reviewSession),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Locked / pending upload / correction requested / conflict banners.
class SessionBanners extends ConsumerWidget {
  const SessionBanners({super.key, required this.session});

  final SessionGrades session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    final banners = <Widget>[];

    if (session.status == SessionStatus.validated) {
      banners.add(_Banner(
        icon: Icons.lock_outline,
        color: colors.success,
        text: l10n.lockedMessage,
      ));
    }
    if (session.status == SessionStatus.sent) {
      banners.add(_Banner(
        icon: Icons.cloud_upload_outlined,
        color: colors.info,
        text: l10n.pendingUploadMessage,
        action: TextButton(
          onPressed: () =>
              ref.read(syncServiceProvider).cancelPendingUpload(session.localId),
          child: Text(l10n.cancelUpload),
        ),
      ));
    }
    final comment = session.correctionComment;
    if (session.serverStatus == SessionStatus.needsCorrection && comment != null) {
      banners.add(_Banner(
        icon: Icons.report_outlined,
        color: colors.danger,
        text: l10n.correctionRequested(comment),
      ));
    }
    if (session.lastSyncError == AppErrorCode.conflict.wire &&
        session.status.isEditableByTeacher) {
      banners.add(_Banner(
        icon: Icons.sync_problem,
        color: colors.danger,
        text: l10n.errorConflict,
        action: TextButton(
          onPressed: () async {
            try {
              await ref.read(gradesRepositoryProvider).reloadFromServer(session.localId);
            } on AppException catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(appErrorMessage(context, e))));
              }
            }
          },
          child: Text(l10n.reload),
        ),
      ));
    }
    return Column(children: banners);
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon, required this.color, required this.text, this.action});

  final IconData icon;
  final Color color;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: color.withValues(alpha: 0.10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
          ?action,
        ]),
      );
}
