import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/mock_api_client.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/ui/formatters.dart';
import '../../../l10n/gen/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pin = TextEditingController();
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    _email.dispose();
    _pin.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on Object catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.read(authControllerProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.menu_book_rounded,
                        size: 64, color: theme.colorScheme.primary),
                    const SizedBox(height: 12),
                    Text(l10n.appTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium),
                    Text(l10n.loginSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      onPressed: _busy ? null : () => _run(auth.signInWithGoogle),
                      icon: const Icon(Icons.account_circle_outlined),
                      label: Text(l10n.loginWithGoogle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(l10n.loginOr),
                        ),
                        const Expanded(child: Divider()),
                      ]),
                    ),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(labelText: l10n.emailLabel),
                      validator: (v) => (v ?? '').contains('@')
                          ? null
                          : l10n.emailInvalid,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pin,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 5,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(labelText: l10n.pinLabel),
                      validator: (v) => RegExp(r'^\d{5}$').hasMatch(v ?? '')
                          ? null
                          : l10n.pinInvalidFormat,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _busy
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;
                              _run(() => auth.signInWithPin(
                                    _email.text.trim(),
                                    _pin.text,
                                  ));
                            },
                      child: Text(l10n.loginWithPin),
                    ),
                    if (_busy) ...[
                      const SizedBox(height: 16),
                      const Center(child: CircularProgressIndicator()),
                    ],
                    if (_error != null) ...[
                      const SizedBox(height: 16),
                      _ErrorBox(message: appErrorMessage(context, _error!)),
                    ],
                    const SizedBox(height: 24),
                    // Phase 2 only: demo accounts of the mock backend.
                    Text(
                      'Démo : ${MockApiClient.demoTeacherEmail} / '
                      '${MockApiClient.demoTeacherPin}\n'
                      'Admin : ${MockApiClient.demoAdminEmail} / '
                      '${MockApiClient.demoAdminPin}',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return Semantics(
      liveRegion: true,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: TextStyle(color: color))),
        ],
      ),
    );
  }
}
