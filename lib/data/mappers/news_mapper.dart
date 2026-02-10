import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/data/models/news_dto.dart';
import 'package:happyco/domain/entities/news_entity.dart';

extension NewsMapper on NewsDto {
  NewsEntity toEntity() {
    final imageBaseUrl = AppConfig.instance.imageBaseUrl;

    return NewsEntity(
      id: id,
      title: title,
      description: content ?? '',
      imageUrl: _formatImageUrl(image, imageBaseUrl),
      publishDate: createdAt ?? '',
      category: NewsCategory.promotion,
      isFeatured: isHighlight ?? false,
    );
  }

  String _formatImageUrl(String? path, String baseUrl) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }
}

extension NewsListMapper on NewsListResponse {
  List<NewsEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
