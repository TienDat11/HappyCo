/// Auth Token Entity
///
/// Domain layer entity representing authentication tokens.
/// This is a plain Dart class - no freezed for domain entities.
class AuthTokenEntity {
  final String accessToken;
  final String refreshToken;

  const AuthTokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  /// Creates empty token placeholder
  factory AuthTokenEntity.empty() => const AuthTokenEntity(
        accessToken: '',
        refreshToken: '',
      );

  /// Check if tokens are valid (non-empty)
  bool get isValid => accessToken.isNotEmpty && refreshToken.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthTokenEntity && other.accessToken == accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;
}
