import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Account Menu Item Widget
///
/// A single menu row with icon, title, and optional trailing arrow.
/// Used in the Account screen's menu card.
class AccountMenuItem extends StatelessWidget {
  /// SVG icon path
  final String iconPath;

  /// Menu item title
  final String title;

  /// Callback when item is tapped
  final VoidCallback? onTap;

  /// Whether to show trailing arrow
  final bool showArrow;

  /// Whether this is the last item (no bottom border)
  final bool isLast;

  /// Custom icon background color
  final Color? iconBackgroundColor;

  const AccountMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.showArrow = true,
    this.isLast = false,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: UISizes.height.h12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: UIColors.gray100,
                    width: UISizes.square.r1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Container(
              width: UISizes.square.r32,
              height: UISizes.square.r32,
              padding: EdgeInsets.all(UISizes.square.r4),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? UIColors.red50,
                borderRadius: BorderRadius.circular(UISizes.square.r16),
              ),
              child: SvgPicture.asset(
                iconPath,
                width: UISizes.square.r20,
                height: UISizes.square.r20,
              ),
            ),
            SizedBox(width: UISizes.width.w8),
            Expanded(
              child: UIText(
                title: title,
                titleSize: UISizes.font.sp14,
                fontWeight: FontWeight.w500,
                titleColor: UIColors.gray700,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: UISizes.width.w8),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: UISizes.square.r20,
                color: UIColors.gray400,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
