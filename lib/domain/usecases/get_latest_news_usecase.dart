import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Gets latest news articles across all categories.
class GetLatestNewsUseCase extends UseCase<List<NewsEntity>> {
  final NewsRepository repository;

  GetLatestNewsUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec() => repository.getLatestNews();
}
