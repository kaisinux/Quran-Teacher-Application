import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:misk_teacher/app.dart';
import 'package:misk_teacher/core/api/mock_api_client.dart';
import 'package:misk_teacher/core/database/app_database.dart';
import 'package:misk_teacher/core/localization/locale_controller.dart';
import 'package:misk_teacher/core/providers.dart';
import 'package:misk_teacher/core/utils/date_only.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  Future<ProviderContainer> pumpApp(WidgetTester tester, {Size? size}) async {
    if (size != null) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }
    final db = AppDatabase(DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ));
    addTearDown(db.close);
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      mockApiProvider.overrideWithValue(MockApiClient(latency: Duration.zero)),
      todayProvider.overrideWithValue(DateOnly.parse('2026-10-02')),
    ]);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MiskTeacherApp(),
    ));
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> loginAsTeacher(WidgetTester tester) async {
    await tester.enterText(find.byType(TextFormField).at(0), MockApiClient.demoTeacherEmail);
    await tester.enterText(find.byType(TextFormField).at(1), MockApiClient.demoTeacherPin);
    await tester.tap(find.text('Se connecter avec le PIN'));
    await tester.pumpAndSettle();
  }

  testWidgets('teacher: login, default session, grade list, review blocked',
      (tester) async {
    await pumpApp(tester, size: const Size(400, 860));
    expect(find.text('Se connecter avec Google'), findsOneWidget);

    await loginAsTeacher(tester);
    expect(find.text('dimanche 27 septembre 2026'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Commencer'));
    await tester.pumpAndSettle();
    expect(find.text('أحمد بن علي'), findsOneWidget);
    expect(find.text('Youssef Haddad'), findsOneWidget);

    await tester.tap(find.text('Vérifier la séance'));
    await tester.pumpAndSettle();
    expect(find.text('Remarque obligatoire : discipline inférieure à 7.'),
        findsWidgets);
    final send = tester.widget<FilledButton>(
        find.ancestor(of: find.text('Envoyer'), matching: find.byType(FilledButton)));
    expect(send.onPressed, isNull);
  });

  testWidgets('admin lands on the dashboard', (tester) async {
    await pumpApp(tester, size: const Size(400, 860));
    await tester.enterText(find.byType(TextFormField).at(0), MockApiClient.demoAdminEmail);
    await tester.enterText(find.byType(TextFormField).at(1), MockApiClient.demoAdminPin);
    await tester.tap(find.text('Se connecter avec le PIN'));
    await tester.pumpAndSettle();
    expect(find.text('Tableau de bord'), findsOneWidget);
    expect(find.text('Hadid 1'), findsOneWidget);
    expect(find.text('Validée'), findsOneWidget);
  });

  testWidgets('arabic switches the layout to RTL', (tester) async {
    final container = await pumpApp(tester, size: const Size(400, 860));
    await container.read(localeProvider.notifier).setLocale(const Locale('ar'));
    await tester.pumpAndSettle();
    expect(find.text('الدخول بحساب Google'), findsOneWidget);
    final context = tester.element(find.text('الدخول بحساب Google'));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('tablet shows the wide table', (tester) async {
    await pumpApp(tester, size: const Size(1280, 800));
    await loginAsTeacher(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Commencer'));
    await tester.pumpAndSettle();
    expect(find.byType(Table), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing, reason: 'grade entry is full screen');
  });
}
