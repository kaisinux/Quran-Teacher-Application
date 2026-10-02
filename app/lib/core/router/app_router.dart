import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/admin_session_screen.dart';
import '../../features/auth/domain/app_user.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/home_screen.dart';
import '../../features/dashboard/presentation/teacher_shell.dart';
import '../../features/grades/presentation/grade_entry_screen.dart';
import '../../features/grades/presentation/review_screen.dart';
import '../../features/sessions/presentation/sessions_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/sync/presentation/sync_screen.dart';
import '../auth/auth_controller.dart';
import '../utils/date_only.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const sessions = '/sessions';
  static const sync = '/sync';
  static const settings = '/settings';
  static const admin = '/admin';
  static const adminSettings = '/admin/settings';

  static String session(DateOnly date) => '/session/${date.toIso()}';
  static String review(DateOnly date) => '/session/${date.toIso()}/review';
  static String adminSession(String groupId, DateOnly date) =>
      '/admin/group/$groupId/${date.toIso()}';
}

final routerProvider = Provider<GoRouter>((ref) {
  // Re-evaluates redirects when the auth state changes.
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final location = state.matchedLocation;
      if (!auth.hasValue) {
        return location == Routes.splash ? null : Routes.splash;
      }
      final user = auth.value?.user;
      if (user == null) return location == Routes.login ? null : Routes.login;

      final isAdminArea = location.startsWith(Routes.admin);
      return switch (user) {
        AdminUser() when !isAdminArea => Routes.admin,
        Teacher() when isAdminArea ||
                location == Routes.login ||
                location == Routes.splash =>
          Routes.home,
        _ => null,
      };
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, _) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            TeacherShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.sessions,
              builder: (_, _) => const SessionsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.sync, builder: (_, _) => const SyncScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) => const SettingsScreen(),
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/session/:date',
        builder: (_, state) =>
            GradeEntryScreen(date: DateOnly.parse(state.pathParameters['date']!)),
        routes: [
          GoRoute(
            path: 'review',
            builder: (_, state) =>
                ReviewScreen(date: DateOnly.parse(state.pathParameters['date']!)),
          ),
        ],
      ),
      GoRoute(
        path: Routes.admin,
        builder: (_, _) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'settings',
            builder: (_, _) => const SettingsScreen(),
          ),
          GoRoute(
            path: 'group/:groupId/:date',
            builder: (_, state) => AdminSessionScreen(
              groupId: state.pathParameters['groupId']!,
              date: DateOnly.parse(state.pathParameters['date']!),
            ),
          ),
        ],
      ),
    ],
  );
});
