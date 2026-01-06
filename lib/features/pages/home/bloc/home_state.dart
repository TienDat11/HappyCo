part of 'home_bloc.dart';

/// Home States
sealed class HomeState extends BaseBlocState {
  HomeState();
}

/// Initial state before data is loaded
class HomeInitial extends HomeState implements InitialState {
  HomeInitial();
}

/// Loading state while fetching data
class HomeLoading extends HomeState implements LoadingState {
  HomeLoading();
}

/// Loaded state with product data
class HomeLoaded extends HomeState {
  final List<ProductEntity> featuredProducts;
  final List<ProductEntity> recommendedProducts;

  HomeLoaded({
    required this.featuredProducts,
    required this.recommendedProducts,
  });
}

/// Error state when data fetch fails
class HomeError extends HomeState implements ErrorState {
  @override
  final String error;

  HomeError({required this.error});
}
