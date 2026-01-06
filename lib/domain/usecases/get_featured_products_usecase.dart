import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// GetFeaturedProductsUseCase
///
/// Fetches featured products for the home page
class GetFeaturedProductsUseCase extends UseCase<List<ProductEntity>> {
  final ProductRepository repository;

  GetFeaturedProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> exec() => repository.getFeaturedProducts();
}
