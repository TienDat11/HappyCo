part of 'news_bloc.dart';

/// Events for the News screen.
sealed class NewsEvent extends BaseEvent {}

/// Initial event to load all data for the news screen.
class OnNewsInitialize extends NewsEvent {}

/// Event triggered when a filter tab is selected.
class OnNewsFilterChange extends NewsEvent {
  /// The selected news category.
  final NewsCategoryEntity category;
  OnNewsFilterChange(this.category);
}

/// Event triggered when search text changes.
class OnNewsSearch extends NewsEvent {
  /// The search query string.
  final String query;
  OnNewsSearch(this.query);
}

/// Event to refresh all news data.
class OnNewsRefresh extends NewsEvent {}

/// Event to toggle showing all videos vs. only 3.
class OnNewsToggleAllVideos extends NewsEvent {}
