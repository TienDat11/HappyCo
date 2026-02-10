import 'package:happyco/data/datasources/remote/product_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';
import 'package:happyco/data/mappers/product_detail_mapper.dart';
import 'package:happyco/data/mappers/product_mapper.dart';
import 'package:happyco/data/models/product_detail_dto.dart';
import 'package:happyco/data/models/product_dto.dart';
import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// Product Repository Implementation
///
/// Real API implementation replacing mock data source.
/// Uses ProductRemoteDataSource for API calls and handles DTO ↔ Entity conversion.

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;
  final RemoteConfig _remoteConfig;

  ProductRepositoryImpl({
    required ProductRemoteDataSource dataSource,
    required RemoteConfig remoteConfig,
  })  : _dataSource = dataSource,
        _remoteConfig = remoteConfig;

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    final response = await _dataSource.getFeaturedProducts();
    return _mapListToEntities(response);
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    final response = await _dataSource.getRecommendedProducts();
    return _mapListToEntities(response);
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    final response = await _dataSource.getProductsByCategory(categoryId);
    return _mapListToEntities(response);
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final json = await _dataSource.getProductById(id);
    if (json == null) return null;

    final dto = ProductDto.fromJson(json);
    return dto.toEntity();
  }

  @override
  Future<ProductDetailEntity> getProductDetail(String id) async {
    final json = await _dataSource.getProductById(id);
    if (json == null) {
      throw Exception('Product not found: $id');
    }

    final dto = ProductDetailDto.fromJson(json);
    return dto.toDetailEntity();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final response = await _dataSource.searchProducts(query);
    return _mapListToEntities(response);
  }

  @override
  Future<List<ProductEntity>> getProducts({
    int limit = 6,
    int offset = 0,
    String? search,
    bool? hot,
    String? category,
  }) async {
    final response = await _dataSource.getProducts(
      limit: limit,
      offset: offset,
      search: search,
      hot: hot,
      category: category,
    );
    return _mapListToEntities(response);
  }

  /// Helper method to convert list of Maps to Entities
  List<ProductEntity> _mapListToEntities(List<Map<String, dynamic>> list) {
    return list.map((json) {
      final dto = ProductDto.fromJson(json);
      return dto.toEntity();
    }).toList();
  }
}
