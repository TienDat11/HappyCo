/// Category Remote Data Source Interface
///
/// Defines contract for category API interactions.
abstract class CategoryRemoteDataSource {
  /// Get all categories
  Future<Map<String, dynamic>> getCategories();
}
