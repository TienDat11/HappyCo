import 'package:happyco/domain/entities/banner_entity.dart';

/// Banner Repository Interface
abstract class BannerRepository {
  /// Get banners for carousel
  Future<List<BannerEntity>> getBanners();
}
