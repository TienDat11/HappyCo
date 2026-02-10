import 'package:flutter/foundation.dart';

/// Product Variant Entity
///
/// Represents a purchasable variant of a product.
/// Each variant has dynamic attributes (color, size, brand, etc.),
/// its own price, stock quantity, and image.
///
/// The [attributes] map keys come from the product's [configProductColors]
/// (e.g. "mau_sac" → "Bạc Trắng", "phan_loai" → "A - Thẳng").
class ProductVariantEntity {
  final String id;
  final int price;
  final int priceListed;
  final int priceSelling;
  final int quantity;
  final String imageUrl;
  final bool status;
  final String barcode;
  final Map<String, String> attributes;

  const ProductVariantEntity({
    required this.id,
    required this.price,
    required this.priceListed,
    required this.priceSelling,
    required this.quantity,
    required this.imageUrl,
    required this.status,
    required this.barcode,
    required this.attributes,
  });

  factory ProductVariantEntity.empty() => const ProductVariantEntity(
        id: '',
        price: 0,
        priceListed: 0,
        priceSelling: 0,
        quantity: 0,
        imageUrl: '',
        status: true,
        barcode: '',
        attributes: {},
      );

  /// The effective selling price
  int get effectivePrice => priceSelling > 0 ? priceSelling : price;

  /// Whether this variant has a discount
  bool get hasDiscount => priceListed > effectivePrice;

  /// Discount percentage
  int? get discountPercent {
    if (!hasDiscount) return null;
    return (((priceListed - effectivePrice) / priceListed) * 100).round();
  }

  /// Whether this variant is in stock
  bool get isInStock => quantity > 0 && status;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariantEntity &&
        other.id == id &&
        mapEquals(other.attributes, attributes);
  }

  @override
  int get hashCode => id.hashCode;
}
