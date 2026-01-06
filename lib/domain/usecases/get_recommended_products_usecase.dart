import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// GetRecommendedProductsUseCase
///
/// Fetches recommended products for the home page
class GetRecommendedProductsUseCase extends UseCase<List<ProductEntity>> {
  final ProductRepository repository;

  GetRecommendedProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> exec() => repository.getRecommendedProducts();
}
