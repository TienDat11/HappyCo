/// OTP Scope Constants
///
/// Values for the `scope` parameter in /auth/confirm_otp endpoint.
/// Must be one of these values, otherwise API returns 400 error.
class OtpScopes {
  OtpScopes._();

  /// Confirm email after registration
  static const String confirmEmail = 'confirm_email';

  /// Forgot password flow (NOT 'reset_password')
  static const String forgotPassword = 'forgot_passwd';

  /// Delete account flow
  static const String deleteAccount = 'delete_account';

  /// Blood donation flow (special use case)
  static const String bloodDonation = 'blood_donation';
}
