part of 'category_bloc.dart';

/// Category States
sealed class CategoryState extends BaseBlocState {}

/// Initial state before data is loaded
class CategoryInitial extends CategoryState implements InitialState {}

/// Loading state while fetching categories and products
class CategoryLoading extends CategoryState implements LoadingState {}

/// Loaded state with all categories and their products
class CategoryLoaded extends CategoryState {
  /// All categories with products (filtered: productCount > 0)
  final List<CategoryEntity> categories;

  /// Products mapped by category ID
  final Map<String, List<ProductEntity>> productsByCategory;

  /// Set of category IDs that are currently expanded
  final Set<String> expandedCategoryIds;

  /// Selected category ID for filtering (null = show all categories)
  final String? selectedCategoryId;

  /// Current search query
  final String searchQuery;

  /// Whether user is currently searching
  final bool isSearching;

  /// Filtered products from search or category filter
  final List<ProductEntity> filteredProducts;

  /// Promotional banners
  final List<BannerEntity> banners;

  CategoryLoaded({
    required this.categories,
    required this.productsByCategory,
    required this.expandedCategoryIds,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.isSearching = false,
    this.filteredProducts = const [],
    this.banners = const [],
  });

  /// Returns the products to display based on current filter/search state
  List<ProductEntity> get displayProducts =>
      isSearching || selectedCategoryId != null
          ? filteredProducts
          : productsByCategory.values.expand((e) => e).toList();

  /// Create copy with toggled expansion state for a category
  CategoryLoaded copyWithToggle(String categoryId) {
    final newExpanded = Set<String>.from(expandedCategoryIds);
    if (newExpanded.contains(categoryId)) {
      newExpanded.remove(categoryId);
    } else {
      newExpanded.add(categoryId);
    }
    return CategoryLoaded(
      categories: categories,
      productsByCategory: productsByCategory,
      expandedCategoryIds: newExpanded,
      selectedCategoryId: selectedCategoryId,
      searchQuery: searchQuery,
      isSearching: isSearching,
      filteredProducts: filteredProducts,
      banners: banners,
    );
  }

  CategoryLoaded copyWith({
    List<CategoryEntity>? categories,
    Map<String, List<ProductEntity>>? productsByCategory,
    Set<String>? expandedCategoryIds,
    String? Function()? selectedCategoryId,
    String? searchQuery,
    bool? isSearching,
    List<ProductEntity>? filteredProducts,
    List<BannerEntity>? banners,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      productsByCategory: productsByCategory ?? this.productsByCategory,
      expandedCategoryIds: expandedCategoryIds ?? this.expandedCategoryIds,
      selectedCategoryId: selectedCategoryId != null
          ? selectedCategoryId()
          : this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      banners: banners ?? this.banners,
    );
  }
}

/// Error state when data fetch fails
class CategoryError extends CategoryState implements ErrorState {
  @override
  final String error;

  CategoryError({required this.error});
}
