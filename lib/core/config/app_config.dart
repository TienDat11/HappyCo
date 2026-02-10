import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happyco/core/services/talker_service.dart';

/// Application Configuration
///
/// Loads configuration from environment variables (.env files)
/// Access via singleton: AppConfig.instance
///
/// Usage:
/// ```dart
/// await AppConfig.init(); // Call in main.dart before runApp
/// final baseUrl = AppConfig.instance.apiBaseUrl;
/// ```
class AppConfig {
  AppConfig._();

  static AppConfig? _instance;

  /// Singleton instance
  static AppConfig get instance {
    if (_instance == null) {
      throw StateError(
        'AppConfig not initialized. Call AppConfig.init() first.',
      );
    }
    return _instance!;
  }

  /// Check if initialized
  static bool get isInitialized => _instance != null;

  /// Current environment
  late final Environment environment;

  /// API base URL
  late final String apiBaseUrl;

  /// URL S3
  late final String imageBaseUrl;

  /// API timeout in milliseconds
  late final int apiTimeout;

  /// Whether preview features are enabled
  late final bool previewEnabled;

  /// Initialize configuration from environment
  ///
  /// [envFileName] - Optional specific .env file to load
  /// Defaults to loading based on FLUTTER_ENV or .env
  static Future<void> init({String? envFileName}) async {
    if (_instance != null) {
      talker.warning('AppConfig already initialized');
      return;
    }

    _instance = AppConfig._();
    await _instance!._load(envFileName);
  }

  Future<void> _load(String? envFileName) async {
    final fileName = envFileName ?? _getEnvFileName();

    try {
      await dotenv.load(fileName: fileName);
      talker.info('Loaded environment from: $fileName');
    } catch (e) {
      talker.warning('Could not load $fileName, using defaults');
    }

    final envString = dotenv.env['FLUTTER_ENV'] ?? 'development';
    environment = Environment.fromString(envString);

    apiBaseUrl = dotenv.env['API_BASE_URL'] ?? _getDefaultApiUrl(environment);
    imageBaseUrl =
        dotenv.env['IMAGE_BASE_URL'] ?? 'https://s3.sunteco.app/happyco/';
    apiTimeout = int.tryParse(dotenv.env['API_TIMEOUT'] ?? '') ?? 30000;

    previewEnabled = dotenv.env['PREVIEW_ENABLED']?.toLowerCase() == 'true' ||
        environment != Environment.production;

    talker.info('AppConfig initialized: env=$environment, url=$apiBaseUrl');
  }

  String _getEnvFileName() {
    const compileEnv = String.fromEnvironment('FLUTTER_ENV');
    if (compileEnv.isNotEmpty) {
      return '.env.$compileEnv';
    }
    return '.env';
  }

  String _getDefaultApiUrl(Environment env) {
    switch (env) {
      case Environment.production:
        return 'https://api.happyco.com';
      case Environment.staging:
        return 'https://api-staging.happyco.com';
      case Environment.development:
        return 'http://localhost:3000';
    }
  }

  /// Check if running in production
  bool get isProduction => environment == Environment.production;

  /// Check if running in development
  bool get isDevelopment => environment == Environment.development;

  /// Check if running in staging
  bool get isStaging => environment == Environment.staging;

  @override
  String toString() {
    return 'AppConfig(env: $environment, apiBaseUrl: $apiBaseUrl, '
        'timeout: $apiTimeout, preview: $previewEnabled)';
  }
}

/// Application environment
enum Environment {
  development,
  staging,
  production;

  static Environment fromString(String value) {
    switch (value.toLowerCase()) {
      case 'production':
      case 'prod':
        return Environment.production;
      case 'staging':
      case 'stage':
        return Environment.staging;
      case 'development':
      case 'dev':
      default:
        return Environment.development;
    }
  }
}
