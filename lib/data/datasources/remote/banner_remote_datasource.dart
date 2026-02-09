/// Banner Remote Data Source Interface
abstract class BannerRemoteDataSource {
  /// Get promotional banners
  Future<Map<String, dynamic>> getBanners({int limit = 5, int offset = 0});
}
