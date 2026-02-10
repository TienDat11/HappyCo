/// News Remote Data Source Interface
///
/// Defines contract for news-related API interactions.
abstract class NewsRemoteDataSource {
  /// Get news categories for TabBar
  Future<Map<String, dynamic>> getNewsCategories();

  /// Get news articles filtered by category
  Future<Map<String, dynamic>> getNews({
    String? categoryId,
    String? search,
    int? limit,
    int? offset,
  });

  /// Get news videos
  Future<Map<String, dynamic>> getNewsVideos();
}
