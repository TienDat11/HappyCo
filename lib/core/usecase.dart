/// Base UseCase without parameters
///
/// Use for simple operations that don't require input:
/// ```dart
/// class GetCurrentUserUseCase extends UseCase<UserEntity> {
///   final UserRepository repository;
///   GetCurrentUserUseCase({required this.repository});
///
///   @override
///   Future<UserEntity> exec() => repository.getCurrentUser();
/// }
/// ```
abstract class UseCase<T> {
  Future<T> exec();
}

/// UseCase with mutable parameters
///
/// Use when you need to set params before execution:
/// ```dart
/// class UpdateUserUseCase extends UseCaseParams<void, UpdateUserParams> {
///   UpdateUserParams? _params;
///
///   @override
///   void setParams(UpdateUserParams params) => _params = params;
///
///   @override
///   Future<void> exec() async {
///     if (_params == null) throw Exception('Params not set');
///     // ...
///   }
/// }
/// ```
abstract class UseCaseParams<T, P> extends UseCase<T> {
  void setParams(P params);
}

/// Stateless UseCase with parameters passed directly to exec
///
/// Preferred pattern for most use cases:
/// ```dart
/// class LoginUseCase extends StatelessUseCase<AuthEntity, LoginParams> {
///   final AuthRepository repository;
///   LoginUseCase({required this.repository});
///
///   @override
///   Future<AuthEntity> exec(LoginParams params) =>
///       repository.login(params.email, params.password);
/// }
/// ```
abstract class StatelessUseCase<T, P> {
  Future<T> exec(P params);
}

/// Void parameter for UseCases that need StatelessUseCase interface but no params
class NoParams {
  const NoParams();
}
