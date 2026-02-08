import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Check Auth Status UseCase
class CheckAuthStatusUseCase extends UseCase<bool> {
  final AuthRepository repository;

  CheckAuthStatusUseCase({required this.repository});

  @override
  Future<bool> exec() async => repository.isLoggedIn();
}
