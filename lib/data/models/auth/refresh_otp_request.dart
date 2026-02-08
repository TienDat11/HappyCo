import 'package:json_annotation/json_annotation.dart';

part 'refresh_otp_request.g.dart';

/// Refresh OTP Request DTO
///
/// Request body for POST /auth/refresh_otp
@JsonSerializable()
class RefreshOtpRequest {
  @JsonKey(name: 'email')
  final String email;

  RefreshOtpRequest({
    required this.email,
  });

  factory RefreshOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshOtpRequestToJson(this);
}
