import 'package:happyco/domain/entities/auth_token_entity.dart';
import 'package:happyco/domain/entities/user_entity.dart';

/// Auth Repository Interface
///
/// Defines the contract for authentication operations.
/// Interface lives in domain layer, implementation in data layer.
abstract class AuthRepository {
  /// Login with username and password
  Future<AuthTokenEntity> login({
    required String username,
    required String password,
  });

  /// Register new user
  Future<void> register({
    required String username,
    required String password,
    required String fullName,
    required String phone,
    String? email,
  });

  /// Request password reset OTP
  Future<void> forgotPassword({required String email});

  /// Verify OTP code with scope
  /// Returns reset token for forgot_password scope
  Future<String> verifyOtp({
    required String email,
    required String code,
    required String scope,
  });

  /// Refresh/resend OTP code
  Future<void> refreshOtp({required String email});

  /// Reset password with token
  /// Requires email for validation, token (from OTP confirm), and new password
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  /// Logout and clear tokens
  Future<void> logout();

  /// Check if user is logged in
  bool isLoggedIn();

  /// Get current user profile
  Future<UserEntity> getCurrentUser();

  /// Refresh access token
  Future<AuthTokenEntity> refreshToken({
    required String accessToken,
    required String refreshToken,
  });
}
