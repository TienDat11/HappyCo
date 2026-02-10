import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// A reusable product card widget for displaying furniture products.
///
/// This widget represents a single product in a grid or list, showing
/// the product image, name, price (with optional old price), and an
/// "Add to Cart" button. It handles loading states with shimmer effects.
///
/// **Used in:**
/// - [ProductGrid]: Individual items in the 2-column product grid
/// - [HomePage]: Featured and recommended product cards
/// - [CategoryPage]: Category-filtered product cards
/// - Other product listing screens
///
/// **Design Specs (Figma node 1:777):**
/// - Card dimensions: 173x260px (0.665 aspect ratio)
/// - Border radius: 12px
/// - Padding: 8px
/// - Image height: 140px
/// - Product name: 14sp, SemiBold (600), Gray 700
/// - Price: 14sp, SemiBold (600), Primary color
/// - Old price: 12sp, Gray 500, strikethrough
/// - Button: 40px height, 13sp, Medium (500)
///
/// **Features:**
/// - Network image loading with error fallback
/// - Price overflow protection with FittedBox
/// - Optional sale price display (old price with strikethrough)
/// - Shimmer loading state
/// - Add to cart button with primary color
/// - Tap gesture for product details navigation
///
/// **Example:**
/// ```dart
/// ProductCard(
///   product: product,
///   onTap: () => navigateToDetail(product),
///   onAddToCart: () => addToCart(product),
/// )
/// ```
///
/// **Example (Loading State):**
/// ```dart
/// ProductCard(
///   product: ProductEntity.empty(),
///   isLoading: true,
/// )
/// ```
class ProductCard extends StatelessWidget {
  /// The product entity to display.
  ///
  /// Contains product details like name, price, imageUrl.
  /// When [isLoading] is true, this is ignored.
  final ProductEntity product;

  /// Callback when the card is tapped.
  ///
  /// Typically used to navigate to product detail page.
  /// Disabled when [isLoading] is true.
  final VoidCallback? onTap;

  /// Callback when "Thêm vào giỏ hàng" button is tapped.
  ///
  /// Handles adding the product to the shopping cart.
  /// Disabled when [isLoading] is true.
  final VoidCallback? onAddToCart;

  /// Whether to show skeleton loading state.
  ///
  /// When true:
  /// - Displays shimmer placeholders for image, text, and button
  /// - Disables tap interactions
  /// - Ignores [product] data
  final bool isLoading;

  const ProductCard({
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
          children: [
            ...(isLoading ? _buildLoadingState() : _buildProductContent()),
          ],
        ),
      ),
    );
  }

  /// Builds the skeleton loading state with shimmer effects.
  List<Widget> _buildLoadingState() {
    return [
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
    ];
  }

  /// Builds the actual product content with image, name, price, and button.
  List<Widget> _buildProductContent() {
    return [
      _buildProductImage(),
      SizedBox(height: UISizes.width.w8),
      _buildProductName(),
      SizedBox(height: UISizes.width.w4),
      _buildPriceSection(),
      SizedBox(height: UISizes.width.w8),
      _buildAddToCartButton(),
    ];
  }

  /// Builds the product image with rounded corners, error handling,
  /// and optional discount badge at top-left corner.
  Widget _buildProductImage() {
    return Stack(
      children: [
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
        if (product.hasDiscount && product.discountPercent != null)
          Positioned(
            top: UISizes.width.w4,
            left: UISizes.width.w4,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: UISizes.width.w8,
                vertical: UISizes.height.h4,
              ),
              decoration: BoxDecoration(
                color: UIColors.primary,
                borderRadius: BorderRadius.circular(UISizes.square.r4),
              ),
              child: UIText(
                title: '-${product.discountPercent}%',
                titleSize: UISizes.font.sp10,
                titleColor: UIColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the product name text with ellipsis overflow.
  Widget _buildProductName() {
    return UIText(
      title: product.name,
      titleSize: UISizes.font.sp14,
      fontWeight: FontWeight.w600,
      titleColor: UIColors.gray700,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the price section with current price and optional old price.
  ///
  /// Uses [FittedBox] to prevent overflow on long prices or currency symbols.
  Widget _buildPriceSection() {
    return SizedBox(
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
    );
  }

  /// Builds the "Thêm vào giỏ hàng" (Add to Cart) button.
  Widget _buildAddToCartButton() {
    return GestureDetector(
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
    );
  }
}
