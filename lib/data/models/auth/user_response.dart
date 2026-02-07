import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

/// User Response DTO
///
/// Response from GET /users/me
@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'provinceId')
  final int? provinceId;
  @JsonKey(name: 'districtId')
  final int? districtId;
  @JsonKey(name: 'wardId')
  final int? wardId;

  UserResponse({
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

  factory UserResponse.empty() => UserResponse(
        id: '',
        username: '',
        fullName: '',
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: _asString(json['id']),
      username: _asString(json['username']),
      fullName: _asString(json['fullName']),
      phone: _asNullableString(json['phone']),
      email: _asNullableString(json['email']),
      address: _asNullableString(json['address']),
      provinceId: _asNullableInt(json['provinceId']),
      districtId: _asNullableInt(json['districtId']),
      wardId: _asNullableInt(json['wardId']),
    );
  }

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

/// Login Response DTO
///
/// Response from POST /auth/login
@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;
  @JsonKey(name: 'user')
  final UserResponse user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: _asString(json['accessToken']),
      refreshToken: _asString(json['refreshToken']),
      user: _asUserResponse(json['user']),
    );
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

String _asString(dynamic value) => value?.toString() ?? '';

String? _asNullableString(dynamic value) {
  if (value == null) return null;
  final text = value.toString();
  return text.isEmpty ? null : text;
}

int? _asNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

UserResponse _asUserResponse(dynamic value) {
  if (value is Map<String, dynamic>) {
    return UserResponse.fromJson(value);
  }
  return UserResponse.empty();
}
