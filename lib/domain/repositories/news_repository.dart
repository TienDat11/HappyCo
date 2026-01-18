import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Repository interface for news and article data operations.
abstract class NewsRepository {
  /// Fetches news articles filtered by [category].
  Future<List<NewsEntity>> getNewsByCategory(NewsCategory category);

  /// Fetches all active promotions and events.
  Future<List<NewsEntity>> getPromotions();

  /// Fetches the most recent news articles across all categories.
  Future<List<NewsEntity>> getLatestNews();

  /// Fetches frequently asked questions.
  Future<List<NewsEntity>> getQA();

  /// Fetches products to be highlighted on the news screen.
  Future<List<ProductEntity>> getFeaturedProducts();

  /// Fetches video content related to news or guides.
  Future<List<NewsEntity>> getRelatedVideos();
}
