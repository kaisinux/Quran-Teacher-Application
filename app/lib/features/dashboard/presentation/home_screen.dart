import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_router.dart';
import '../../../core/sync/sync_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../core/ui/sync_indicator.dart';
import '../../../core/utils/date_only.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/domain/app_user.dart';
import '../../sessions/data/sessions_repository.dart';
import '../../sessions/domain/session_status.dart';
import '../../sessions/presentation/session_overview.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Resend confirmed uploads left in the outbox (e.g. app closed offline).
    Future.microtask(() => ref.read(syncServiceProvider).processOutbox());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final refresh = ref.watch(calendarRefreshProvider);
    final proposal = ref.watch(defaultSessionProvider);
    final notifications = ref.watch(unreadNotificationsProvider).value ?? [];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(calendarRefreshProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (user != null)
              Text(l10n.homeGreeting(user.displayName),
                  style: theme.textTheme.headlineSmall),
            if (user is Teacher)
              Text('${l10n.groupLabel} : ${user.groupName}',
                  style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            const SyncIndicator(),
            if (refresh.hasError) ...[
              const SizedBox(height: 8),
              _InfoBanner(
                icon: Icons.wifi_off,
                color: context.statusColors.warning,
                text: appErrorMessage(context, refresh.error!),
              ),
            ],
            for (final n in notifications) ...[
              const SizedBox(height: 8),
              _NotificationCard(
                type: n.type,
                date: n.sessionDate == null ? null : DateOnly.parse(n.sessionDate!),
                comment: n.comment,
                onDismiss: () => ref
                    .read(sessionsRepositoryProvider)
                    .markNotificationRead(n.id),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: proposal == null
                    ? (refresh.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(l10n.homeNoSession))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.homeSelectedSession,
                              style: theme.textTheme.labelLarge),
                          const SizedBox(height: 4),
                          Text(formatSessionDate(context, proposal.day.date),
                              style: theme.textTheme.titleLarge),
                          const SizedBox(height: 8),
                          proposal.canOpen
                              ? StatusChip.session(context, proposal.status)
                              : StatusChip(
                                  visual: StatusVisual(
                                    l10n.statusNotPrepared,
                                    Icons.hourglass_empty,
                                    context.statusColors.warning,
                                  ),
                                ),
                          if (!proposal.canOpen) ...[
                            const SizedBox(height: 8),
                            Text(l10n.errorBlockNotReady),
                          ],
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: proposal.canOpen
                                  ? () => context.push(
                                      Routes.session(proposal.day.date))
                                  : null,
                              child: Text(switch (proposal.status) {
                                null => l10n.start,
                                SessionStatus.validated => l10n.viewAction,
                                _ when proposal.local == null => l10n.start,
                                _ => l10n.continueAction,
                              }),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(Routes.sessions),
                            child: Text(l10n.chooseAnotherSession),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ]),
      );
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.type,
    required this.date,
    required this.comment,
    required this.onDismiss,
  });

  final String type;
  final DateOnly? date;
  final String? comment;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dateText = date == null ? '' : formatShortDate(context, date!);
    final validated = type == 'SESSION_VALIDATED';
    final visual = sessionStatusVisual(
      context,
      validated ? SessionStatus.validated : SessionStatus.needsCorrection,
    );
    return Card(
      child: ListTile(
        leading: Icon(visual.icon, color: visual.color),
        title: Text(validated
            ? l10n.notifValidated(dateText)
            : l10n.notifNeedsCorrection(dateText)),
        subtitle: comment == null ? null : Text(comment!),
        trailing: IconButton(
          tooltip: l10n.close,
          icon: const Icon(Icons.close),
          onPressed: onDismiss,
        ),
      ),
    );
  }
}
