import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/features/app_router.gr.dart';

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
        return BottomNavigationBar(
          currentIndex: tabRouter.activeIndex,
          onTap: tabRouter.setActiveIndex,
          backgroundColor: UIColors.white,
          selectedItemColor: UIColors.primary,
          unselectedItemColor: UIColors.gray500,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            // Placeholder for future tabs
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.category_outlined),
            //   activeIcon: Icon(Icons.category),
            //   label: 'Products',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person_outline),
            //   activeIcon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
          ],
        );
      },
    );
  }
}
