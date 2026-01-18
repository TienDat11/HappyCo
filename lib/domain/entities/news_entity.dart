import 'package:happyco/domain/entities/product_entity.dart';

/// Categories for news articles in the Happyco app.
enum NewsCategory {
  /// Promotional events and special offers.
  promotion,

  /// New furniture product announcements.
  newProduct,

  /// Industry knowledge and wood-related information.
  knowledge,

  /// User guides and assembly instructions.
  guide,

  /// Frequently asked questions about Happyco.
  qa,
}

/// Represents a news article, guide, or Q&A item.
///
/// Based on Figma design node-id=1:2452.
class NewsEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishDate;
  final NewsCategory category;
  final bool isFeatured;
  final String? videoUrl;
  final List<ProductEntity>? relatedProducts;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
    required this.category,
    this.isFeatured = false,
    this.videoUrl,
    this.relatedProducts,
  });

  /// Factory for empty state or loading placeholders
  factory NewsEntity.empty() => NewsEntity(
        id: '',
        title: '',
        description: '',
        imageUrl: '',
        publishDate: '',
        category: NewsCategory.promotion,
      );

  /// Helper to get category display name in Vietnamese
  String get categoryName {
    switch (category) {
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
