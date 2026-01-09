import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/application.dart';
import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/core/services/talker_service.dart';
import 'package:happyco/firebase_options.dart';
import 'package:happyco/setup_locator.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// Main entry point for Happyco app
/// Wood furniture manufacturing - No i18n
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    initLogger();
    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printEvents: true,
        printTransitions: true,
        printChanges: false,
      ),
    );

    try {
      await AppConfig.init();
      talker.info('AppConfig initialized: ${AppConfig.instance}');
    } catch (e, stackTrace) {
      talker.error('AppConfig init failed', e, stackTrace);
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      talker.info('Firebase initialized successfully');
    } catch (e, stackTrace) {
      talker.warning('Firebase init failed - continuing in offline mode', e, stackTrace);
    }

    await setupLocator();
    talker.info('DI setup complete');

    runApp(const HappycoApp());
  }, (error, stack) {
    talker.error('Uncaught error', error, stack);
  });
}

/// Happyco App Root
/// No BLoC providers at root - provided at route level as needed
class HappycoApp extends StatelessWidget {
  const HappycoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HappycoApplication();
  }
}
