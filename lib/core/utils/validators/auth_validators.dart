/// Auth Validators
///
/// Input validation for authentication forms.
/// Validated against API requirements from auth-api-spike.md
class AuthValidators {
  /// Validate phone number (Vietnamese format per API)
  /// API accepts: 10 digits starting with 03/05/07/08/09
  /// Examples: 0901234567, 0321654987, 0771234567
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    // API: 10 digits starting with 03, 05, 07, 08, 09
    final phoneRegex = RegExp(r'^0[3|5|7|8|9][0-9]{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  /// Validate password with strength requirements
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Mật khẩu phải có ít nhất 1 chữ cái in hoa';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Mật khẩu phải có ít nhất 1 chữ số';
    }
    return null;
  }

  /// Validate confirm password
  static String? validateConfirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }
    if (password != confirm) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  /// Validate OTP code (5 digits)
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã OTP';
    }
    if (value.length != 5) {
      return 'Mã OTP phải có 5 chữ số';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mã OTP chỉ chứa chữ số';
    }
    return null;
  }

  /// Validate full name
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    if (value.trim().length < 2) {
      return 'Họ và tên quá ngắn';
    }
    return null;
  }
}
