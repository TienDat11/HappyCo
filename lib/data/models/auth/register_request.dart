import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

/// Register Request DTO
///
/// Request body for POST /auth/register
/// API requires: username (phone), password, fullName, phone
@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'email')
  final String? email;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.fullName,
    required this.phone,
    this.email,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
