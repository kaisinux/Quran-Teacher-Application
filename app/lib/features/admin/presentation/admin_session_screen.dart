import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_models.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../core/utils/date_only.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../grades/domain/session_grades.dart';
import '../../grades/presentation/widgets/tablet_grades_table.dart';
import '../../sessions/domain/session_status.dart';
import '../data/admin_repository.dart';

/// Read-only session detail with "Renvoyer à corriger" / "Valider".
class AdminSessionScreen extends ConsumerStatefulWidget {
  const AdminSessionScreen({super.key, required this.groupId, required this.date});

  final String groupId;
  final DateOnly date;

  @override
  ConsumerState<AdminSessionScreen> createState() => _AdminSessionScreenState();
}

class _AdminSessionScreenState extends ConsumerState<AdminSessionScreen> {
  bool _showGrades = false;
  bool _busy = false;

  (String, DateOnly) get _key => (widget.groupId, widget.date);

  Future<void> _act(Future<void> Function() action, String success) async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    String message = success;
    try {
      await action();
    } on AppException catch (e) {
      if (mounted) message = appErrorMessage(context, e);
    }
    if (!mounted) return;
    setState(() => _busy = false);
    messenger.showSnackBar(SnackBar(content: Text(message)));
    ref.invalidate(adminSessionProvider(_key));
    ref.invalidate(adminDashboardProvider(widget.date));
  }

  Future<void> _validate(ServerSession session) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.verified_outlined),
        content: Text(l10n.adminConfirmValidate),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.adminValidate)),
        ],
      ),
    );
    if (ok ?? false) {
      await _act(() => ref.read(adminRepositoryProvider).validate(session),
          l10n.adminValidated);
    }
  }

  Future<void> _requestCorrection(ServerSession session) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final comment = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.adminRequestCorrection),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 2,
          maxLines: 5,
          decoration: InputDecoration(labelText: l10n.adminCorrectionComment),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
    controller.dispose();
    if (comment != null && comment.isNotEmpty) {
      await _act(
        () => ref.read(adminRepositoryProvider).requestCorrection(session, comment),
        l10n.adminCorrectionSent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(adminSessionProvider(_key));

    return Scaffold(
      appBar: AppBar(title: Text(formatSessionDate(context, widget.date))),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(appErrorMessage(context, e))),
        data: (session) {
          final summary = SessionSummary.of(session.grades);
          // Only a session sent by the teacher can be validated / returned.
          final actionable = session.status == SessionStatus.synced;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(children: [
                Expanded(
                  child: Text('${l10n.groupLabel} : ${session.groupId}',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                StatusChip.session(context, session.status),
              ]),
              if (session.teacherName != null)
                Text(l10n.adminTeacher(session.teacherName!)),
              const SizedBox(height: 12),
              _Line(l10n.summaryStudents, summary.students),
              _Line(l10n.summaryPresent, summary.present),
              _Line(l10n.summaryAbsent, summary.absent),
              _Line(l10n.summaryNotEvaluated, summary.notEvaluated,
                  color: summary.notEvaluated > 0 ? context.statusColors.warning : null),
              _Line(l10n.summaryDisciplineRemarks, summary.disciplineRemarks),
              if (summary.blockingIssues > 0)
                _Line(l10n.summaryBlocking, summary.blockingIssues,
                    color: context.statusColors.danger),
              if (session.correctionComment != null) ...[
                const SizedBox(height: 8),
                Text(l10n.correctionRequested(session.correctionComment!)),
              ],
              const SizedBox(height: 16),
              Row(children: [
                Icon(Icons.visibility_outlined, size: 18,
                    color: Theme.of(context).colorScheme.outline),
                const SizedBox(width: 6),
                Expanded(child: Text(l10n.adminReadOnly,
                    style: Theme.of(context).textTheme.bodySmall)),
              ]),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => setState(() => _showGrades = !_showGrades),
                icon: Icon(_showGrades ? Icons.expand_less : Icons.table_rows_outlined),
                label: Text(l10n.adminViewGrades),
              ),
              if (_showGrades) ...[
                const SizedBox(height: 8),
                ReadOnlyGradesTable(grades: session.grades),
              ],
              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: actionable && !_busy
                        ? () => _requestCorrection(session)
                        : null,
                    icon: const Icon(Icons.report_outlined),
                    label: Text(l10n.adminRequestCorrection),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: actionable && !_busy ? () => _validate(session) : null,
                    icon: const Icon(Icons.verified_outlined),
                    label: Text(l10n.adminValidate),
                  ),
                ),
              ]),
            ],
          );
        },
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.label, this.value, {this.color});
  final String label;
  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          Expanded(child: Text(label)),
          Text('$value',
              style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ]),
      );
}
