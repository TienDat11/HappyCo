import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/pages/main/widgets/bottom_menubar.dart';

/// Main Screen - Bottom Navigation Container
///
/// Uses AutoTabsScaffold for tab navigation
/// Currently has 1 tab: Home
/// Future tabs will be added here
@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
      ],
      bottomNavigationBuilder: (_, tabRouter) {
        return BottomMenubar(
          currentIndex: tabRouter.activeIndex,
          onTap: tabRouter.setActiveIndex,
          onBuyTap: () {
            // TODO: Navigate to Cart page
          },
        );
      },
    );
  }
}
