import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Section header with title and "View all" action.
///
/// Based on Figma design: Title left, "Xem tất cả" link right.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIText(
          title: title,
          titleSize: UISizes.font.sp16,
          fontWeight: FontWeight.w600,
          titleColor: UIColors.primary,
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: UIText(
              title: actionText!,
              titleSize: UISizes.font.sp12,
              titleColor: UIColors.gray500,
            ),
          ),
      ],
    );
  }
}
