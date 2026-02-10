import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/data/models/category_dto.dart';
import 'package:happyco/domain/entities/category_entity.dart';

/// Category Mapper
///
/// Handles conversion between DTOs (data layer) and entities (domain layer).
extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      imageUrl: _formatImageUrl(image, AppConfig.instance.imageBaseUrl),
      productCount: productNumber ?? 0,
    );
  }

  String _formatImageUrl(String? path, String baseUrl) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }
}

extension CategoryListMapper on CategoryListResponse {
  List<CategoryEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
