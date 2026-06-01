abstract class TokenProvider {
  /// Return token string or null if none.
  Future<String?> getToken();

  /// Optional: store token (after login)
  Future<void> saveToken(String token);

  /// Optional: clear stored token
  Future<void> clearToken();
}
