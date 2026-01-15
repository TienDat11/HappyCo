import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Custom bottom navigation bar with floating buy button for Happyco app.
///
/// This widget provides the main app navigation with four standard tabs
/// (Home, Category, News, Account) and a prominent floating "Buy" button
/// in the center. The bar features rounded top corners and a subtle shadow
/// for visual depth.
///
/// **Used in:**
/// - [HomePage]: Main navigation throughout the home experience
/// - [CategoryPage]: Navigation while browsing categories
/// - [NewsPage]: Navigation while reading articles
/// - [AccountPage]: Navigation while managing account
/// - All authenticated pages requiring main app navigation
///
/// **Design Specs (Figma node 1:728):**
/// - Container height: 80px (top padding: 16px, content: 40px, bottom padding: 24px)
/// - Top border radius: 24px on both corners
/// - Horizontal padding: 16px
/// - Shadow color: Red-tinted (#D32D27 with opacity)
/// - Shadow blur radius: 4px
/// - Nav item icon size: 24x24px
/// - Nav item label font: 10sp
/// - Nav item label weight: 600 (active) / 400 (inactive)
/// - Nav item spacing: space-around
/// - Center button diameter: 56px
/// - Center button vertical offset: -16px (floating above bar)
/// - Active color: Primary (#D32D27)
/// - Inactive color: Gray 500 (#9CA3AF)
///
/// **Features:**
/// - Four standard navigation items with icons and labels
/// - Floating circular "Buy" button in center
/// - Visual feedback for active/inactive states
/// - Rounded top corners for modern look
/// - SafeArea support for proper padding on different devices
/// - Custom red-tinted shadow for brand consistency
///
/// **Navigation Structure:**
/// ```
/// Index 0: Trang chủ (Home)
/// Index 1: Danh mục (Category)
/// Index 2: Tin tức (News)
/// Index 3: Tài khoản (Account)
/// Center: Buy button (independent callback)
/// ```
///
/// **Example:**
/// ```dart
/// int currentIndex = 0;
///
/// BottomMenubar(
///   currentIndex: currentIndex,
///   onTap: (index) {
///     setState(() {
///       currentIndex = index;
///       // Handle navigation to corresponding page
///     });
///   },
///   onBuyTap: () {
///     // Handle buy button action
///     showCartBottomSheet();
///   },
/// )
/// ```
///
/// **Example (With State Management):**
/// ```dart
/// BlocBuilder<NavigationBloc, NavigationState>(
///   builder: (context, state) {
///     return BottomMenubar(
///       currentIndex: state.currentIndex,
///       onTap: (index) => context
///           .read<NavigationBloc>()
///           .add(NavigateToIndex(index)),
///       onBuyTap: () => context
///           .read<CartBloc>()
///           .add(OpenCart()),
///     );
///   },
/// )
/// ```
///
/// **See also:**
/// - [BottomNavigationBar]: Material Design bottom navigation bar
/// - [FloatingActionButton]: For alternative floating button pattern
class BottomMenubar extends StatelessWidget {
  /// The index of the currently active navigation tab.
  ///
  /// Valid values are 0-3, corresponding to:
  /// - 0: Home (Trang chủ)
  /// - 1: Category (Danh mục)
  /// - 2: News (Tin tức)
  /// - 3: Account (Tài khoản)
  ///
  /// The active tab is highlighted with the primary color and bold text weight.
  final int currentIndex;

  /// Callback when a navigation tab is tapped.
  ///
  /// Called with the [int] index of the tapped tab (0-3).
  /// Typically used to update [currentIndex] and navigate to the
  /// corresponding page.
  ///
  /// Example:
  /// ```dart
  /// onTap: (index) {
  ///   setState(() => currentIndex = index);
  ///   switch(index) {
  ///     case 0: navigateToHome(); break;
  ///     case 1: navigateToCategory(); break;
  ///     case 2: navigateToNews(); break;
  ///     case 3: navigateToAccount(); break;
  ///   }
  /// }
  /// ```
  final ValueChanged<int> onTap;

  /// Callback when the center floating "Buy" button is tapped.
  ///
  /// This button is independent of the tab navigation and is typically
  /// used to quickly access the shopping cart, create a new order, or
  /// perform other buy-related actions.
  ///
  /// If null, the button is still displayed but tap is disabled.
  final VoidCallback? onBuyTap;

  const BottomMenubar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onBuyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UISizes.square.r24),
              topRight: Radius.circular(UISizes.square.r24),
            ),
            boxShadow: [
              BoxShadow(
                color: UIColors.navBarShadow,
                blurRadius: 4.0,
                offset: Offset.zero,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(
                top: UISizes.height.h16,
                bottom: UISizes.height.h24,
                left: UISizes.width.w16,
                right: UISizes.width.w16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    label: 'Trang chủ',
                    svgPath: UISvgs.navHome,
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    label: 'Danh mục',
                    svgPath: UISvgs.navCategory,
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  // Spacer for center button
                  SizedBox(width: UISizes.width.w56),
                  _NavItem(
                    label: 'Tin tức',
                    svgPath: UISvgs.navNews,
                    isActive: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                  _NavItem(
                    label: 'Tài khoản',
                    svgPath: UISvgs.navAccount,
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -UISizes.height.h16,
          left: 0,
          right: 0,
          child: Center(
            child: _CenterBuyButton(onTap: onBuyTap),
          ),
        ),
      ],
    );
  }
}

/// Individual navigation item widget for bottom menu bar.
///
/// Displays a navigation item with an SVG icon and text label below it.
/// Changes color and font weight based on active/inactive state.
///
/// **Design Specs:**
/// - Icon size: 24x24px
/// - Label font: 10sp
/// - Label weight: 600 (active) / 400 (inactive)
/// - Active color: Primary (#D32D27)
/// - Inactive color: Gray 500 (#9CA3AF)
class _NavItem extends StatelessWidget {
  /// The text label to display below the icon.
  ///
  /// Typically a short Vietnamese label like "Trang chủ", "Danh mục", etc.
  final String label;

  /// The SVG asset path for the icon.
  ///
  /// Should be a path relative to the assets folder, e.g., UISvgs.navHome.
  final String svgPath;

  /// Whether this navigation item is currently active.
  ///
  /// When true, the icon and label are displayed in the primary color
  /// with bold (600) font weight. When false, they use gray color with
  /// normal (400) font weight.
  final bool isActive;

  /// Callback when this navigation item is tapped.
  ///
  /// Typically used to update the [BottomMenubar.currentIndex] and
  /// navigate to the corresponding page.
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.svgPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? UIColors.primary : UIColors.gray500;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            width: UISizes.width.w24,
            height: UISizes.width.w24,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          SizedBox(height: UISizes.height.h4),
          Text(
            label,
            style: TextStyle(
              fontSize: UISizes.font.sp10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Floating circular buy button for the bottom menu bar.
///
/// This button floats above the navigation bar with the buy cart icon.
/// It has a circular shape with the primary background color and white icon.
///
/// **Design Specs:**
/// - Diameter: 56px
/// - Background: Primary color (#D32D27)
/// - Icon: 24x24px, white color
/// - Vertical offset: -16px (floats above bar)
/// - Shadow: Red-tinted, 4px blur radius
class _CenterBuyButton extends StatelessWidget {
  /// Callback when the buy button is tapped.
  ///
  /// Typically used to open the shopping cart, show a buy dialog,
  /// or navigate to a checkout flow. If null, the tap interaction
  /// is disabled.
  final VoidCallback? onTap;

  const _CenterBuyButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: UISizes.width.w56,
        height: UISizes.width.w56,
        decoration: BoxDecoration(
          color: UIColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: UIColors.navBarShadow,
              blurRadius: 4.0,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            UISvgs.navBuy,
            width: UISizes.width.w24,
            height: UISizes.width.w24,
            colorFilter:
                const ColorFilter.mode(UIColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
