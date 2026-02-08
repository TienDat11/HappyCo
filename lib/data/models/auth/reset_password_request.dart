import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

/// Reset Password Request DTO
///
/// Request body for POST /auth/reset_password
/// Requires: email, token (from OTP confirm), and new password
@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'password')
  final String newPassword;

  ResetPasswordRequest({
    required this.email,
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
