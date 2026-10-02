import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/providers.dart';
import '../../../core/ui/formatters.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/domain/app_user.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> _logout() async {
    final auth = ref.read(authControllerProvider.notifier);
    try {
      await auth.signOut();
    } on AppException catch (e) {
      if (!mounted) return;
      if (e.code != AppErrorCode.sessionPendingUpload) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appErrorMessage(context, e))));
        return;
      }
      final l10n = AppLocalizations.of(context);
      final force = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.warning_amber_rounded),
          title: Text(l10n.logout),
          content: Text(l10n.logoutPendingMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.logoutAnyway),
            ),
          ],
        ),
      );
      if (force ?? false) await auth.signOut(force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider);
    final user = ref.watch(currentUserProvider);
    final mock = ref.watch(mockApiProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        children: [
          ListTile(title: Text(l10n.settingsLanguage)),
          RadioGroup<String>(
            groupValue: locale.languageCode,
            onChanged: (code) => ref
                .read(localeProvider.notifier)
                .setLocale(Locale(code ?? 'fr')),
            child: Column(children: [
              RadioListTile<String>(value: 'fr', title: Text(l10n.languageFrench)),
              RadioListTile<String>(value: 'ar', title: Text(l10n.languageArabic)),
            ]),
          ),
          const Divider(),
          SwitchListTile(
            title: Text(l10n.settingsSimulateOffline),
            value: mock.offline,
            onChanged: (v) => setState(() => mock.offline = v),
          ),
          const Divider(),
          ListTile(title: Text(l10n.settingsAccount)),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(user.displayName),
              subtitle: Text([
                user.email,
                if (user is Teacher) '${l10n.groupLabel} : ${user.groupName}',
              ].join('\n')),
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(l10n.logout),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
