import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Gets Q&A articles.
class GetQAUseCase extends UseCase<List<NewsEntity>> {
  final NewsRepository repository;

  GetQAUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec() => repository.getQA();
}
