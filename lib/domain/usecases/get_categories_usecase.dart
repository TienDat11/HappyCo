import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/repositories/category_repository.dart';

/// GetCategoriesUseCase
///
/// Fetches all product categories
class GetCategoriesUseCase extends UseCase<List<CategoryEntity>> {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<List<CategoryEntity>> exec() => repository.getCategories();
}
