library;

/// API Exception Hierarchy for Happyco
///
/// Provides detailed exception types for better error classification
/// and user-facing error messages.

class ApiException implements Exception {
  final String message;
  final String userMessage;

  ApiException(this.message, this.userMessage);

  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  final int? statusCode;

  NetworkException(String message, String userMessage, {this.statusCode})
      : super(message, userMessage);

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException extends NetworkException {
  TimeoutException()
      : super(
          'Request timeout',
          'Yêu cầu đã hết thời gian. Vui lòng thử lại.',
        );

  @override
  String toString() => 'TimeoutException: Request timeout';
}

class NoInternetException extends NetworkException {
  NoInternetException()
      : super(
          'No internet connection',
          'Không có kết nối mạng. Vui lòng kiểm tra kết nối của bạn.',
        );

  @override
  String toString() => 'NoInternetException: No internet';
}

class ClientException extends ApiException {
  final int? statusCode;

  ClientException(String message, String userMessage, {this.statusCode})
      : super(message, userMessage);

  @override
  String toString() => 'ClientException: $message';
}

class BadRequestException extends ClientException {
  final Map<String, dynamic>? validationErrors;

  BadRequestException({this.validationErrors})
      : super(
          'Bad request',
          'Yêu cầu không hợp lệ. Vui lòng kiểm tra lại.',
          statusCode: 400,
        );

  @override
  String toString() => 'BadRequestException: $validationErrors';
}

class UnauthorizedException extends ClientException {
  UnauthorizedException()
      : super(
          'Unauthorized',
          'Vui lòng đăng nhập để tiếp tục.',
          statusCode: 401,
        );

  @override
  String toString() => 'UnauthorizedException: 401';
}

class ForbiddenException extends ClientException {
  ForbiddenException()
      : super(
          'Forbidden',
          'Bạn không có quyền thực hiện thao tác này.',
          statusCode: 403,
        );

  @override
  String toString() => 'ForbiddenException: 403';
}

class NotFoundException extends ClientException {
  NotFoundException()
      : super(
          'Not found',
          'Không tìm thấy dữ liệu yêu cầu.',
          statusCode: 404,
        );

  @override
  String toString() => 'NotFoundException: 404';
}

class ServerException extends ApiException {
  final int? statusCode;

  ServerException(String message, String userMessage, {this.statusCode})
      : super(message, userMessage);

  @override
  String toString() => 'ServerException: $message';
}

class InternalServerError extends ServerException {
  final String? details;

  InternalServerError({this.details})
      : super(
          details != null
              ? 'Internal server error: $details'
              : 'Internal server error',
          'Lỗi hệ thống. Vui lòng thử lại sau.',
          statusCode: 500,
        );

  @override
  String toString() => 'InternalServerError: $details';
}

class ServiceUnavailableException extends ServerException {
  ServiceUnavailableException()
      : super(
          'Service unavailable',
          'Dịch vụ đang bảo trì. Vui lòng thử lại sau.',
          statusCode: 503,
        );

  @override
  String toString() => 'ServiceUnavailableException: 503';
}

class ParseException extends ApiException {
  ParseException()
      : super(
          'Parse error',
          'Lỗi xử lý dữ liệu.',
        );

  @override
  String toString() => 'ParseException: Parse error';
}

class RefreshTokenException extends ApiException {
  RefreshTokenException()
      : super(
          'Token refresh failed',
          'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        );

  @override
  String toString() => 'RefreshTokenException: Token refresh failed';
}
