import 'package:happyco/core/config/app_config.dart';
import 'package:happyco/data/models/product_detail_dto.dart';
import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/entities/product_variant_entity.dart';
import 'package:happyco/domain/entities/variant_config_entity.dart';

/// Product Detail Mapper
///
/// Converts [ProductDetailDto] → [ProductDetailEntity].
extension ProductDetailMapper on ProductDetailDto {
  ProductDetailEntity toDetailEntity() {
    final imageBaseUrl = AppConfig.instance.imageBaseUrl;

    // Map gallery images
    final images = listImage
            ?.map((img) => _formatImageUrl(img.url, imageBaseUrl))
            .where((url) => url.isNotEmpty)
            .toList() ??
        [];

    // Map variant configs
    final configs = configProductColors
            ?.where((c) => c.enabled != false)
            .map((c) => VariantConfigEntity(key: c.key, label: c.label))
            .toList() ??
        [];

    // Map variants
    final variantList = productColors
            ?.map((color) => ProductVariantEntity(
                  id: color.id,
                  price: color.price,
                  priceListed: color.priceListed ?? color.price,
                  priceSelling: color.priceSelling ?? color.price,
                  quantity: color.quantity ?? 0,
                  imageUrl: _formatImageUrl(
                    color.image ?? '',
                    imageBaseUrl,
                  ),
                  status: color.status ?? true,
                  barcode: color.barcode ?? '',
                  attributes: _parseAttributes(color.value),
                ))
            .toList() ??
        [];

    // Map related products
    final related = productRelates
            ?.map((r) => _relateToProductEntity(r, imageBaseUrl))
            .toList() ??
        [];

    return ProductDetailEntity(
      id: id,
      name: name,
      description: description,
      categoryId: categoryRef?.id,
      categoryName: categoryRef?.name,
      quantity: quantity ?? 0,
      soldQuantity: soldQuantity ?? 0,
      code: code ?? '',
      unit: unit ?? '',
      linkVideo: linkVideo,
      hot: hot ?? false,
      statusWarehouse: statusWarehouse ?? '',
      imageUrls: images,
      variants: variantList,
      variantConfigs: configs,
      relatedProducts: related,
    );
  }

  /// Parse dynamic value map to String-only map
  Map<String, String> _parseAttributes(Map<String, dynamic>? value) {
    if (value == null || value.isEmpty) return {};
    return value.map((k, v) => MapEntry(k, v?.toString() ?? ''));
  }

  /// Convert related product DTO to list-level ProductEntity
  ProductEntity _relateToProductEntity(
    ProductRelateDto relate,
    String imageBaseUrl,
  ) {
    int minPrice = 0;
    int? oldPrice;

    if (relate.productColors?.isNotEmpty == true) {
      for (final color in relate.productColors!) {
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

    String imageUrl = '';
    if (relate.listImage?.isNotEmpty == true) {
      imageUrl = _formatImageUrl(relate.listImage!.first.url, imageBaseUrl);
    } else if (relate.productColors?.isNotEmpty == true &&
        relate.productColors!.first.image != null) {
      imageUrl = _formatImageUrl(
        relate.productColors!.first.image!,
        imageBaseUrl,
      );
    }

    return ProductEntity(
      id: relate.id,
      name: relate.name,
      priceInVnd: minPrice,
      oldPriceInVnd: oldPrice,
      imageUrl: imageUrl,
      category: relate.categoryRef?.name,
      isFeatured: relate.hot ?? false,
    );
  }

  String _formatImageUrl(String path, String baseUrl) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }
}
