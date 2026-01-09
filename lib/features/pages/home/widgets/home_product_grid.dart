import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Home Product Grid Widget
///
/// Reusable product grid with 2 columns
/// Can be used for "Featured Products" and "Recommended Products"
class HomeProductGrid extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final List<ProductEntity> products;
  final void Function(ProductEntity product)? onProductTap;
  final void Function(ProductEntity product)? onAddToCart;

  const HomeProductGrid({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    required this.products,
    this.onProductTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        _buildHeader(),
        SizedBox(height: UISizes.height.h16),
        // Product grid
        _buildGrid(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Row(
        children: [
          Flexible(
            child: UIText(
              title: title,
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.gray900,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (actionText != null) ...[
            SizedBox(width: UISizes.width.w8),
            GestureDetector(
              onTap: onActionTap,
              child: UIText(
                title: actionText!,
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: UISizes.width.w16,
        crossAxisSpacing: UISizes.width.w16,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => HomeProductCard(
        product: products[index],
        onTap: onProductTap != null ? () => onProductTap!(products[index]) : null,
        onAddToCart: onAddToCart != null ? () => onAddToCart!(products[index]) : null,
      ),
    );
  }
}

/// Home Product Card Widget
///
/// Individual product card with:
/// - Product image
/// - Product name
/// - Price with optional discount
/// - Add to cart button
class HomeProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const HomeProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r8,
      border: Border.all(
        color: UIColors.gray100,
        width: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(UISizes.square.r8),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
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
            ),
          ),
          // Product info
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(UISizes.width.w8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UIText(
                        title: product.name,
                        titleSize: UISizes.font.sp14,
                        fontWeight: FontWeight.w600,
                        titleColor: UIColors.gray900,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: UISizes.height.h2),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          UIText(
                            title: product.formattedPrice,
                            titleSize: UISizes.font.sp14,
                            fontWeight: FontWeight.bold,
                            titleColor: UIColors.primary,
                          ),
                          if (product.formattedOldPrice != null) ...[
                            SizedBox(width: UISizes.width.w6),
                            UIText(
                              title: product.formattedOldPrice!,
                              titleSize: UISizes.font.sp12,
                              titleColor: UIColors.gray400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  // Add to cart button
                  GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: UISizes.height.h6),
                      decoration: BoxDecoration(
                        color: UIColors.primary,
                        borderRadius: BorderRadius.circular(UISizes.square.r4),
                      ),
                      child: UIText(
                        title: 'Thêm',
                        titleSize: UISizes.font.sp12,
                        titleColor: UIColors.white,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
