import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// SearchProductsUseCase
///
/// Searches products by query string
class SearchProductsUseCase
    extends StatelessUseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  SearchProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> exec(String query) =>
      repository.searchProducts(query);
}
