import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/section_title.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/products/widgets/product_card.dart';

/// A section widget displaying a category with its products.
///
/// Shows a decorative header with the category name, a grid of products,
/// and a "See More/Show Less" toggle button.
///
/// **Features:**
/// - Decorative section header using [SectionTitle]
/// - 2-column product grid with consistent spacing
/// - Collapsed: Shows only 2 products
/// - Expanded: Shows all products
/// - Toggle button with product count
///
/// **Used in:**
/// - [CategoryPage]: Main category listing screen
///
/// **Example:**
/// ```dart
/// CategorySection(
///   category: category,
///   products: products,
///   isExpanded: false,
///   onToggle: () => toggleCategory(category.id),
/// )
/// ```
class CategorySection extends StatelessWidget {
  /// The category entity to display.
  final CategoryEntity category;

  /// List of products in this category.
  final List<ProductEntity> products;

  /// Whether this section is expanded to show all products.
  final bool isExpanded;

  /// Callback when the "See More/Show Less" button is tapped.
  final VoidCallback onToggle;

  /// Callback when a product card is tapped.
  final void Function(ProductEntity product)? onProductTap;

  /// Callback when "Add to Cart" button is tapped on a product.
  final void Function(ProductEntity product)? onAddToCart;

  /// Whether to show skeleton loading state.
  final bool isLoading;

  /// Number of products to show when collapsed.
  static const int _collapsedProductCount = 2;

  const CategorySection({
    super.key,
    required this.category,
    required this.products,
    required this.isExpanded,
    required this.onToggle,
    this.onProductTap,
    this.onAddToCart,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Skip rendering if no products
    if (products.isEmpty && !isLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: UISizes.height.h16),
        _buildHeader(),
        SizedBox(height: UISizes.height.h14),
        _buildProductGrid(),
        if (_shouldShowToggleButton) ...[
          SizedBox(height: UISizes.height.h14),
          _buildToggleButton(),
        ],
        SizedBox(height: UISizes.height.h8),
      ],
    );
  }

  /// Builds the decorative category header.
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: SectionTitle(title: category.name),
    );
  }

  /// Builds the product grid showing 2 or all products.
  Widget _buildProductGrid() {
    final displayProducts =
        isExpanded ? products : products.take(_collapsedProductCount).toList();

    return Padding(
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
        itemCount: isLoading ? _collapsedProductCount : displayProducts.length,
        itemBuilder: (context, index) => isLoading
            ? ProductCard(
                product: ProductEntity.empty(),
                isLoading: true,
              )
            : ProductCard(
                product: displayProducts[index],
                onTap: onProductTap != null
                    ? () => onProductTap!(displayProducts[index])
                    : null,
                onAddToCart: onAddToCart != null
                    ? () => onAddToCart!(displayProducts[index])
                    : null,
              ),
      ),
    );
  }

  /// Whether to show the toggle button.
  bool get _shouldShowToggleButton =>
      products.length > _collapsedProductCount && !isLoading;

  /// Number of additional products when collapsed.
  int get _remainingProductCount => products.length - _collapsedProductCount;

  /// Builds the "See More/Show Less" toggle button.
  Widget _buildToggleButton() {
    final buttonText =
        isExpanded ? 'Rút gọn' : 'Xem thêm $_remainingProductCount sản phẩm';

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: UISizes.width.w161,
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
            title: buttonText,
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
