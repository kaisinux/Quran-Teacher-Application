import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'api/api_client.dart';
import 'api/mock_api_client.dart';
import 'auth/google_id_token_provider.dart';
import 'database/app_database.dart';
import 'utils/date_only.dart';

/// Overridden in `main.dart` (real database) and in tests (in-memory).
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

/// Phase 2: in-memory mock. Phase 4: Apps Script client.
final mockApiProvider = Provider<MockApiClient>((ref) => MockApiClient());

final apiClientProvider = Provider<ApiClient>(
  (ref) => ref.watch(mockApiProvider),
);

final googleIdTokenProvider = Provider<GoogleIdTokenProvider>(
  (ref) => const MockGoogleIdTokenProvider(MockApiClient.demoTeacherEmail),
);

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// "Today" for session selection. Overridable for demos and tests.
final todayProvider = Provider<DateOnly>(
  (ref) => DateOnly.fromDateTime(ref.watch(clockProvider)()),
);

final uuidProvider = Provider<String Function()>((ref) {
  const uuid = Uuid();
  return uuid.v4;
});
