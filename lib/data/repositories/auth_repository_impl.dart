import 'package:happyco/data/datasources/remote/auth_remote_datasource.dart';
import 'package:happyco/data/mappers/user_mapper.dart';
import 'package:happyco/domain/entities/auth_token_entity.dart';
import 'package:happyco/domain/entities/user_entity.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';

/// Auth Repository Implementation
///
/// Concrete implementation of AuthRepository.
/// Handles authentication operations and token management.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageRepository _storage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required StorageRepository storage,
  })  : _remoteDataSource = remoteDataSource,
        _storage = storage;

  @override
  Future<AuthTokenEntity> login({
    required String username,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      username: username,
      password: password,
    );

    final tokens = response.toAuthTokenEntity();
    final user = response.user.toEntity();

    // Save tokens and user to storage
    await _storage.setAccessToken(tokens.accessToken);
    await _storage.setRefreshToken(tokens.refreshToken);
    await _storage.setUserId(user.id);

    return tokens;
  }

  @override
  Future<void> register({
    required String username,
    required String password,
    required String fullName,
    required String phone,
    String? email,
  }) async {
    await _remoteDataSource.register(
      username: username,
      password: password,
      fullName: fullName,
      phone: phone,
      email: email,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<String> verifyOtp({
    required String email,
    required String code,
    required String scope,
  }) async {
    return await _remoteDataSource.verifyOtp(
      email: email,
      code: code,
      scope: scope,
    );
  }

  @override
  Future<void> refreshOtp({required String email}) async {
    await _remoteDataSource.refreshOtp(email: email);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    await _remoteDataSource.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout() async {
    await _storage.clear();
  }

  @override
  bool isLoggedIn() {
    return _storage.isLoggedIn();
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final response = await _remoteDataSource.getCurrentUser();
    return response.toEntity();
  }

  @override
  Future<AuthTokenEntity> refreshToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    final response = await _remoteDataSource.refreshToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    final tokens = response.toAuthTokenEntity();

    // Save new tokens
    await _storage.setAccessToken(tokens.accessToken);
    await _storage.setRefreshToken(tokens.refreshToken);

    return tokens;
  }
}
