import 'package:happyco/data/models/auth/user_response.dart';
import 'package:happyco/domain/entities/auth_token_entity.dart';
import 'package:happyco/domain/entities/user_entity.dart';

/// User Mapper - DTO to Entity conversion
extension UserMapper on UserResponse {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      fullName: fullName,
      phone: phone,
      email: email,
      address: address,
      provinceId: provinceId,
      districtId: districtId,
      wardId: wardId,
    );
  }
}

/// Auth Token Mapper - Response to Entity conversion
extension AuthTokenMapper on LoginResponse {
  AuthTokenEntity toAuthTokenEntity() {
    return AuthTokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
