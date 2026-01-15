import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// GetCategoryProductsUseCase
///
/// Fetches products filtered by category ID
class GetCategoryProductsUseCase
    extends StatelessUseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  GetCategoryProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> exec(String categoryId) =>
      repository.getProductsByCategory(categoryId);
}
