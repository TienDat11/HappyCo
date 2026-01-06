import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';

/// Storage Repository Implementation
///
/// Uses SharedPreferences for persistent storage of auth tokens and user data.
@LazySingleton(as: StorageRepository)
class StorageRepositoryImpl implements StorageRepository {
  final SharedPreferences _prefs;

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';

  StorageRepositoryImpl(this._prefs);

  @override
  String? getAccessToken() {
    return _prefs.getString(_keyAccessToken);
  }

  @override
  Future<void> setAccessToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_keyAccessToken);
    } else {
      await _prefs.setString(_keyAccessToken, token);
    }
  }

  @override
  String? getRefreshToken() {
    return _prefs.getString(_keyRefreshToken);
  }

  @override
  Future<void> setRefreshToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_keyRefreshToken);
    } else {
      await _prefs.setString(_keyRefreshToken, token);
    }
  }

  @override
  String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (userId == null) {
      await _prefs.remove(_keyUserId);
    } else {
      await _prefs.setString(_keyUserId, userId);
    }
  }

  @override
  bool isLoggedIn() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clear() async {
    await Future.wait([
      _prefs.remove(_keyAccessToken),
      _prefs.remove(_keyRefreshToken),
      _prefs.remove(_keyUserId),
    ]);
  }
}
