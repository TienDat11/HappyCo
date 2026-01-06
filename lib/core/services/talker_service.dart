import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Global instance of [Talker] for application-wide logging.
///
/// Use this instance to log info, errors, and exceptions.
/// It is configured to display logs in the console only during debug mode.
late final Talker talker;

/// Initializes the logging service and global error handlers.
///
/// Must be called in `main()` before `runApp`.
void initLogger() {
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      useConsoleLogs: kDebugMode,
      maxHistoryItems: 1000,
      enabled: true,
    ),
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(
        enableColors: true,
      ),
    ),
  );

  _setupErrorHooks();
}

/// Captures uncaught Flutter and Platform errors.
void _setupErrorHooks() {.
  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack, 'Uncaught Flutter Error');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Uncaught Platform Error');
    return true;
  };
}
