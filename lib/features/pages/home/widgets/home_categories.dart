import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';

/// Home Category Item Model
class HomeCategoryItem {
  final String imageUrl;
  final String label;
  final VoidCallback? onTap;

  const HomeCategoryItem({
    required this.imageUrl,
    required this.label,
    this.onTap,
  });
}

/// Home Categories Widget
///
/// Horizontal scrollable list of category images with labels
/// Displays 8 furniture categories wrapped in a card
class HomeCategories extends StatelessWidget {

  static final _defaultCategories = [
    const HomeCategoryItem(
      imageUrl: UIImages.categoryDiningSet,
      label: 'Bộ bàn ăn',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryDiningChair,
      label: 'Ghế ăn',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categorySofa,
      label: 'Sofa gỗ',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryShoeCabinet,
      label: 'Tủ giày',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryVanityTable,
      label: 'Bàn trang điểm',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryAltar,
      label: 'Tủ thờ',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryDisplayShelf,
      label: 'Kệ trang trí',
    ),
    const HomeCategoryItem(
      imageUrl: UIImages.categoryKitchenCabinet,
      label: 'Tủ bếp',
    ),
  ];

  final List<HomeCategoryItem> categories;
  final bool isLoading;

  HomeCategories({
    super.key,
    List<HomeCategoryItem>? categories,
    this.isLoading = false,
  }) : categories = categories ?? _defaultCategories;

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r12,
      hasShadow: true,
      padding: EdgeInsets.all(UISizes.width.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal category list
          SizedBox(
            height: UISizes.height.h100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 6 : categories.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return _buildShimmerItem();
                }
                final category = categories[index];
                return _buildCategoryItem(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds individual category item with image and label
  Widget _buildCategoryItem(HomeCategoryItem category) {
    return GestureDetector(
      onTap: category.onTap,
      child: Container(
        margin: EdgeInsets.only(right: UISizes.width.w12),
        child: Column(
          children: [
            // Category image container
            Container(
              width: UISizes.width.w52,
              height: UISizes.width.w52,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(UISizes.square.r8),
                child: Image.asset(
                  category.imageUrl,
                  width: UISizes.width.w52,
                  height: UISizes.width.w52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: UISizes.width.w52,
                      height: UISizes.width.w52,
                      color: UIColors.gray100,
                      child: Icon(
                        Icons.image_outlined,
                        size: UISizes.width.w24,
                        color: UIColors.gray400,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: UISizes.height.h4),
            // Category label
            UIText(
              title: category.label,
              titleSize: UISizes.font.sp10,
              titleColor: UIColors.categoryLabel,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds shimmer placeholder for category item
  Widget _buildShimmerItem() {
    return Container(
      margin: EdgeInsets.only(right: UISizes.width.w12),
      child: Column(
        children: [
          HappyShimmer.rounded(
            width: UISizes.width.w52,
            height: UISizes.width.w52,
            borderRadius: UISizes.square.r8,
          ),
          SizedBox(height: UISizes.height.h8),
          HappyShimmer.rounded(
            width: UISizes.width.w40,
            height: UISizes.height.h12,
          ),
        ],
      ),
    );
  }
}
