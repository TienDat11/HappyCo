import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Horizontal product card widget for news section.
///
/// Features 80x56px thumbnail, name, and prices.
/// Based on Figma design node-id=1:2544-1:2546.
class ProductCompactCard extends StatelessWidget {
  final ProductEntity product;

  final VoidCallback? onTap;

  const ProductCompactCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r8,
      padding: EdgeInsets.all(UISizes.width.w8),
      hasShadow: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UISizes.square.r8),
        child: Row(
          children: [
            _buildThumbnail(),
            SizedBox(width: UISizes.width.w12),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UISizes.square.r4),
      child: Image.network(
        product.imageUrl,
        width: UISizes.width.w80,
        height: UISizes.height.h56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: UISizes.width.w80,
            height: UISizes.height.h56,
            color: UIColors.gray100,
            child: Icon(
              Icons.image_outlined,
              size: UISizes.width.w24,
              color: UIColors.gray300,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(
          title: product.name,
          titleSize: UISizes.font.sp14,
          fontWeight: FontWeight.w600,
          titleColor: UIColors.gray700,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: UISizes.height.h4),
        Row(
          children: [
            UIText(
              title: product.formattedPrice,
              titleSize: UISizes.font.sp14,
              fontWeight: FontWeight.w600,
              titleColor: UIColors.primary,
            ),
            if (product.formattedOldPrice != null) ...[
              SizedBox(width: UISizes.width.w8),
              UIText(
                title: product.formattedOldPrice!,
                titleSize: UISizes.font.sp12,
                titleColor: UIColors.gray500,
                decoration: TextDecoration.lineThrough,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
