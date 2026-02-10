import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/entities/product_variant_entity.dart';
import 'package:happyco/domain/entities/variant_config_entity.dart';

/// Product Detail Entity
///
/// Domain layer entity for the full product detail page.
/// Extends beyond [ProductEntity] (list-level) with:
/// - Dynamic variant system ([variantConfigs] + [variants])
/// - Gallery images, video link
/// - Related products, category name
/// - Warehouse status, unit
class ProductDetailEntity {
  final String id;
  final String name;
  final String? description;
  final String? categoryId;
  final String? categoryName;
  final int quantity;
  final int soldQuantity;
  final String code;
  final String unit;
  final String? linkVideo;
  final bool hot;
  final String statusWarehouse;
  final List<String> imageUrls;
  final List<ProductVariantEntity> variants;
  final List<VariantConfigEntity> variantConfigs;
  final List<ProductEntity> relatedProducts;

  const ProductDetailEntity({
    required this.id,
    required this.name,
    this.description,
    this.categoryId,
    this.categoryName,
    required this.quantity,
    required this.soldQuantity,
    required this.code,
    required this.unit,
    this.linkVideo,
    required this.hot,
    required this.statusWarehouse,
    required this.imageUrls,
    required this.variants,
    required this.variantConfigs,
    required this.relatedProducts,
  });

  factory ProductDetailEntity.empty() => const ProductDetailEntity(
        id: '',
        name: '',
        description: null,
        quantity: 0,
        soldQuantity: 0,
        code: '',
        unit: '',
        hot: false,
        statusWarehouse: '',
        imageUrls: [],
        variants: [],
        variantConfigs: [],
        relatedProducts: [],
      );

  /// Min selling price across all variants
  int get minPrice {
    if (variants.isEmpty) return 0;
    return variants
        .map((v) => v.effectivePrice)
        .reduce((a, b) => a < b ? a : b);
  }

  /// Max selling price across all variants
  int get maxPrice {
    if (variants.isEmpty) return 0;
    return variants
        .map((v) => v.effectivePrice)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Whether the product has a price range (multiple different prices)
  bool get hasPriceRange => minPrice != maxPrice;

  /// Extract unique attribute values for a given config key
  List<String> uniqueValuesForKey(String key) {
    return variants
        .map((v) => v.attributes[key])
        .whereType<String>()
        .where((v) => v.isNotEmpty)
        .toSet()
        .toList();
  }

  /// Find variant matching selected attributes
  ProductVariantEntity? findVariant(Map<String, String> selectedAttributes) {
    if (selectedAttributes.isEmpty) return null;
    for (final variant in variants) {
      final allMatch = selectedAttributes.entries.every(
        (e) => variant.attributes[e.key] == e.value,
      );
      if (allMatch) return variant;
    }
    return null;
  }

  /// Formatted min price for display
  String get formattedMinPrice => _formatCurrency(minPrice);

  /// Formatted max price for display
  String get formattedMaxPrice => _formatCurrency(maxPrice);

  /// Formatted price display (range or single)
  String get formattedPriceDisplay => hasPriceRange
      ? '$formattedMinPrice - $formattedMaxPrice'
      : formattedMinPrice;

  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted\u20AB';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductDetailEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
