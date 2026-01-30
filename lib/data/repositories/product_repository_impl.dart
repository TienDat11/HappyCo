import 'package:happyco/data/datasources/remote/product_remote_datasource.dart';
import 'package:happyco/data/models/product_dto.dart';
import 'package:happyco/domain/repositories/product_repository.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Product Repository Implementation
///
/// Real API implementation replacing mock data source.
/// Uses ProductRemoteDataSource for API calls and manual DTO ↔ Entity conversion.

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  ProductRepositoryImpl({
    required ProductRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  /// Convert Map to ProductEntity
  ProductEntity _mapToEntity(Map<String, dynamic> json) {
    final dto = ProductDto.fromJson(json);
    return ProductEntity(
      id: dto.id,
      name: dto.name,
      priceInVnd: dto.priceInVnd,
      oldPriceInVnd: dto.oldPriceInVnd,
      imageUrl: dto.imageUrl,
      category: dto.category,
      isFeatured: dto.isFeatured,
    );
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    final response = await _dataSource.getFeaturedProducts();
    return response.map((json) => _mapToEntity(json)).toList();
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    final response = await _dataSource.getRecommendedProducts();
    return response.map((json) => _mapToEntity(json)).toList();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    final response = await _dataSource.getProductsByCategory(categoryId);
    return response.map((json) => _mapToEntity(json)).toList();
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final json = await _dataSource.getProductById(id);
    return json != null ? _mapToEntity(json) : null;
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final response = await _dataSource.searchProducts(query);
    return response.map((json) => _mapToEntity(json)).toList();
  }
}
