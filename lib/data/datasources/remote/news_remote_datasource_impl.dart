import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/datasources/remote/news_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';

/// News Remote Data Source Implementation
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient _dioClient;

  NewsRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Map<String, dynamic>> getNewsCategories() async {
    final response = await _dioClient.get<dynamic>(ApiEndpoints.newsCategories);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getNews({
    String? categoryId,
    String? search,
    int? limit,
    int? offset,
  }) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) queryParams['category'] = categoryId;
    if (search != null && search.isNotEmpty) queryParams['search'] = search;
    if (limit != null) queryParams['limit'] = limit;
    if (offset != null) queryParams['offset'] = offset;

    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.news,
      queryParameters: queryParams,
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getNewsVideos() async {
    final response = await _dioClient.get<dynamic>(ApiEndpoints.newsVideos);
    return response.data as Map<String, dynamic>;
  }
}
