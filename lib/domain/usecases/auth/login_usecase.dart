import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/auth_token_entity.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Login params
class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

/// Login UseCase
class LoginUseCase extends StatelessUseCase<AuthTokenEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<AuthTokenEntity> exec(LoginParams params) => repository.login(
        username: params.username,
        password: params.password,
      );
}
