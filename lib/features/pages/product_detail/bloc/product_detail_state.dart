part of 'product_detail_bloc.dart';

/// Product Detail States
sealed class ProductDetailState extends BaseBlocState {
  ProductDetailState();
}

/// Initial state
class ProductDetailInitial extends ProductDetailState implements InitialState {
  ProductDetailInitial();
}

/// Loading state
class ProductDetailLoading extends ProductDetailState implements LoadingState {
  ProductDetailLoading();
}

/// Loaded state with product detail and selection state
class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailEntity product;
  final Map<String, String> selectedAttributes;
  final int quantity;

  ProductDetailLoaded({
    required this.product,
    this.selectedAttributes = const {},
    this.quantity = 1,
  });

  /// Currently selected variant based on attributes
  ProductVariantEntity? get selectedVariant =>
      product.findVariant(selectedAttributes);

  /// Effective price based on selected variant or min price
  int get displayPrice => selectedVariant?.effectivePrice ?? product.minPrice;

  /// Listed price for strikethrough display
  int? get displayOldPrice {
    final variant = selectedVariant;
    if (variant != null && variant.hasDiscount) {
      return variant.priceListed;
    }
    return null;
  }

  /// Formatted display price for UI
  String get displayPriceFormatted => _formatCurrency(displayPrice);

  /// Formatted display old price for UI (with strikethrough)
  String? get displayOldPriceFormatted =>
      displayOldPrice != null ? _formatCurrency(displayOldPrice!) : null;

  String _formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$formatted\u20AB';
  }

  /// Current variant image or first gallery image
  String get displayImage {
    final variant = selectedVariant;
    if (variant != null && variant.imageUrl.isNotEmpty) {
      return variant.imageUrl;
    }
    return product.imageUrls.isNotEmpty ? product.imageUrls.first : '';
  }

  /// Whether all attribute groups have a selection
  bool get isFullySelected =>
      product.variantConfigs.isNotEmpty &&
      product.variantConfigs.every(
        (c) => selectedAttributes.containsKey(c.key),
      );

  /// Max quantity for the selected variant
  int get maxQuantity => selectedVariant?.quantity ?? product.quantity;

  ProductDetailLoaded copyWith({
    ProductDetailEntity? product,
    Map<String, String>? selectedAttributes,
    int? quantity,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Error state
class ProductDetailError extends ProductDetailState implements ErrorState {
  @override
  final String error;

  ProductDetailError({required this.error});
}
