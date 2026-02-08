import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/section_title.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/products/widgets/product_card.dart';

/// A reusable product grid widget that displays items in a 2-column layout.
///
/// This widget is shared across multiple screens to maintain consistent
/// product display throughout the app. It handles loading states, empty
/// states, and product interactions.
///
/// **Used in:**
/// - [HomePage]: Displays "Sản phẩm nổi bật" and "Gợi ý hôm nay" sections
/// - [CategoryPage]: Shows category-filtered products
///
/// **Features:**
/// - 2-column grid layout with 0.665 aspect ratio (matches Figma design)
/// - Optional decorative section title with dashed lines
/// - Skeleton loading state with shimmer effect
/// - "Xem tất cả" action button
/// - Product tap and add-to-cart callbacks
///
/// **Example:**
/// ```dart
/// ProductGrid(
///   title: 'Sản phẩm nổi bật',
///   actionText: 'Xem tất cả',
///   products: featuredProducts,
///   onProductTap: (product) => navigateToDetail(product),
///   onAddToCart: (product) => addToCart(product),
/// )
/// ```
///
/// **Example (Loading State):**
/// ```dart
/// ProductGrid(
///   title: 'Loading products',
///   isLoading: true,
///   products: [],
/// )
/// ```
///
/// **Example (No Title):**
/// ```dart
/// // Used in CategoryPage where title is shown separately
/// ProductGrid(
///   title: '',  // No decorative title
///   products: categoryProducts,
/// )
/// ```
class ProductGrid extends StatelessWidget {
  /// Section title displayed with decorative dashed lines.
  ///
  /// If empty string, the decorative title will be hidden.
  /// Used in [CategoryPage] where category name is shown separately.
  final String title;

  /// Optional action button text (e.g., "Xem tất cả").
  ///
  /// If provided, displays a button below the grid.
  /// If null, button will be hidden.
  final String? actionText;

  /// Callback when action button is tapped.
  ///
  /// Only triggered when [actionText] is not null.
  final VoidCallback? onActionTap;

  /// List of products to display in the grid.
  ///
  /// When [isLoading] is true, this list is ignored and
  /// 4 skeleton cards are shown instead.
  final List<ProductEntity> products;

  /// Callback when a product card is tapped.
  ///
  /// Typically used to navigate to product detail page.
  /// Receives the tapped [ProductEntity] as parameter.
  final void Function(ProductEntity product)? onProductTap;

  /// Callback when "Thêm vào giỏ hàng" button is tapped.
  ///
  /// Receives the selected [ProductEntity] as parameter.
  final void Function(ProductEntity product)? onAddToCart;

  /// Whether to show skeleton loading state.
  ///
  /// When true:
  /// - Displays 4 shimmer skeleton cards
  /// - Ignores [products] list
  /// - Hides action button
  final bool isLoading;

  const ProductGrid({
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
        if (title.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            child: SectionTitle(title: title),
          ),
          SizedBox(height: UISizes.height.h14),
        ],
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
              childAspectRatio: 0.665,
            ),
            itemCount: isLoading ? 4 : products.length,
            itemBuilder: (context, index) => isLoading
                ? ProductCard(
                    product: ProductEntity.empty(),
                    isLoading: true,
                  )
                : ProductCard(
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
