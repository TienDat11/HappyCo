import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Home Banner Widget
class HomeBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const HomeBanner({
    super.key,
    this.imageUrl =
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
    this.title = 'Bộ sưu tập gỗ mới',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: UISizes.height.h180,
        decoration: BoxDecoration(
          color: UIColors.primary,
          borderRadius: BorderRadius.circular(UISizes.square.r8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UISizes.square.r8),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
              ],
            ),
          ),
          padding: EdgeInsets.all(UISizes.width.w16),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: UIText(
              title: title,
              titleColor: UIColors.white,
              titleSize: UISizes.font.sp20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
