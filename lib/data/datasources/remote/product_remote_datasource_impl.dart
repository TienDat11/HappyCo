import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/datasources/remote/product_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';

/// Product Remote Data Source Implementation
///
/// Concrete implementation of ProductRemoteDataSource.
/// Makes actual API calls using DioClient.

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<List<Map<String, dynamic>>> getFeaturedProducts() async {
    final response =
        await _dioClient.get<dynamic>(ApiEndpoints.featuredProducts);
    return _handleListResponse(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> getRecommendedProducts() async {
    final response =
        await _dioClient.get<dynamic>(ApiEndpoints.recommendedProducts);
    return _handleListResponse(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> getProductsByCategory(
      String categoryId) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.products,
      queryParameters: {'category_id': categoryId},
    );
    return _handleListResponse(response.data);
  }

  @override
  Future<Map<String, dynamic>?> getProductById(String id) async {
    final response =
        await _dioClient.get<dynamic>(ApiEndpoints.productDetail(id));
    return _handleSingleResponse(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.products,
      queryParameters: {'search': query},
    );
    return _handleListResponse(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> getProducts({
    int limit = 6,
    int offset = 0,
    String? search,
    bool? hot,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{
      'limit': limit,
      'offset': offset,
    };

    if (search != null) queryParams['search'] = search;
    if (hot != null) queryParams['hot'] = hot;
    if (category != null) queryParams['category'] = category;

    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.products,
      queryParameters: queryParams,
    );
    return _handleListResponse(response.data);
  }

  List<Map<String, dynamic>> _handleListResponse(dynamic data) {
    if (data is List<Map<String, dynamic>>) {
      return data;
    } else if (data is Map<String, dynamic>) {
      return [data];
    }

    return [];
  }

  Map<String, dynamic>? _handleSingleResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    return null;
  }
}
