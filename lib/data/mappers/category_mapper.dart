import 'package:happyco/data/models/category_dto.dart';
import 'package:happyco/domain/entities/category_entity.dart';

/// Category Mapper
///
/// Handles conversion between DTOs (data layer) and entities (domain layer).
extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity({required String baseUrl}) {
    return CategoryEntity(
      id: id,
      name: name,
      imageUrl: _formatImageUrl(image, baseUrl),
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
  List<CategoryEntity> toEntityList({required String baseUrl}) {
    return data.map((dto) => dto.toEntity(baseUrl: baseUrl)).toList();
  }
}
