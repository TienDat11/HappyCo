import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/data/models/product_dto.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Product Mapper
///
/// Handles conversion between DTOs (data layer) and entities (domain layer).

extension ProductMapper on ProductDto {
  ProductEntity toEntity() {
    int minPrice = 0;
    int? oldPrice;

    if (productColors?.isNotEmpty == true) {
      for (final color in productColors!) {
        final sellingPrice = color.priceSelling ?? color.price;
        if (sellingPrice < minPrice || minPrice == 0) {
          minPrice = sellingPrice;
          final listedPrice = color.priceListed;
          oldPrice = (listedPrice != null && listedPrice > sellingPrice)
              ? listedPrice
              : null;
        }
      }
    }

    final firstColor =
        productColors?.isNotEmpty == true ? productColors!.first : null;

    // Get image: prefer first listImage, fallback to first productColor image
    String imageUrl = '';
    if (listImage?.isNotEmpty == true) {
      imageUrl = _formatImageUrl(
          listImage!.first.url, AppConfig.instance.imageBaseUrl);
    } else if (firstColor?.image != null) {
      imageUrl =
          _formatImageUrl(firstColor!.image!, AppConfig.instance.imageBaseUrl);
    }

    return ProductEntity(
      id: id,
      name: name,
      priceInVnd: minPrice,
      oldPriceInVnd: oldPrice,
      imageUrl: imageUrl,
      category: category,
      isFeatured: hot ?? false,
    );
  }

  String _formatImageUrl(String path, String baseUrl) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }
}

extension PaginatedProductMapper on PaginatedProductDto {
  List<ProductEntity> toEntityList({required String baseUrl}) {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
