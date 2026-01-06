import 'package:happyco/domain/entities/product_entity.dart';

/// Product Repository Interface
///
/// Defines the contract for product data access.
/// Interface lives in domain layer, implementation in data layer.
abstract class ProductRepository {
  /// Get featured products for home page
  Future<List<ProductEntity>> getFeaturedProducts();

  /// Get recommended products for home page
  Future<List<ProductEntity>> getRecommendedProducts();

  /// Get products by category
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  /// Get product by ID
  Future<ProductEntity?> getProductById(String id);

  /// Search products by name
  Future<List<ProductEntity>> searchProducts(String query);
}
