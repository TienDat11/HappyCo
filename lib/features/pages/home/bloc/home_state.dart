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

/// Loaded state with product, category, and banner data
class HomeLoaded extends HomeState {
  final List<ProductEntity> featuredProducts;
  final List<CategoryEntity> categories;
  final List<BannerEntity> banners;
  final List<ProductEntity> filteredProducts;
  final String? selectedCategoryId;
  final String searchQuery;
  final bool isSearching;
  final List<ProductEntity> allProducts;
  final bool isShowingAll;

  HomeLoaded({
    required this.featuredProducts,
    this.categories = const [],
    this.banners = const [],
    this.filteredProducts = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
    this.isSearching = false,
    this.allProducts = const [],
    this.isShowingAll = false,
  });

  /// Returns the products to display — all products, filtered results, or featured
  List<ProductEntity> get displayProducts => isShowingAll
      ? allProducts
      : isSearching || selectedCategoryId != null
          ? filteredProducts
          : featuredProducts;

  HomeLoaded copyWith({
    List<ProductEntity>? featuredProducts,
    List<CategoryEntity>? categories,
    List<BannerEntity>? banners,
    List<ProductEntity>? filteredProducts,
    String? Function()? selectedCategoryId,
    String? searchQuery,
    bool? isSearching,
    List<ProductEntity>? allProducts,
    bool? isShowingAll,
  }) {
    return HomeLoaded(
      featuredProducts: featuredProducts ?? this.featuredProducts,
      categories: categories ?? this.categories,
      banners: banners ?? this.banners,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategoryId: selectedCategoryId != null
          ? selectedCategoryId()
          : this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      allProducts: allProducts ?? this.allProducts,
      isShowingAll: isShowingAll ?? this.isShowingAll,
    );
  }
}

/// Error state when data fetch fails
class HomeError extends HomeState implements ErrorState {
  @override
  final String error;

  HomeError({required this.error});
}
