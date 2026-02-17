import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happyco/data/data_locator.dart';
import 'package:happyco/features/app_router.gr.dart';

/// App Router - Minimal configuration for Happyco
///
/// Routes:
/// - SplashRoute (initial - app launch)
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
        // Splash route (initial - app launch)
        AutoRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'home',
              initial: true,
            ),
            AutoRoute(
              page: CategoryRoute.page,
              path: 'category',
            ),
            AutoRoute(
              page: NewsRoute.page,
              path: 'news',
            ),
            AutoRoute(
              page: AccountRoute.page,
              path: 'account',
            ),
          ],
        ),
        AutoRoute(
          page: NotificationRoute.page,
          path: '/notifications',
        ),
        AutoRoute(
          page: NotificationDetailRoute.page,
          path: '/notifications_detail',
        ),
        AutoRoute(
          page: ProductDetailRoute.page,
          path: '/product_detail',
        ),
      ];

  @override
  GlobalKey<NavigatorState> get navigatorKey => appNavigatorKey;
}
