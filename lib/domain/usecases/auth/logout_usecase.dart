import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Logout UseCase
class LogoutUseCase extends UseCase<void> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<void> exec() => repository.logout();
}
