import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/grades/data/grades_repository.dart';
import '../../l10n/gen/app_localizations.dart';
import '../sync/sync_service.dart';
import '../theme/app_theme.dart';

/// Always-visible sync state: "Enregistré localement ✓" or
/// "3 modifications non synchronisées".
class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key, this.pendingChanges});

  /// When given, counts only this session; otherwise all sessions.
  final int? pendingChanges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    final changes =
        pendingChanges ?? ref.watch(pendingChangesProvider).value ?? 0;
    final uploads = ref.watch(pendingUploadsProvider).value ?? 0;

    final (IconData icon, Color color, String text) = switch ((changes, uploads)) {
      (0, 0) => (Icons.check_circle_outline, colors.success, l10n.savedLocally),
      (_, > 0) => (Icons.cloud_upload_outlined, colors.info, l10n.pendingUploads(uploads)),
      _ => (Icons.sync_problem_outlined, colors.warning, l10n.pendingChanges(changes)),
    };
    return Semantics(
      liveRegion: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
