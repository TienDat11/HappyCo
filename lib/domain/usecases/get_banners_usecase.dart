import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/banner_entity.dart';
import 'package:happyco/domain/repositories/banner_repository.dart';

/// GetBannersUseCase
///
/// Fetches marketing banners for the home page
class GetBannersUseCase extends UseCase<List<BannerEntity>> {
  final BannerRepository repository;

  GetBannersUseCase({required this.repository});

  @override
  Future<List<BannerEntity>> exec() => repository.getBanners();
}
