/// Product Variant Entity
///
/// Domain layer entity representing a variant of a product (color, size, price).
class ProductVariantEntity {
  final String id;
  final String? colorName;
  final String? typeName;
  final int price;
  final int priceListed;
  final int priceSelling;
  final int quantity;
  final String sku;
  final String imageUrl;
  final String? barcode;

  const ProductVariantEntity({
    required this.id,
    this.colorName,
    this.typeName,
    required this.price,
    required this.priceListed,
    required this.priceSelling,
    required this.quantity,
    required this.sku,
    required this.imageUrl,
    this.barcode,
  });

  factory ProductVariantEntity.empty() => const ProductVariantEntity(
        id: '',
        price: 0,
        priceListed: 0,
        priceSelling: 0,
        quantity: 0,
        sku: '',
        imageUrl: '',
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariantEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
