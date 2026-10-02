import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/domain/app_user.dart';
import '../errors/app_error.dart';
import '../providers.dart';

const _sessionKey = 'auth.session';

/// Authentication state: `null` = signed out.
///
/// The session is persisted so the app reopens signed in, even offline.
/// Phase 4 moves the token to `flutter_secure_storage`.
class AuthController extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() async {
    final raw = await ref.watch(databaseProvider).readKv(_sessionKey);
    if (raw == null) return null;
    try {
      return AuthSession.fromJson(jsonDecode(raw) as Map<String, Object?>);
    } on Object {
      return null;
    }
  }

  Future<void> signInWithGoogle() => _signIn(() async {
        final idToken =
            await ref.read(googleIdTokenProvider).obtainIdToken();
        if (idToken == null) return null;
        return ref.read(apiClientProvider).authGoogle(idToken);
      });

  Future<void> signInWithPin(String email, String pin) => _signIn(
        () => ref.read(apiClientProvider).authPin(email: email, pin: pin),
      );

  /// Throws [AppException] on failure; the login screen shows it. The global
  /// state only changes on success, so routing never flickers.
  Future<void> _signIn(Future<AuthSession?> Function() action) async {
    final session = await action();
    if (session == null) return; // cancelled
    await ref
        .read(databaseProvider)
        .writeKv(_sessionKey, jsonEncode(session.toJson()));
    state = AsyncData(session);
  }

  /// Refuses to sign out while confirmed uploads are still pending, since
  /// signing out wipes local data.
  Future<void> signOut({bool force = false}) async {
    final db = ref.read(databaseProvider);
    if (!force) {
      final pending = await (db.select(db.outbox)
            ..where((o) => o.state.isIn(['PENDING', 'IN_FLIGHT', 'FAILED'])))
          .get();
      if (pending.isNotEmpty) {
        throw const AppException(AppErrorCode.sessionPendingUpload);
      }
    }
    final token = state.value?.token;
    if (token != null) {
      try {
        await ref.read(apiClientProvider).logout(token);
      } on AppException {
        // Offline logout is fine: the token expires on its own.
      }
    }
    await ref.read(googleIdTokenProvider).signOut();
    await db.wipe();
    state = const AsyncData(null);
  }

  /// Called when the server answers AUTH_EXPIRED: local data is kept.
  void markExpired() => state = const AsyncData(null);
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthSession?>(AuthController.new);

/// Current user, `null` when signed out or still restoring.
final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authControllerProvider).value?.user,
);

/// Token for API calls; throws AUTH_REQUIRED when signed out.
final authTokenProvider = Provider<String Function()>((ref) {
  return () {
    final token = ref.read(authControllerProvider).value?.token;
    if (token == null) throw const AppException(AppErrorCode.authRequired);
    return token;
  };
});
