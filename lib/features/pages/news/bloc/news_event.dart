part of 'news_bloc.dart';

/// Events for the News screen.
sealed class NewsEvent extends BaseEvent {}

/// Initial event to load all data for the news screen.
class OnNewsInitialize extends NewsEvent {}

/// Event triggered when a filter tab is selected.
class OnNewsFilterChange extends NewsEvent {
  /// The selected news category.
  final NewsCategory category;
  OnNewsFilterChange(this.category);
}

/// Event to refresh all news data.
class OnNewsRefresh extends NewsEvent {}
