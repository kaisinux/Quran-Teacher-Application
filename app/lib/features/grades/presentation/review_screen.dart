import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/router/app_router.dart';
import '../../../core/sync/sync_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/layout.dart';
import '../../../core/utils/date_only.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/domain/app_user.dart';
import '../data/grades_repository.dart';
import '../domain/grade_validator.dart';
import '../domain/session_grades.dart';
import 'grade_providers.dart';
import 'student_grade_page.dart';
import 'widgets/compact_grades_list.dart';
import 'widgets/tablet_grades_table.dart';

/// "Vérifier la séance": summary, issues, recap table, then explicit send.
class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key, required this.date});

  final DateOnly date;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final id = await ref.read(openSessionProvider(widget.date).future);
      await ref.read(gradesRepositoryProvider).review(id); // DRAFT → READY
    });
  }

  Future<void> _send(SessionGrades session) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.send_outlined),
        title: Text(l10n.confirmSendTitle),
        content: Text(l10n.confirmSendMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !mounted) return;

    setState(() => _sending = true);
    SyncResult result;
    try {
      result = await ref.read(syncServiceProvider).submit(session.localId);
    } on AppException catch (e) {
      result = SyncResult(SyncOutcome.failed, error: e);
    }
    if (!mounted) return;
    setState(() => _sending = false);

    final messenger = ScaffoldMessenger.of(context);
    switch (result.outcome) {
      case SyncOutcome.synced:
        messenger.showSnackBar(SnackBar(
          content: Row(children: [
            Icon(Icons.check_circle, color: context.statusColors.success),
            const SizedBox(width: 8),
            Text(l10n.syncSuccess),
          ]),
        ));
        context.go(Routes.home);
      case SyncOutcome.queuedOffline:
        messenger.showSnackBar(SnackBar(content: Text(l10n.queuedOffline)));
        context.go(Routes.home);
      case SyncOutcome.conflict:
      case SyncOutcome.locked:
      case SyncOutcome.failed:
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            icon: Icon(Icons.error_outline, color: context.statusColors.danger),
            content: Text(appErrorMessage(
                context, result.error ?? const AppException(AppErrorCode.internal))),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.close),
              ),
            ],
          ),
        );
        if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final id = ref.watch(openSessionProvider(widget.date)).value;
    final session = id == null ? null : ref.watch(sessionGradesProvider(id)).value;
    final user = ref.watch(currentUserProvider);
    if (session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final summary = session.summary;
    final issues = GradeValidator.validateSessionBeforeSubmit(session.grades)
        .where((i) => i.isBlocking)
        .toList();
    final byId = {
      for (final (i, g) in session.grades.indexed) g.studentId: (i, g.studentName),
    };

    void openStudent(int index) => Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) => StudentGradePage(sessionId: session.localId, initialIndex: index),
        ));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reviewTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('${l10n.sessionLabel} : ${formatSessionDate(context, session.sessionDate)}',
              style: Theme.of(context).textTheme.titleMedium),
          if (user is Teacher)
            Text('${l10n.groupLabel} : ${user.groupName}',
                style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          _SummaryGrid(summary: summary),
          const SizedBox(height: 12),
          for (final issue in issues)
            Card(
              child: ListTile(
                leading: Icon(Icons.error, color: context.statusColors.danger),
                title: Text(byId[issue.studentId]?.$2 ?? ''),
                subtitle: Text(issueMessage(l10n, issue)),
                trailing: const Icon(Icons.chevron_right),
                onTap: byId[issue.studentId] == null
                    ? null
                    : () => openStudent(byId[issue.studentId]!.$1),
              ),
            ),
          const SizedBox(height: 12),
          if (context.isTablet)
            ReadOnlyGradesTable(grades: session.grades)
          else
            CompactGradesList(
              grades: session.grades,
              shrinkWrap: true,
              onTap: openStudent,
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: summary.canSubmit && session.isEditable && !_sending
                ? () => _send(session)
                : null,
            icon: _sending
                ? const SizedBox.square(
                    dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.send),
            label: Text(l10n.send),
          ),
        ),
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.summary});

  final SessionSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    final items = [
      (Icons.groups_outlined, l10n.summaryStudents, summary.students, null),
      (Icons.check_box_outlined, l10n.summaryPresent, summary.present, null),
      (Icons.disabled_by_default_outlined, l10n.summaryAbsent, summary.absent, null),
      (Icons.remove_circle_outline, l10n.summaryNotEvaluated, summary.notEvaluated,
          summary.notEvaluated > 0 ? colors.warning : null),
      (Icons.comment_outlined, l10n.summaryDisciplineRemarks,
          summary.disciplineRemarks, null),
      (Icons.error_outline, l10n.summaryBlocking, summary.blockingIssues,
          summary.blockingIssues > 0 ? colors.danger : colors.success),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (icon, label, value, color) in items)
          SizedBox(
            width: 160,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$value',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: color)),
                        Text(label, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
      ],
    );
  }
}
