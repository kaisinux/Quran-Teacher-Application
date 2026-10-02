import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

const _localeKey = 'app.locale';

/// French by default; Arabic switches the whole UI to RTL.
class LocaleController extends Notifier<Locale> {
  static const supported = [Locale('fr'), Locale('ar')];

  @override
  Locale build() {
    _restore();
    return supported.first;
  }

  Future<void> _restore() async {
    final code = await ref.read(databaseProvider).readKv(_localeKey);
    if (code != null && ref.mounted && code != state.languageCode) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref.read(databaseProvider).writeKv(_localeKey, locale.languageCode);
  }
}

final localeProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
