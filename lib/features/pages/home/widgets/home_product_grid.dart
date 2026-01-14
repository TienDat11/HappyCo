import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/pages/home/widgets/decorative_section_title.dart';
import 'package:happyco/features/pages/home/widgets/home_product_card.dart';

/// Home Product Grid Widget
///
/// Displays product section with:
/// - Decorative title (with dashed lines)
/// - 2-column product grid with 0.68 aspect ratio
/// - "Xem tất cả" button at bottom
class HomeProductGrid extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final List<ProductEntity> products;
  final void Function(ProductEntity product)? onProductTap;
  final void Function(ProductEntity product)? onAddToCart;
  final bool isLoading;

  const HomeProductGrid({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    required this.products,
    this.onProductTap,
    this.onAddToCart,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section header with dashed lines
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          child: DecorativeSectionTitle(title: title),
        ),
        SizedBox(height: UISizes.height.h14),
        // Product grid (2 columns)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: UISizes.width.w12,
              crossAxisSpacing: UISizes.width.w12,
              childAspectRatio: 0.665, // Exact match for 173/260 (per Figma)
            ),
            itemCount: isLoading ? 4 : products.length,
            itemBuilder: (context, index) => isLoading
                ? HomeProductCard(
                    product: ProductEntity.empty(),
                    isLoading: true,
                  )
                : HomeProductCard(
                    product: products[index],
                    onTap: onProductTap != null
                        ? () => onProductTap!(products[index])
                        : null,
                    onAddToCart: onAddToCart != null
                        ? () => onAddToCart!(products[index])
                        : null,
                  ),
          ),
        ),
        SizedBox(height: UISizes.height.h14),
        // "Xem tất cả" button
        if (actionText != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            child: GestureDetector(
              onTap: onActionTap,
              child: Container(
                width: UISizes.width.w140,
                height: UISizes.height.h40,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(UISizes.square.r8),
                  boxShadow: [
                    BoxShadow(
                      color: UIColors.cardShadow,
                      blurRadius: UISizes.square.r4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: UIText(
                    title: actionText!,
                    titleSize: UISizes.font.sp14,
                    titleColor: UIColors.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
