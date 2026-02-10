import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_category_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Fetches the list of news categories for the TabBar.
class GetNewsCategoriesUseCase extends UseCase<List<NewsCategoryEntity>> {
  final NewsRepository repository;

  GetNewsCategoriesUseCase({required this.repository});

  @override
  Future<List<NewsCategoryEntity>> exec() => repository.getNewsCategories();
}
