import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/domain/entities/category_entity.dart';

/// Home Categories Widget
///
/// Horizontal scrollable list of category images with labels.
/// Fetches categories from API. First tab is "Tất cả".
/// Selection indicator: 2px primary border + tint background + bold label.
class HomeCategories extends StatelessWidget {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? selectedCategoryId;
  final ValueChanged<String?>? onCategoryTap;

  const HomeCategories({
    super.key,
    this.categories = const [],
    this.isLoading = false,
    this.selectedCategoryId,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r12,
      hasShadow: true,
      padding: EdgeInsets.all(UISizes.width.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: UISizes.height.h100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 6 : categories.length + 1,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return _buildShimmerItem();
                }
                // First item is "Tất cả"
                if (index == 0) {
                  return _buildAllTab();
                }
                final category = categories[index - 1];
                return _buildCategoryItem(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the "Tất cả" tab — first item
  Widget _buildAllTab() {
    final isSelected = selectedCategoryId == null;

    return GestureDetector(
      onTap: () => onCategoryTap?.call(null),
      child: Container(
        margin: EdgeInsets.only(right: UISizes.width.w12),
        width: UISizes.width.w64,
        child: Column(
          children: [
            Container(
              width: UISizes.width.w52,
              height: UISizes.width.w52,
              decoration: BoxDecoration(
                color: isSelected
                    ? UIColors.primary.withValues(alpha: 0.08)
                    : UIColors.white,
                borderRadius: BorderRadius.circular(UISizes.square.r8),
                boxShadow: [
                  BoxShadow(
                    color: UIColors.cardShadow,
                    blurRadius:
                        isSelected ? UISizes.square.r8 : UISizes.square.r4,
                    offset: const Offset(0, 0),
                  ),
                ],
                border: isSelected
                    ? Border.all(color: UIColors.primary, width: 2.0)
                    : null,
              ),
              child: Center(
                child: Icon(
                  Icons.grid_view_rounded,
                  size: UISizes.width.w24,
                  color: isSelected ? UIColors.primary : UIColors.gray400,
                ),
              ),
            ),
            SizedBox(height: UISizes.height.h4),
            UIText(
              title: 'Tất cả',
              titleSize: UISizes.font.sp10,
              titleColor: isSelected ? UIColors.primary : UIColors.gray600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds individual category item with network image and label
  Widget _buildCategoryItem(CategoryEntity category) {
    final isSelected = selectedCategoryId == category.id;

    return GestureDetector(
      onTap: () => onCategoryTap?.call(category.id),
      child: Container(
        margin: EdgeInsets.only(right: UISizes.width.w12),
        width: UISizes.width.w64,
        child: Column(
          children: [
            Container(
              width: UISizes.width.w52,
              height: UISizes.width.w52,
              decoration: BoxDecoration(
                color: isSelected
                    ? UIColors.primary.withValues(alpha: 0.08)
                    : UIColors.white,
                borderRadius: BorderRadius.circular(UISizes.square.r8),
                boxShadow: [
                  BoxShadow(
                    color: UIColors.cardShadow,
                    blurRadius:
                        isSelected ? UISizes.square.r8 : UISizes.square.r4,
                    offset: const Offset(0, 0),
                  ),
                ],
                border: isSelected
                    ? Border.all(color: UIColors.primary, width: 2.0)
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(UISizes.square.r8),
                child:
                    category.imageUrl != null && category.imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: category.imageUrl!,
                            width: UISizes.width.w52,
                            height: UISizes.width.w52,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => HappyShimmer.rounded(
                              width: UISizes.width.w52,
                              height: UISizes.width.w52,
                              borderRadius: UISizes.square.r8,
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: UISizes.width.w52,
                              height: UISizes.width.w52,
                              color: UIColors.gray100,
                              child: Icon(
                                Icons.image_outlined,
                                size: UISizes.width.w24,
                                color: UIColors.gray400,
                              ),
                            ),
                          )
                        : Container(
                            width: UISizes.width.w52,
                            height: UISizes.width.w52,
                            color: UIColors.gray100,
                            child: Icon(
                              Icons.image_outlined,
                              size: UISizes.width.w24,
                              color: UIColors.gray400,
                            ),
                          ),
              ),
            ),
            SizedBox(height: UISizes.height.h4),
            UIText(
              title: category.name,
              titleSize: UISizes.font.sp10,
              titleColor: isSelected ? UIColors.primary : UIColors.gray600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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
