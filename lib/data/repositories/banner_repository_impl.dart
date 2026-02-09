import 'package:happyco/data/mappers/banner_mapper.dart';
import 'package:happyco/data/datasources/remote/banner_remote_datasource.dart';
import 'package:happyco/data/models/banner_dto.dart';
import 'package:happyco/domain/repositories/banner_repository.dart';
import 'package:happyco/domain/entities/banner_entity.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';

/// Banner Repository Implementation
class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource _dataSource;
  final RemoteConfig _remoteConfig;

  BannerRepositoryImpl({
    required BannerRemoteDataSource dataSource,
    required RemoteConfig remoteConfig,
  })  : _dataSource = dataSource,
        _remoteConfig = remoteConfig;

  @override
  Future<List<BannerEntity>> getBanners() async {
    final response = await _dataSource.getBanners();
    final bannerListResponse = BannerListResponse.fromJson(response);
    return bannerListResponse.toEntityList(baseUrl: _remoteConfig.imageBaseUrl);
  }
}
