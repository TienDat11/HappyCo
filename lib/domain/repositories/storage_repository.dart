/// Storage Repository Interface
///
/// Handles local storage of authentication tokens and user data.
/// Interface lives in domain layer, implementation in data layer.
abstract class StorageRepository {
  /// Access token for API requests
  String? getAccessToken();

  /// Save access token
  Future<void> setAccessToken(String? token);

  /// Refresh token for obtaining new access tokens
  String? getRefreshToken();

  /// Save refresh token
  Future<void> setRefreshToken(String? token);

  /// User ID
  String? getUserId();

  /// Save user ID
  Future<void> setUserId(String? userId);

  /// Check if user is logged in
  bool isLoggedIn();

  /// Clear all stored data (logout)
  Future<void> clear();
}
