import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyco/features/app_router.dart';

/// Happyco Application - Root widget
/// NO LOCALIZATION - Single language app (Wood furniture manufacturing)
class HappycoApplication extends StatefulWidget {
  const HappycoApplication({super.key});

  @override
  State<HappycoApplication> createState() => _HappycoApplicationState();
}

class _HappycoApplicationState extends State<HappycoApplication> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => false,
      child: MaterialApp.router(
        title: 'Happyco',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF8B4513), // Saddle Brown - Wood theme
          ),
          useMaterial3: true,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routeInformationProvider: _appRouter.routeInfoProvider(),
      ),
    );
  }
}
