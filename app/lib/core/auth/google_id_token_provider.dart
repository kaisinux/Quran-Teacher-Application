/// Obtains a Google ID token for `auth.google`.
///
/// Phase 4 implements it with `google_sign_in` (serverClientId = OAuth
/// "Web" client); the token is always verified by the server.
abstract interface class GoogleIdTokenProvider {
  /// `null` when the user cancels.
  Future<String?> obtainIdToken();

  Future<void> signOut();
}

class MockGoogleIdTokenProvider implements GoogleIdTokenProvider {
  const MockGoogleIdTokenProvider(this.email);

  final String email;

  @override
  Future<String?> obtainIdToken() async => 'mock-google-id-token:$email';

  @override
  Future<void> signOut() async {}
}
