import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_response.freezed.dart';
part 'auth_token_response.g.dart';

/// Authentication token response
@freezed
class AuthTokenResponse with _$AuthTokenResponse {
  const factory AuthTokenResponse({
    required String accessToken,
    required String refreshToken,
    String? tokenType,
    int? expiresIn,
  }) = _AuthTokenResponse;

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenResponseFromJson(json);
}
