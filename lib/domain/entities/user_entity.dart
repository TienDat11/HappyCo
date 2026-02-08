/// User Entity
///
/// Domain layer entity representing an authenticated user.
/// This is a plain Dart class - no freezed for domain entities.
class UserEntity {
  final String id;
  final String username;
  final String fullName;
  final String? phone;
  final String? email;
  final String? address;
  final int? provinceId;
  final int? districtId;
  final int? wardId;

  const UserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    this.phone,
    this.email,
    this.address,
    this.provinceId,
    this.districtId,
    this.wardId,
  });

  /// Creates empty user placeholder
  factory UserEntity.empty() => const UserEntity(
        id: '',
        username: '',
        fullName: '',
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
