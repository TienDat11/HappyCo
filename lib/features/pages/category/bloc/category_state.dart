part of 'category_bloc.dart';

/// Category States
sealed class CategoryState extends BaseBlocState {}

/// Initial state before data is loaded
class CategoryInitial extends CategoryState implements InitialState {}

/// Loading state while fetching products (only initial load)
class CategoryLoading extends CategoryState implements LoadingState {}

/// Loaded state with products
class CategoryLoaded extends CategoryState {
  final String selectedCategoryId;
  final List<ProductEntity> products;

  CategoryLoaded({
    required this.selectedCategoryId,
    required this.products,
  });
}

/// Loading products for selected category (keep UI visible)
class CategoryProductsLoading extends CategoryState {
  final String selectedCategoryId;
  final List<ProductEntity> products;

  CategoryProductsLoading({
    required this.selectedCategoryId,
    required this.products,
  });
}

/// Error state when data fetch fails
class CategoryError extends CategoryState implements ErrorState {
  @override
  final String error;

  CategoryError({required this.error});
}
