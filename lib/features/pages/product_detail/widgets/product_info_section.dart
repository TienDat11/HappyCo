import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

class ProductInfoSection extends StatelessWidget {
  final String name;
  final String displayPrice;
  final String? displayOldPrice;

  const ProductInfoSection({
    super.key,
    required this.name,
    required this.displayPrice,
    this.displayOldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(
            title: name,
            titleSize: UISizes.font.sp18,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.gray700,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: UISizes.height.h8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UIText(
                title: displayPrice,
                titleSize: UISizes.font.sp20,
                fontWeight: FontWeight.bold,
                titleColor: UIColors.primary,
              ),
              if (displayOldPrice != null) ...[
                SizedBox(width: UISizes.width.w12),
                Padding(
                  padding: EdgeInsets.only(bottom: UISizes.height.h2),
                  child: UIText(
                    title: displayOldPrice!,
                    titleSize: UISizes.font.sp14,
                    titleColor: UIColors.gray500,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
