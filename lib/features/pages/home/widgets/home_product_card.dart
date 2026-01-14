import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';

/// Home Product Card Widget
///
/// Refactored to match Figma node 1:777
/// Individual product card with compact padding and overflow-safe price layout
class HomeProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool isLoading;

  const HomeProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r12,
      padding: EdgeInsets.all(UISizes.width.w8),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(UISizes.square.r12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: isLoading
              ? [
                  HappyShimmer.rounded(
                    width: double.infinity,
                    height: UISizes.width.w140,
                    borderRadius: UISizes.square.r12,
                  ),
                  SizedBox(height: UISizes.width.w8),
                  HappyShimmer.rounded(
                    width: double.infinity,
                    height: UISizes.font.sp14,
                  ),
                  SizedBox(height: UISizes.width.w8),
                  HappyShimmer.rounded(
                    width: UISizes.width.w100,
                    height: UISizes.font.sp14,
                  ),
                  const Spacer(),
                  HappyShimmer.rounded(
                    width: double.infinity,
                    height: UISizes.width.w40,
                    borderRadius: UISizes.square.r8,
                  ),
                ]
              : [
            // Product image (Fixed height 140px)
            ClipRRect(
              borderRadius: BorderRadius.circular(UISizes.square.r12),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: UISizes.width.w140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: UISizes.width.w140,
                    color: UIColors.gray100,
                    child: Icon(
                      Icons.image_outlined,
                      size: UISizes.width.w40,
                      color: UIColors.gray300,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: UISizes.width.w8),
            // Product Name (subtitle 2: sp14, SemiBold)
            UIText(
              title: product.name,
              titleSize: UISizes.font.sp14,
              fontWeight: FontWeight.w600,
              titleColor: UIColors.gray700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: UISizes.width.w4),
            // Price section (Safe from overflow)
            SizedBox(
              height: UISizes.width.w22,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    UIText(
                      title: product.formattedPrice,
                      titleSize: UISizes.font.sp14,
                      fontWeight: FontWeight.w600,
                      titleColor: UIColors.primary,
                    ),
                    if (product.formattedOldPrice != null) ...[
                      SizedBox(width: UISizes.width.w12),
                      UIText(
                        title: product.formattedOldPrice!,
                        titleSize: UISizes.font.sp12,
                        titleColor: UIColors.gray500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: UISizes.width.w8),
            // Add to cart button (Button Sm: sp13, Medium)
            GestureDetector(
              onTap: onAddToCart,
              child: Container(
                width: double.infinity,
                height: UISizes.width.w40,
                decoration: BoxDecoration(
                  color: UIColors.primary,
                  borderRadius: BorderRadius.circular(UISizes.square.r8),
                ),
                child: Center(
                  child: UIText(
                    title: 'Thêm vào giỏ hàng',
                    titleSize: UISizes.font.sp13,
                    titleColor: UIColors.textOnPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
