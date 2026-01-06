import 'dart:async' as async;
import 'package:dio/dio.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/services/talker_service.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';
import 'package:happyco/data/requests/refresh_token_request.dart';
import 'package:happyco/data/responses/auth_token_response.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';

/// API Interceptor for Happyco
///
/// Handles:
/// - Automatic token refresh on 401
/// - Error handling (401 logout, 500 error pages)
///
/// Note: Request/Response logging is handled by TalkerDioLogger
/// which should be added as a separate interceptor.
class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    required StorageRepository storage,
    required Dio dio,
    required DialogService dialogService,
    required RemoteConfig config,
  })  : _storage = storage,
        _dio = dio,
        _dialogService = dialogService,
        _config = config;

  final StorageRepository _storage;
  final Dio _dio;
  final DialogService _dialogService;
  final RemoteConfig _config;

  async.Completer<AuthTokenResponse>? _refreshCompleter;
  bool _isForcingLogout = false;

  static const String _retryAfterRefreshKey = 'retryAfterRefresh';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldAttemptRefresh(err)) {
      try {
        final tokens = await _refreshToken();
        final requestOptions = err.requestOptions
          ..headers['Authorization'] = 'Bearer ${tokens.accessToken}'
          ..extra[_retryAfterRefreshKey] = true;
        final retryResponse = await _dio.fetch(requestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (refreshError, stackTrace) {
        talker.error('Token refresh failed', refreshError, stackTrace);
        _handleRefreshFailure();
      }
    }

    if (err.response?.statusCode == 500) {
      _showErrorPage(ErrorType.serverError);
    } else if (err.response?.statusCode == 404) {
      _showErrorPage(ErrorType.notFound);
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      _showErrorPage(ErrorType.noInternet);
    }
    super.onError(err, handler);
  }

  /// Determines if token refresh should be attempted
  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != 401) return false;

    final requestOptions = err.requestOptions;
    if (requestOptions.extra[_retryAfterRefreshKey] == true) return false;
    if (requestOptions.path == ApiEndpoints.refreshToken) return false;

    final refreshToken = _storage.getRefreshToken();
    return refreshToken?.isNotEmpty == true;
  }

  /// Refreshes access token using refresh token
  Future<AuthTokenResponse> _refreshToken() async {
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = async.Completer<AuthTokenResponse>();
    try {
      final accessToken = _storage.getAccessToken();
      final refreshToken = _storage.getRefreshToken();

      if (accessToken == null ||
          accessToken.isEmpty ||
          refreshToken == null ||
          refreshToken.isEmpty) {
        throw StateError('Missing tokens for refresh');
      }

      talker.debug('Attempting token refresh');

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: _config.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final response = await refreshDio.post<dynamic>(
        ApiEndpoints.refreshToken,
        data: RefreshTokenRequest(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ).toJson(),
      );

      final tokenResponse = AuthTokenResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      _storage
        ..setAccessToken(tokenResponse.accessToken)
        ..setRefreshToken(tokenResponse.refreshToken);
      _dio.options.headers['Authorization'] =
          'Bearer ${tokenResponse.accessToken}';

      talker.info('Token refresh successful');

      _refreshCompleter!.complete(tokenResponse);
      return tokenResponse;
    } catch (error, stackTrace) {
      talker.error('Token refresh error', error, stackTrace);
      _refreshCompleter!.completeError(error, stackTrace);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  /// Handles token refresh failure - force logout
  void _handleRefreshFailure() {
    if (_isForcingLogout) return;

    _isForcingLogout = true;
    _storage.clear();

    talker.warning('Session expired, forcing logout');

    _dialogService.show(
      DialogType.error,
      config: const DialogConfig(
        title: 'Phiên đăng nhập hết hạn',
        message: 'Vui lòng đăng nhập lại để tiếp tục',
        confirmText: 'Đăng nhập',
        barrierDismissible: false,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _isForcingLogout = false;
    });
  }

  /// Shows error page based on error type
  void _showErrorPage(ErrorType type) {
    talker.warning('Navigating to error page: $type');
  }
}

/// Error types for error pages
enum ErrorType {
  noInternet,
  serverError,
  notFound,
  unauthorized,
  forbidden,
}
