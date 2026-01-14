import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Bottom Menubar - Custom navigation bar for Happyco
/// 
/// Based on Figma Design Node 1-728
/// Features:
/// - Individual items for Home, Category, News, and Account
/// - Floating center Buy button
/// - Custom styling with red-tinted shadow and top rounded corners
class BottomMenubar extends StatelessWidget {
  /// Current active tab index
  final int currentIndex;

  /// Callback when a tab is tapped
  final ValueChanged<int> onTap;

  /// Callback when the center buy button is tapped
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

/// Individual Navigation Item
class _NavItem extends StatelessWidget {
  final String label;
  final String svgPath;
  final bool isActive;
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

/// Floating Center Buy Button
class _CenterBuyButton extends StatelessWidget {
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
            colorFilter: const ColorFilter.mode(UIColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
