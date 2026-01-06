import 'package:happyco/core/config/app_config.dart';
import 'package:injectable/injectable.dart' hide Environment;

/// Remote API Configuration
///
/// Provides base URL and environment settings loaded from AppConfig
/// Registered as singleton via Injectable
@lazySingleton
class RemoteConfig {
  /// Base API URL from environment
  String get baseUrl => AppConfig.instance.apiBaseUrl;

  /// API timeout in milliseconds
  int get timeout => AppConfig.instance.apiTimeout;

  /// Whether preview/beta features are enabled
  bool get previewEnabled => AppConfig.instance.previewEnabled;

  /// Current environment
  Environment get environment => AppConfig.instance.environment;

  /// Connect timeout duration
  Duration get connectTimeout => Duration(milliseconds: timeout);

  /// Receive timeout duration
  Duration get receiveTimeout => Duration(milliseconds: timeout);

  /// Check if running in production
  bool get isProduction => AppConfig.instance.isProduction;

  /// Check if running in development
  bool get isDevelopment => AppConfig.instance.isDevelopment;
}
