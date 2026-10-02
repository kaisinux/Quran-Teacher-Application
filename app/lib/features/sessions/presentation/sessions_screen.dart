import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/sessions_repository.dart';
import 'session_overview.dart';

/// "Mes séances": class days up to today, newest first, with their status.
class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(sessionListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSessions)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(calendarRefreshProvider.future),
        child: items.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(appErrorMessage(context, e))),
          data: (list) => list.isEmpty
              ? ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(l10n.sessionsEmpty, textAlign: TextAlign.center),
                  ),
                ])
              : ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final pending = item.local?.pendingChanges ?? 0;
                    return ListTile(
                      minVerticalPadding: 12,
                      enabled: item.canOpen,
                      title: Text(formatSessionDate(context, item.day.date)),
                      subtitle: pending > 0
                          ? Text(l10n.pendingChanges(pending))
                          : (item.day.comment == null
                              ? null
                              : Text(item.day.comment!)),
                      trailing: item.canOpen
                          ? StatusChip.session(context, item.status, dense: true)
                          : StatusChip(
                              dense: true,
                              visual: StatusVisual(
                                l10n.statusNotPrepared,
                                Icons.hourglass_empty,
                                context.statusColors.warning,
                              ),
                            ),
                      onTap: item.canOpen
                          ? () => context.push(Routes.session(item.day.date))
                          : null,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
