import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_models.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/providers.dart';
import '../../../core/utils/date_only.dart';

/// Online-only, read + validate. The admin never edits grades: the API has
/// no such action.
class AdminRepository {
  AdminRepository(this._api, this._token);

  final ApiClient _api;
  final String Function() _token;

  Future<List<AdminGroupRow>> dashboard(DateOnly date) =>
      _api.adminDashboard(_token(), date);

  Future<ServerSession> session(String groupId, DateOnly date) =>
      _api.adminGetSession(_token(), groupId: groupId, date: date);

  Future<void> validate(ServerSession s) => _api.adminValidate(
        _token(),
        groupId: s.groupId,
        date: s.sessionDate,
        expectedVersion: s.version,
      );

  Future<void> requestCorrection(ServerSession s, String comment) =>
      _api.adminRequestCorrection(
        _token(),
        groupId: s.groupId,
        date: s.sessionDate,
        expectedVersion: s.version,
        comment: comment,
      );
}

final adminRepositoryProvider = Provider<AdminRepository>(
  (ref) => AdminRepository(
    ref.watch(apiClientProvider),
    ref.watch(authTokenProvider),
  ),
);

final adminDashboardProvider =
    FutureProvider.autoDispose.family<List<AdminGroupRow>, DateOnly>(
  (ref, date) => ref.watch(adminRepositoryProvider).dashboard(date),
);

final adminSessionProvider = FutureProvider.autoDispose
    .family<ServerSession, (String, DateOnly)>(
  (ref, key) => ref.watch(adminRepositoryProvider).session(key.$1, key.$2),
);
