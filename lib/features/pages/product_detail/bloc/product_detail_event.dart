part of 'product_detail_bloc.dart';

/// Product Detail Events
sealed class ProductDetailEvent extends BaseEvent {}

/// Initialize — load product detail by ID
class OnProductDetailInit extends ProductDetailEvent {
  final String productId;

  OnProductDetailInit({required this.productId});
}

/// User selected a variant attribute (e.g. color, size)
class OnVariantAttributeSelected extends ProductDetailEvent {
  final String key;
  final String value;

  OnVariantAttributeSelected({required this.key, required this.value});
}

/// User changed quantity
class OnQuantityChanged extends ProductDetailEvent {
  final int quantity;

  OnQuantityChanged({required this.quantity});
}
