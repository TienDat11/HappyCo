import 'package:dio/dio.dart';
import 'package:happyco/data/datasources/remote/api_interceptor.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';

/// HTTP Client wrapper for API requests
///
/// Provides Dio instance with configured interceptors, timeouts,
/// and headers. Correlation IDs and retry logic handled via interceptors.
class DioClient {
  late final Dio _dio;
  final ApiInterceptor _interceptor;

  DioClient({
    required RemoteConfig config,
    required ApiInterceptor interceptor,
  }) : _interceptor = interceptor {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        headers: _getDefaultHeaders(),
        responseType: ResponseType.json,
      ),
    );

    // Add logging to debug URL issues
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🚀 [DioClient] Request: ${options.method} ${options.uri}');
          print('🚀 [DioClient] BaseURL: ${options.baseUrl}');
          print('🚀 [DioClient] Path: ${options.path}');
          return handler.next(options);
        },
        onError: (e, handler) {
          print('❌ [DioClient] Error: ${e.message}');
          print('❌ [DioClient] URL: ${e.requestOptions.uri}');
          print('❌ [DioClient] Status: ${e.response?.statusCode}');
          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(_interceptor);
  }

  Map<String, dynamic> _getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Get underlying Dio instance for advanced usage
  Dio get dio => _dio;
}
