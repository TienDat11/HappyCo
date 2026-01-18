import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/extensions/news_category_extension.dart';

/// A horizontal scrollable filter bar for news categories.
///
/// Displays 5 tabs matching Figma design node-id=1:2453.
/// Active tab has a red background and border, while inactive tabs
/// have a white background and gray border.
class FilterTabs extends StatelessWidget {
  /// The currently selected category.
  final NewsCategory selectedCategory;

  /// Callback when a category is selected.
  final ValueChanged<NewsCategory> onCategorySelected;

  const FilterTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w12),
      child: Row(
        children: NewsCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: EdgeInsets.only(right: UISizes.width.w12),
            child: _FilterTabItem(
              category: category,
              isSelected: isSelected,
              onTap: () => onCategorySelected(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterTabItem extends StatelessWidget {
  final NewsCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTabItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: UISizes.width.w12,
          vertical: UISizes.height.h8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? UIColors.red50 : UIColors.white,
          borderRadius: BorderRadius.circular(UISizes.square.r12),
          border: Border.all(
            color: isSelected ? UIColors.primary : UIColors.gray100,
            width: 1.0,
          ),
        ),
        child: UIText(
          title: category.displayName,
          titleSize: UISizes.font.sp14,
          titleColor: isSelected ? UIColors.primary : UIColors.gray700,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
