import 'package:auto_route/auto_route.dart';
import 'package:happyco/features/app_router.gr.dart';

/// App Router - Minimal configuration for Happyco
///
/// Routes:
/// - MainRoute (with AutoTabsScaffold for bottom nav)
///   - HomeRoute (initial tab)
///
/// Generated file: app_router.gr.dart
/// Run: flutter pub run build_runner build --delete-conflicting-outputs
@AutoRouterConfig(
  replaceInRouteName: "Screen|Page,Route",
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const MaterialRouteType();

  @override
  List<AutoRoute> get routes => [
    // Main route with bottom navigation (AutoTabsScaffold)
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      initial: true,
      children: [
        // Home tab (initial)
        AutoRoute(
          page: HomeRoute.page,
          path: 'home',
          initial: true,
        ),
        // Placeholder for future tabs
        // AutoRoute(page: ProductsRoute.page, path: 'products'),
        // AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}
