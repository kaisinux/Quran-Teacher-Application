import 'package:flutter/material.dart';

import '../../features/sessions/domain/session_status.dart';
import '../../l10n/gen/app_localizations.dart';
import '../theme/app_theme.dart';

/// Color + icon + text for a status: never color alone (accessibility).
class StatusVisual {
  const StatusVisual(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

StatusVisual sessionStatusVisual(BuildContext context, SessionStatus? status) {
  final l10n = AppLocalizations.of(context);
  final colors = context.statusColors;
  return switch (status) {
    null => StatusVisual(l10n.statusNotSent, Icons.cancel_outlined, colors.danger),
    SessionStatus.draft =>
      StatusVisual(l10n.statusDraft, Icons.edit_note, colors.warning),
    SessionStatus.ready =>
      StatusVisual(l10n.statusReady, Icons.fact_check_outlined, colors.info),
    SessionStatus.sent =>
      StatusVisual(l10n.statusSent, Icons.cloud_upload_outlined, colors.info),
    SessionStatus.synced =>
      StatusVisual(l10n.statusSynced, Icons.cloud_done_outlined, colors.info),
    SessionStatus.needsCorrection =>
      StatusVisual(l10n.statusNeedsCorrection, Icons.report_outlined, colors.danger),
    SessionStatus.validated =>
      StatusVisual(l10n.statusValidated, Icons.verified_outlined, colors.success),
  };
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.visual, this.dense = false});

  factory StatusChip.session(
    BuildContext context,
    SessionStatus? status, {
    Key? key,
    bool dense = false,
  }) =>
      StatusChip(
        key: key,
        visual: sessionStatusVisual(context, status),
        dense: dense,
      );

  final StatusVisual visual;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: visual.label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 8 : 10,
          vertical: dense ? 2 : 4,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: visual.color),
          borderRadius: BorderRadius.circular(16),
          color: visual.color.withValues(alpha: 0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(visual.icon, size: dense ? 16 : 18, color: visual.color),
            const SizedBox(width: 4),
            Text(
              visual.label,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: visual.color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
