import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// Params for GetProductsUseCase
class GetProductsParams {
  final int limit;
  final int offset;
  final String? search;
  final bool? hot;
  final String? category;

  const GetProductsParams({
    this.limit = 6,
    this.offset = 0,
    this.search,
    this.hot,
    this.category,
  });
}

/// GetProductsUseCase
///
/// Fetches products with pagination and filters
class GetProductsUseCase
    extends StatelessUseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> exec(GetProductsParams params) {
    return repository.getProducts(
      limit: params.limit,
      offset: params.offset,
      search: params.search,
      hot: params.hot,
      category: params.category,
    );
  }
}
