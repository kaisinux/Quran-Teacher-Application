import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../core/ui/status_visuals.dart';
import '../../../core/utils/date_only.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/admin_repository.dart';

/// Groups × status for one Sunday.
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  late DateOnly _date = _latestSunday(ref.read(todayProvider));

  static DateOnly _latestSunday(DateOnly today) =>
      today.addDays(-(today.weekday % DateTime.sunday));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = ref.watch(adminDashboardProvider(_date));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navDashboard),
        actions: [
          IconButton(
            tooltip: l10n.navSettings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.adminSettings),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => _date = _date.addDays(-7)),
              ),
              Expanded(
                child: Text(formatSessionDate(context, _date),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() => _date = _date.addDays(7)),
              ),
            ]),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(adminDashboardProvider(_date).future),
              child: rows.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(appErrorMessage(context, e),
                        textAlign: TextAlign.center),
                  ),
                ]),
                data: (list) => ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final row = list[i];
                    return ListTile(
                      minVerticalPadding: 12,
                      title: Text(row.group.nameFr),
                      subtitle: Text([
                        row.group.nameAr,
                        if (row.studentCount != null)
                          '${l10n.summaryStudents} : ${row.studentCount}',
                      ].join(' · ')),
                      trailing: row.blockReady
                          ? StatusChip.session(context, row.status, dense: true)
                          : StatusChip(
                              dense: true,
                              visual: StatusVisual(l10n.statusNotPrepared,
                                  Icons.hourglass_empty, context.statusColors.warning),
                            ),
                      onTap: row.blockReady
                          ? () => context.push(
                              Routes.adminSession(row.group.groupId, _date))
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
