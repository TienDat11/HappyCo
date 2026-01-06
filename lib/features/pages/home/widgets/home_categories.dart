import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Home Category Item Model
class HomeCategoryItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const HomeCategoryItem({
    required this.icon,
    required this.label,
    this.onTap,
  });
}

/// Home Categories Widget
///
/// Horizontal scrollable list of category icons with labels
/// Displays 8 furniture categories
class HomeCategories extends StatelessWidget {
  final List<HomeCategoryItem> categories;

  static final _defaultCategories = [
    const HomeCategoryItem(
      icon: Icons.table_restaurant,
      label: 'Bộ bàn ăn',
    ),
    const HomeCategoryItem(
      icon: Icons.chair,
      label: 'Ghế ăn',
    ),
    const HomeCategoryItem(
      icon: Icons.weekend,
      label: 'Sofa gỗ',
    ),
    const HomeCategoryItem(
      icon: Icons.bed,
      label: 'Giường ngủ',
    ),
    const HomeCategoryItem(
      icon: Icons.book,
      label: 'Kệ sách',
    ),
    const HomeCategoryItem(
      icon: Icons.door_sliding,
      label: 'Tủ áo',
    ),
    const HomeCategoryItem(
      icon: Icons.work,
      label: 'Bàn làm việc',
    ),
    const HomeCategoryItem(
      icon: Icons.more_horiz,
      label: 'Xem thêm',
    ),
  ];

  HomeCategories({
    super.key,
    List<HomeCategoryItem>? categories,
  }) : categories = categories ?? _defaultCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.only(left: UISizes.width.w16),
          child: UIText(
            title: 'Danh mục',
            titleSize: UISizes.font.sp18,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.gray900,
          ),
        ),
        SizedBox(height: UISizes.height.h16),
        // Horizontal category list
        SizedBox(
          height: UISizes.height.h100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryItem(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(HomeCategoryItem category) {
    return GestureDetector(
      onTap: category.onTap,
      child: Container(
        width: UISizes.width.w70,
        margin: EdgeInsets.only(right: UISizes.width.w16),
        child: Column(
          children: [
            // Category icon container
            Container(
              width: UISizes.width.w56,
              height: UISizes.width.w56,
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(UISizes.square.r8),
                border: Border.all(
                  color: UIColors.gray200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: UIColors.cardShadow,
                    blurRadius: UISizes.square.r8,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Icon(
                category.icon,
                size: UISizes.width.w28,
                color: UIColors.primary,
              ),
            ),
            SizedBox(height: UISizes.height.h8),
            // Category label
            UIText(
              title: category.label,
              titleSize: UISizes.font.sp12,
              titleColor: UIColors.gray700,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
