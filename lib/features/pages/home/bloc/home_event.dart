part of 'home_bloc.dart';

/// Home Events
sealed class HomeEvent extends BaseEvent {}

/// Initialize home page — loads categories + featured products
class OnHomeInitialize extends HomeEvent {}

/// Refresh home page data
class OnHomeRefresh extends HomeEvent {}

/// Category selected from TabBar
class OnHomeCategorySelected extends HomeEvent {
  /// Category ID to filter by. Null means "Tất cả" (show featured)
  final String? categoryId;

  OnHomeCategorySelected({this.categoryId});
}

/// Search query changed
class OnHomeSearch extends HomeEvent {
  final String query;

  OnHomeSearch({required this.query});
}

/// Search cleared — return to featured products
class OnHomeSearchCleared extends HomeEvent {}

/// Toggle show all products / show featured only
class OnHomeToggleShowAll extends HomeEvent {}
