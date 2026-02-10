part of 'category_bloc.dart';

/// Category Events
sealed class CategoryEvent extends BaseEvent {}

/// Initialize category page - loads all categories and their products
class OnCategoryInitialize extends CategoryEvent {}

/// Toggle expand/collapse for a specific category
class OnCategoryToggleExpansion extends CategoryEvent {
  final String categoryId;
  OnCategoryToggleExpansion(this.categoryId);
}

/// Refresh all categories and products
class OnCategoryRefresh extends CategoryEvent {}

/// Select a category filter (null = show all categories)
class OnCategoryFilterSelected extends CategoryEvent {
  final String? categoryId;
  OnCategoryFilterSelected(this.categoryId);
}

/// Search products by query
class OnCategorySearch extends CategoryEvent {
  final String query;
  OnCategorySearch(this.query);
}

/// Clear search results
class OnCategorySearchCleared extends CategoryEvent {}
