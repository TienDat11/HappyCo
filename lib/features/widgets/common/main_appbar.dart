import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

class MainAppbar extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? rightAction;

  const MainAppbar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.rightAction,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: UIColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(UISizes.square.r12),
          bottomRight: Radius.circular(UISizes.square.r12),
        ),
      ),
      padding: EdgeInsets.only(
        top: topPadding + UISizes.height.h12,
        bottom: UISizes.height.h12,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
        child: SizedBox(
          height: UISizes.height.h40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Back button (left)
              if (showBack)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: onBack ?? () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: UIColors.white,
                      size: UISizes.font.sp20,
                    ),
                  ),
                ),

              /// Title (center)
              Center(
                child: UIText(
                  title: title,
                  titleColor: UIColors.white,
                  titleSize: UISizes.font.sp16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// Right action (optional)
              if (rightAction != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: rightAction!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
