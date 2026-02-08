import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

/// Forgot Password Request DTO
///
/// Request body for POST /auth/forgot-password
@JsonSerializable()
class ForgotPasswordRequest {
  @JsonKey(name: 'email')
  final String email;

  ForgotPasswordRequest({
    required this.email,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
