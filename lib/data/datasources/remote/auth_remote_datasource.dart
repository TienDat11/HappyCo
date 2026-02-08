import 'package:happyco/data/models/auth/user_response.dart';

/// Auth Remote Data Source Interface
///
/// Defines the contract for authentication API operations.
abstract class AuthRemoteDataSource {
  /// Login with username and password
  /// POST /auth/login
  Future<LoginResponse> login({
    required String username,
    required String password,
  });

  /// Register new user
  /// POST /auth/register
  /// API requires: username (phone), password, fullName, phone, email (optional)
  Future<void> register({
    required String username,
    required String password,
    required String fullName,
    required String phone,
    String? email,
  });

  /// Request password reset OTP
  /// POST /auth/forgot-password
  Future<void> forgotPassword({required String email});

  /// Verify OTP code with scope
  /// POST /auth/confirm_otp
  /// Scope must be one of: "confirm_email", "forgot_passwd", "delete_account", "blood_donation"
  /// Returns reset token for forgot_password scope
  Future<String> verifyOtp({
    required String email,
    required String code,
    required String scope,
  });

  /// Refresh/resend OTP code
  /// POST /auth/refresh_otp
  Future<void> refreshOtp({required String email});

  /// Reset password with token
  /// POST /auth/reset_password
  /// Requires email (for validation), token (from OTP confirm), and new password
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  /// Get current user profile
  /// GET /users/me
  Future<UserResponse> getCurrentUser();

  /// Refresh access token
  /// POST /auth/refresh-token
  Future<LoginResponse> refreshToken({
    required String accessToken,
    required String refreshToken,
  });
}
