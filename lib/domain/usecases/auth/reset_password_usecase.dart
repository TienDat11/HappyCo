import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Reset Password params
class ResetPasswordParams {
  final String email;
  final String token;
  final String newPassword;

  ResetPasswordParams({
    required this.email,
    required this.token,
    required this.newPassword,
  });
}

/// Reset Password UseCase
class ResetPasswordUseCase extends StatelessUseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<void> exec(ResetPasswordParams params) => repository.resetPassword(
        email: params.email,
        token: params.token,
        newPassword: params.newPassword,
      );
}
