import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Forgot Password params
class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams({required this.email});
}

/// Forgot Password UseCase
class ForgotPasswordUseCase
    extends StatelessUseCase<void, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<void> exec(ForgotPasswordParams params) =>
      repository.forgotPassword(email: params.email);
}
