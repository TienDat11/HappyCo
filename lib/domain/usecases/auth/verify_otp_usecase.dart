import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Verify OTP params
/// Scope must be one of: "confirm_email", "forgot_passwd", "delete_account", "blood_donation"
class VerifyOtpParams {
  final String email;
  final String code;
  final String scope;

  VerifyOtpParams({
    required this.email,
    required this.code,
    required this.scope,
  });
}

/// Verify OTP UseCase
/// Returns reset token for forgot_password scope
class VerifyOtpUseCase extends StatelessUseCase<String, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase({required this.repository});

  @override
  Future<String> exec(VerifyOtpParams params) => repository.verifyOtp(
        email: params.email,
        code: params.code,
        scope: params.scope,
      );
}
