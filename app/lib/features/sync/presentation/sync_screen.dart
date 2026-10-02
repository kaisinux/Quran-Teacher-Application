import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_error.dart';
import '../../../core/sync/sync_service.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../core/ui/sync_indicator.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../grades/data/grades_repository.dart';
import '../../sessions/data/sessions_repository.dart';

/// Pending uploads, last sync per session, manual sync.
class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  bool _busy = false;

  Future<void> _syncNow() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    String message = l10n.syncUpToDate;
    try {
      final results = await ref.read(syncServiceProvider).processOutbox();
      await ref.read(sessionsRepositoryProvider).refresh();
      final failure = results.where((r) => r.error != null).firstOrNull;
      if (failure != null && mounted) {
        message = appErrorMessage(context, failure.error!);
      }
    } on AppException catch (e) {
      if (mounted) message = appErrorMessage(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sessions = ref.watch(localSessionsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSync)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SyncIndicator(),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _syncNow,
            icon: _busy
                ? const SizedBox.square(
                    dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.sync),
            label: Text(l10n.syncNow),
          ),
          const SizedBox(height: 16),
          for (final s in sessions)
            ListTile(
              title: Text(formatSessionDate(context, s.sessionDate)),
              subtitle: Text([
                s.synchronizedAt == null
                    ? l10n.neverSynced
                    : l10n.lastSync(formatDateTime(context, s.synchronizedAt!)),
                if (s.pendingChanges > 0) l10n.pendingChanges(s.pendingChanges),
                if (s.lastSyncError != null)
                  appErrorMessage(
                      context, AppException(AppErrorCode.fromWire(s.lastSyncError))),
              ].join('\n')),
              isThreeLine: s.pendingChanges > 0 || s.lastSyncError != null,
              trailing: StatusChip.session(context, s.status, dense: true),
            ),
        ],
      ),
    );
  }
}
