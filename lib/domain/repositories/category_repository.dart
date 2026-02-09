import 'package:happyco/domain/entities/category_entity.dart';

/// Category Repository Interface
abstract class CategoryRepository {
  /// Get all product categories
  Future<List<CategoryEntity>> getCategories();
}
