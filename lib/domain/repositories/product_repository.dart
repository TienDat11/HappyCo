import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Product Repository Interface
///
/// Defines of contract for product data access.
/// Interface lives in domain layer, implementation in data layer.
abstract class ProductRepository {
  /// Get featured products for home page
  Future<List<ProductEntity>> getFeaturedProducts();

  /// Get recommended products for home page
  Future<List<ProductEntity>> getRecommendedProducts();

  /// Get products by category
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  /// Get product by ID (list-level entity)
  Future<ProductEntity?> getProductById(String id);

  /// Get full product detail by ID
  Future<ProductDetailEntity> getProductDetail(String id);

  /// Search products by name
  Future<List<ProductEntity>> searchProducts(String query);

  /// Get products with pagination and filters
  Future<List<ProductEntity>> getProducts({
    int limit = 6,
    int offset = 0,
    String? search,
    bool? hot,
    String? category,
  });
}
