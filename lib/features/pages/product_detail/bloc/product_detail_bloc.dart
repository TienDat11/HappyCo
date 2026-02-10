import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/product_variant_entity.dart';
import 'package:happyco/domain/usecases/get_product_detail_usecase.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

/// ProductDetailBloc
///
/// Manages state for the Product Detail page.
/// Handles loading product detail, variant selection, and quantity changes.
class ProductDetailBloc
    extends BaseBloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailBloc({
    required this.getProductDetailUseCase,
  }) : super(ProductDetailInitial()) {
    on<OnProductDetailInit>(_onInit);
    on<OnVariantAttributeSelected>(_onVariantSelected);
    on<OnQuantityChanged>(_onQuantityChanged);
  }

  Future<void> _onInit(
    OnProductDetailInit event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final product = await getProductDetailUseCase.exec(event.productId);

      // Auto-select first value for each config if only one option exists
      final autoSelected = <String, String>{};
      for (final config in product.variantConfigs) {
        final values = product.uniqueValuesForKey(config.key);
        if (values.length == 1) {
          autoSelected[config.key] = values.first;
        }
      }

      emit(ProductDetailLoaded(
        product: product,
        selectedAttributes: autoSelected,
      ));
    } catch (e, stackTrace) {
      emitError(
        emit,
        ProductDetailError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  Future<void> _onVariantSelected(
    OnVariantAttributeSelected event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductDetailLoaded) return;

    final newAttributes = Map<String, String>.from(
      currentState.selectedAttributes,
    );
    newAttributes[event.key] = event.value;

    emit(currentState.copyWith(
      selectedAttributes: newAttributes,
      quantity: 1,
    ));
  }

  Future<void> _onQuantityChanged(
    OnQuantityChanged event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductDetailLoaded) return;

    final clampedQty = event.quantity.clamp(1, currentState.maxQuantity);
    emit(currentState.copyWith(quantity: clampedQty));
  }
}
