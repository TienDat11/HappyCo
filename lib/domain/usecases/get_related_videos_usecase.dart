import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Gets related video content.
class GetRelatedVideosUseCase extends UseCase<List<NewsEntity>> {
  final NewsRepository repository;

  GetRelatedVideosUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec() => repository.getRelatedVideos();
}
