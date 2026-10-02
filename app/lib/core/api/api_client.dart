import '../../features/auth/domain/app_user.dart';
import '../utils/date_only.dart';
import 'api_models.dart';

/// Business API exposed by the Apps Script Web App.
///
/// Every call is a POST `{action, token, params}` to a single endpoint
/// (architecture §6). Implementations throw `AppException` on failure.
/// The Flutter app never sends sheet coordinates: only business identifiers.
abstract interface class ApiClient {
  /// `auth.google`: the server verifies the Google ID token.
  Future<AuthSession> authGoogle(String idToken);

  /// `auth.pin`.
  Future<AuthSession> authPin({required String email, required String pin});

  /// `auth.logout`.
  Future<void> logout(String token);

  /// `me.get`.
  Future<AppUser> me(String token);

  /// `sessions.list`: calendar of the authenticated teacher's group.
  Future<SessionsOverview> listSessions(String token);

  /// `session.get`: students (sheet order), grades, version, hash.
  Future<ServerSession> getSession(String token, DateOnly date);

  /// `session.submit`: create or update the grades of a session.
  Future<SubmitResult> submitSession(String token, SubmitRequest request);

  /// `notifications.list`.
  Future<List<AppNotification>> listNotifications(
    String token, {
    DateTime? since,
  });

  /// `admin.dashboard`.
  Future<List<AdminGroupRow>> adminDashboard(String token, DateOnly date);

  /// `admin.session.get` (read-only).
  Future<ServerSession> adminGetSession(
    String token, {
    required String groupId,
    required DateOnly date,
  });

  /// `admin.session.validate`: locks the session.
  Future<void> adminValidate(
    String token, {
    required String groupId,
    required DateOnly date,
    required int expectedVersion,
  });

  /// `admin.session.requestCorrection`.
  Future<void> adminRequestCorrection(
    String token, {
    required String groupId,
    required DateOnly date,
    required int expectedVersion,
    required String comment,
  });
}
