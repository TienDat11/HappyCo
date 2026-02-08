import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

/// Verify OTP Request DTO
///
/// Request body for POST /auth/confirm_otp
/// Scope must be one of: "confirm_email", "forgot_passwd", "delete_account", "blood_donation"
@JsonSerializable()
class VerifyOtpRequest {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'scope')
  final String scope;

  VerifyOtpRequest({
    required this.email,
    required this.code,
    required this.scope,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
