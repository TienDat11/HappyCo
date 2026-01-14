/// Product Entity
///
/// Domain layer entity representing a product.
/// This is a plain Dart class - no freezed for domain entities.
class ProductEntity {
  final String id;
  final String name;
  final int priceInVnd;
  final int? oldPriceInVnd;
  final String imageUrl;
  final String? category;
  final bool isFeatured;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.priceInVnd,
    this.oldPriceInVnd,
    required this.imageUrl,
    this.category,
    this.isFeatured = false,
  });

  /// Creates empty product placeholder
  factory ProductEntity.empty() => const ProductEntity(
        id: '',
        name: '',
        priceInVnd: 0,
        imageUrl: '',
      );

  /// Formatted price for display
  String get formattedPrice => _formatCurrency(priceInVnd);

  /// Formatted old price for display
  String? get formattedOldPrice =>
      oldPriceInVnd != null ? _formatCurrency(oldPriceInVnd!) : null;

  /// Check if product has discount
  bool get hasDiscount => oldPriceInVnd != null && oldPriceInVnd! > priceInVnd;

  /// Discount percentage
  int? get discountPercent {
    if (!hasDiscount) return null;
    return (((oldPriceInVnd! - priceInVnd) / oldPriceInVnd!) * 100).round();
  }

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
    return other is ProductEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
