import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Get news articles filtered by category.
class GetNewsByCategoryUseCase
    extends StatelessUseCase<List<NewsEntity>, NewsCategory> {
  final NewsRepository repository;

  GetNewsByCategoryUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec(NewsCategory category) =>
      repository.getNewsByCategory(category);
}
