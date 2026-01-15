part of 'category_bloc.dart';

/// Category Events
sealed class CategoryEvent extends BaseEvent {}

/// Initialize category page with default category
class OnCategoryInitialize extends CategoryEvent {}

/// Select a specific category
class OnCategorySelect extends CategoryEvent {
  final String categoryId;
  OnCategorySelect(this.categoryId);
}

/// Refresh current category products
class OnCategoryRefresh extends CategoryEvent {}
