import 'package:happyco/domain/entities/news_entity.dart';

/// Extension methods for [NewsCategory] enum.
extension NewsCategoryExtension on NewsCategory {
  /// Vietnamese display name for the category.
  String get displayName {
    switch (this) {
      case NewsCategory.promotion:
        return 'Tin khuyến mãi & Sự kiện';
      case NewsCategory.newProduct:
        return 'Sản phẩm mới';
      case NewsCategory.knowledge:
        return 'Kiến thức ngành gỗ';
      case NewsCategory.guide:
        return 'Hướng dẫn sử dụng';
      case NewsCategory.qa:
        return 'Hỏi đáp về Happyco';
    }
  }
}
