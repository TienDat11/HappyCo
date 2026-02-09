/// Product Remote Data Source Interface
///
/// Defines contract for product API interactions.
/// Returns DTOs from API - mapping to entities happens in repository.
abstract class ProductRemoteDataSource {
  /// Get featured products for home page
  Future<List<Map<String, dynamic>>> getFeaturedProducts();

  /// Get recommended products for home page
  Future<List<Map<String, dynamic>>> getRecommendedProducts();

  /// Get products by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(String categoryId);

  /// Get product by ID
  Future<Map<String, dynamic>?> getProductById(String id);

  /// Search products by name
  Future<List<Map<String, dynamic>>> searchProducts(String query);

  /// Get products with pagination and filters
  Future<List<Map<String, dynamic>>> getProducts({
    int limit = 6,
    int offset = 0,
    String? search,
    bool? hot,
    String? category,
  });
}
