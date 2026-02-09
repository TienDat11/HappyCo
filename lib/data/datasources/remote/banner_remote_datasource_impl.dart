import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/datasources/remote/banner_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/api_endpoints.dart';

/// Banner Remote Data Source Implementation
class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final DioClient _dioClient;

  BannerRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Map<String, dynamic>> getBanners(
      {int limit = 5, int offset = 0}) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.banners,
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    return response.data as Map<String, dynamic>;
  }
}
