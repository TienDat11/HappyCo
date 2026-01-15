import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

/// CategoryBloc
///
/// Manages category page state
/// Fetches products by selected category
class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState> {
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  CategoryBloc({
    required this.getCategoryProductsUseCase,
  }) : super(CategoryInitial()) {
    on<OnCategoryInitialize>(_onInitialize);
    on<OnCategorySelect>(_onSelect);
    on<OnCategoryRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
    OnCategoryInitialize event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await _loadProducts(emit, 'dining_set');
  }

  Future<void> _onSelect(
    OnCategorySelect event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentProducts = (state as CategoryLoaded).products;
      emit(CategoryProductsLoading(
        selectedCategoryId: event.categoryId,
        products: currentProducts,
      ));
    } else {
      emit(CategoryLoading());
    }
    await _loadProducts(emit, event.categoryId);
  }

  Future<void> _onRefresh(
    OnCategoryRefresh event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentCategoryId = (state as CategoryLoaded).selectedCategoryId;
      await _loadProducts(emit, currentCategoryId);
    }
  }

  Future<void> _loadProducts(
      Emitter<CategoryState> emit, String categoryId) async {
    try {
      final products = await getCategoryProductsUseCase.exec(categoryId);
      emit(CategoryLoaded(
        selectedCategoryId: categoryId,
        products: products,
      ));
    } catch (e, stackTrace) {
      emitError(
        emit,
        CategoryError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }
}
