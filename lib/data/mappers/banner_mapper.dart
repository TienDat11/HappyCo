import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/data/models/banner_dto.dart';
import 'package:happyco/domain/entities/banner_entity.dart';

/// Banner Mapper
///
/// Handles conversion between DTOs (data layer) and entities (domain layer).
extension BannerMapper on BannerDto {
  BannerEntity toEntity() {
    return BannerEntity(
      id: id,
      title: title,
      imageUrl: _formatImageUrl(image, AppConfig.instance.imageBaseUrl),
      actionUrl: actionUrl,
    );
  }

  String _formatImageUrl(String path, String baseUrl) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }
}

extension BannerListMapper on BannerListResponse {
  List<BannerEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
