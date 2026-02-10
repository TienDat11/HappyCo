part of 'news_bloc.dart';

/// States for the News screen.
sealed class NewsState extends BaseBlocState {}

/// Initial state before any data is loaded.
class NewsInitial extends NewsState {}

/// Loading state while fetching news data.
class NewsLoading extends NewsState {}

/// State when news data is successfully loaded.
class NewsLoaded extends NewsState {
  /// Available news categories for the TabBar.
  final List<NewsCategoryEntity> categories;

  /// The currently selected category.
  final NewsCategoryEntity selectedCategory;

  /// News articles filtered by the selected category.
  final List<NewsEntity> newsByCategory;

  /// Video content for the news screen.
  final List<NewsEntity> videos;

  /// Current search query, if any.
  final String? searchQuery;

  /// Whether to show all videos or only the first 3.
  final bool showAllVideos;

  NewsLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.newsByCategory,
    required this.videos,
    this.searchQuery,
    this.showAllVideos = false,
  });

  /// Creates a copy of this state with updated fields.
  NewsLoaded copyWith({
    List<NewsCategoryEntity>? categories,
    NewsCategoryEntity? selectedCategory,
    List<NewsEntity>? newsByCategory,
    List<NewsEntity>? videos,
    String? searchQuery,
    bool? showAllVideos,
  }) {
    return NewsLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsByCategory: newsByCategory ?? this.newsByCategory,
      videos: videos ?? this.videos,
      searchQuery: searchQuery ?? this.searchQuery,
      showAllVideos: showAllVideos ?? this.showAllVideos,
    );
  }
}

/// Error state when data fetching fails.
class NewsError extends NewsState {
  /// The error message to display.
  final String message;
  NewsError(this.message);
}
