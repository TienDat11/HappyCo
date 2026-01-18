part of 'news_bloc.dart';

/// States for the News screen.
sealed class NewsState extends BaseBlocState {}

/// Initial state before any data is loaded.
class NewsInitial extends NewsState {}

/// Loading state while fetching news data.
class NewsLoading extends NewsState {}

/// State when news data is successfully loaded.
class NewsLoaded extends NewsState {
  /// News articles filtered by the selected category.
  final List<NewsEntity> newsByCategory;

  /// Most recent news articles.
  final List<NewsEntity> latestNews;

  /// Frequently asked questions.
  final List<NewsEntity> qaList;

  /// Products highlighted on the news screen.
  final List<ProductEntity> featuredProducts;

  /// Related video content.
  final List<NewsEntity> relatedVideos;

  /// The currently selected filter category.
  final NewsCategory selectedCategory;

  /// Banner image for middle section
  final NewsEntity? banner;

  NewsLoaded({
    required this.newsByCategory,
    required this.latestNews,
    required this.qaList,
    required this.featuredProducts,
    required this.relatedVideos,
    this.selectedCategory = NewsCategory.promotion,
    this.banner,
  });

  /// Creates a copy of this state with updated fields.
  NewsLoaded copyWith({
    List<NewsEntity>? newsByCategory,
    List<NewsEntity>? latestNews,
    List<NewsEntity>? qaList,
    List<ProductEntity>? featuredProducts,
    List<NewsEntity>? relatedVideos,
    NewsCategory? selectedCategory,
    NewsEntity? banner,
  }) {
    return NewsLoaded(
      newsByCategory: newsByCategory ?? this.newsByCategory,
      latestNews: latestNews ?? this.latestNews,
      qaList: qaList ?? this.qaList,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      relatedVideos: relatedVideos ?? this.relatedVideos,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      banner: banner ?? this.banner,
    );
  }
}

/// Error state when data fetching fails.
class NewsError extends NewsState {
  /// The error message to display.
  final String message;
  NewsError(this.message);
}
