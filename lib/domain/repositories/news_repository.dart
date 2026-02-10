import 'package:happyco/domain/entities/news_category_entity.dart';
import 'package:happyco/domain/entities/news_entity.dart';

/// Repository interface for news data operations.
abstract class NewsRepository {
  /// Fetches news categories for the TabBar.
  Future<List<NewsCategoryEntity>> getNewsCategories();

  /// Fetches news articles, optionally filtered by category and search.
  Future<List<NewsEntity>> getNews({
    String? categoryId,
    String? search,
    int? limit,
    int? offset,
  });

  /// Fetches video content for the news screen.
  Future<List<NewsEntity>> getNewsVideos();
}
