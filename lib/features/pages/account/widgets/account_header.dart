import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Account Header Widget
///
/// Red header with "Tài khoản" title.
/// Matches Figma design with primary color background.
class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: UISizes.width.w16,
        right: UISizes.width.w16,
        top: UISizes.height.h12,
        bottom: UISizes.height.h12,
      ),
      decoration: BoxDecoration(
        color: UIColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(UISizes.square.r12),
          bottomRight: Radius.circular(UISizes.square.r12),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: UISizes.height.h24,
              child: Center(
                child: UIText(
                  title: 'Tài khoản',
                  titleSize: UISizes.font.sp16,
                  fontWeight: FontWeight.w600,
                  titleColor: UIColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
