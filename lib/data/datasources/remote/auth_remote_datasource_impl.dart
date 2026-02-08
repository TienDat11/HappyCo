import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:happyco/core/exceptions/auth_exception.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';
import 'package:happyco/data/datasources/remote/auth_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/models/auth/forgot_password_request.dart';
import 'package:happyco/data/models/auth/login_request.dart';
import 'package:happyco/data/models/auth/refresh_otp_request.dart';
import 'package:happyco/data/models/auth/register_request.dart';
import 'package:happyco/data/models/auth/reset_password_request.dart';
import 'package:happyco/data/models/auth/user_response.dart';
import 'package:happyco/data/models/auth/verify_otp_request.dart';
import 'package:happyco/data/requests/refresh_token_request.dart';

/// Auth Remote Data Source Implementation
///
/// Concrete implementation of AuthRemoteDataSource.
/// Makes actual API calls using DioClient.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post<dynamic>(
        ApiEndpoints.login,
        data: LoginRequest(
          username: username,
          password: password,
        ).toJson(),
      );

      final responseMap = _ensureResponseMap(
        response.data,
        endpoint: ApiEndpoints.login,
      );

      return LoginResponse.fromJson(responseMap);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      if (statusCode == 401 || statusCode == 404) {
        final message = _extractMessage(
          responseData,
          fallback: 'Sai tài khoản hoặc mật khẩu',
        );
        throw AuthException(
          message,
          fieldErrors: {
            'username': 'Sai tài khoản hoặc mật khẩu',
            'password': 'Sai tài khoản hoặc mật khẩu',
          },
        );
      }

      _logPayload(
        endpoint: ApiEndpoints.login,
        statusCode: statusCode,
        payload: responseData,
        reason: 'Unhandled DioException in login',
      );
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e) {
      _logPayload(
        endpoint: ApiEndpoints.login,
        payload: e.toString(),
        reason: 'Login parsing failed',
      );
      throw AuthException('Phản hồi đăng nhập không hợp lệ');
    }
  }

  @override
  Future<void> register({
    required String username,
    required String password,
    required String fullName,
    required String phone,
    String? email,
  }) async {
    try {
      await _dioClient.post<dynamic>(
        ApiEndpoints.register,
        data: RegisterRequest(
          username: username,
          password: password,
          fullName: fullName,
          phone: phone,
          email: email,
        ).toJson(),
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 400 || statusCode == 409) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          final message = data['message'] as String? ??
              'Đăng ký thất bại. Vui lòng thử lại';
          final fieldErrors = _extractFieldErrors(data);

          if (fieldErrors.isEmpty) {
            fieldErrors.addAll(_mapDuplicateFieldErrors(message));
          }

          throw AuthException(
            message,
            fieldErrors: fieldErrors.isEmpty ? null : fieldErrors,
          );
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _dioClient.post<dynamic>(
      ApiEndpoints.forgotPassword,
      data: ForgotPasswordRequest(email: email).toJson(),
    );
  }

  @override
  Future<String> verifyOtp({
    required String email,
    required String code,
    required String scope,
  }) async {
    final resolvedEmail = email.trim();
    if (resolvedEmail.isEmpty) {
      throw AuthException('Email không hợp lệ để xác thực OTP');
    }

    if (code.length != 5 || !RegExp(r'^[0-9]{5}$').hasMatch(code)) {
      throw AuthException('Mã OTP phải có 5 chữ số');
    }

    try {
      final response = await _dioClient.post<dynamic>(
        ApiEndpoints.confirmOtp,
        data: VerifyOtpRequest(
          email: resolvedEmail,
          code: code,
          scope: scope,
        ).toJson(),
      );
      // Return the token from response for password reset flow
      return response.data['data']['token'] as String? ?? '';
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'] as String? ??
            'Xác thực OTP thất bại. Vui lòng thử lại';
        throw AuthException(message);
      }
      rethrow;
    }
  }

  @override
  Future<void> refreshOtp({required String email}) async {
    final resolvedEmail = email.trim();
    if (resolvedEmail.isEmpty) {
      throw AuthException('Email không hợp lệ để gửi lại OTP');
    }

    await _dioClient.post<dynamic>(
      ApiEndpoints.refreshOtp,
      data: RefreshOtpRequest(email: resolvedEmail).toJson(),
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    await _dioClient.post<dynamic>(
      ApiEndpoints.resetPassword,
      data: ResetPasswordRequest(
        email: email,
        token: token,
        newPassword: newPassword,
      ).toJson(),
    );
  }

  @override
  Future<UserResponse> getCurrentUser() async {
    final response = await _dioClient.get<dynamic>(ApiEndpoints.profile);
    return UserResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Map<String, dynamic> _ensureResponseMap(
    dynamic payload, {
    required String endpoint,
  }) {
    if (payload is Map<String, dynamic>) {
      return payload;
    }

    _logPayload(
      endpoint: endpoint,
      payload: payload,
      reason: 'Response payload is not a map',
    );
    throw AuthException('Phản hồi từ máy chủ không đúng định dạng');
  }

  String _extractMessage(dynamic payload, {required String fallback}) {
    if (payload is Map<String, dynamic>) {
      final message = payload['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
    }
    return fallback;
  }

  void _logPayload({
    required String endpoint,
    required String reason,
    int? statusCode,
    dynamic payload,
  }) {
    final payloadPreview = _sanitizePayload(payload);
    developer.log(
      '[AuthRemoteDataSource] $reason | endpoint=$endpoint | status=$statusCode | payload=$payloadPreview',
      name: 'AuthRemoteDataSource',
    );
  }

  String _sanitizePayload(dynamic payload) {
    if (payload == null) return 'null';

    dynamic redacted = payload;
    if (payload is Map<String, dynamic>) {
      redacted = Map<String, dynamic>.from(payload);
      const sensitiveKeys = {
        'password',
        'accessToken',
        'refreshToken',
        'token'
      };
      for (final key in sensitiveKeys) {
        if ((redacted as Map<String, dynamic>).containsKey(key)) {
          redacted[key] = '***';
        }
      }
    }

    String serialized;
    try {
      serialized = redacted is String ? redacted : jsonEncode(redacted);
    } catch (_) {
      serialized = redacted.toString();
    }

    const maxLength = 600;
    if (serialized.length <= maxLength) return serialized;
    return '${serialized.substring(0, maxLength)}...';
  }

  Map<String, String> _extractFieldErrors(Map<String, dynamic> data) {
    final fieldErrors = <String, String>{};

    final errors = data['errors'];
    if (errors is Map<String, dynamic>) {
      for (final entry in errors.entries) {
        final value = entry.value;
        if (value == null) continue;
        if (value is List && value.isNotEmpty) {
          fieldErrors[entry.key] = value.first.toString();
        } else {
          fieldErrors[entry.key] = value.toString();
        }
      }
    }

    final field = data['field'];
    final message = data['message'];
    if (field is String && message is String && fieldErrors[field] == null) {
      fieldErrors[field] = message;
    }

    return fieldErrors;
  }

  Map<String, String> _mapDuplicateFieldErrors(String message) {
    final normalized = message.toLowerCase();
    final mapped = <String, String>{};

    if (normalized.contains('phoneused') ||
        normalized.contains('phone used') ||
        normalized.contains('số điện thoại')) {
      mapped['phone'] = 'Số điện thoại đã được sử dụng';
    }

    if (normalized.contains('emailused') ||
        normalized.contains('email used') ||
        normalized.contains('email')) {
      mapped['email'] = 'Email đã được sử dụng';
    }

    return mapped;
  }

  @override
  Future<LoginResponse> refreshToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    final response = await _dioClient.post<dynamic>(
      ApiEndpoints.refreshToken,
      data: RefreshTokenRequest(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ).toJson(),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
