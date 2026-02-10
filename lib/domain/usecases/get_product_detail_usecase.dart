import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// GetProductDetailUseCase
///
/// Fetches full product detail by ID.
class GetProductDetailUseCase
    extends StatelessUseCase<ProductDetailEntity, String> {
  final ProductRepository repository;

  GetProductDetailUseCase({required this.repository});

  @override
  Future<ProductDetailEntity> exec(String id) {
    return repository.getProductDetail(id);
  }
}
