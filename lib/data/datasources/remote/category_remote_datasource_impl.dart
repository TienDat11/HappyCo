import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/datasources/remote/category_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';

/// Category Remote Data Source Implementation
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient _dioClient;

  CategoryRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Map<String, dynamic>> getCategories() async {
    final response = await _dioClient.get<dynamic>(ApiEndpoints.categories);
    return response.data as Map<String, dynamic>;
  }
}
