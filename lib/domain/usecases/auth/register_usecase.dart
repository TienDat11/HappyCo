import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Register params
class RegisterParams {
  final String username;
  final String password;
  final String fullName;
  final String phone;
  final String? email;

  RegisterParams({
    required this.username,
    required this.password,
    required this.fullName,
    required this.phone,
    this.email,
  });
}

/// Register UseCase
class RegisterUseCase extends StatelessUseCase<void, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<void> exec(RegisterParams params) => repository.register(
        username: params.username,
        password: params.password,
        fullName: params.fullName,
        phone: params.phone,
        email: params.email,
      );
}
