import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Fetches video content for the news screen.
class GetNewsVideosUseCase extends UseCase<List<NewsEntity>> {
  final NewsRepository repository;

  GetNewsVideosUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec() => repository.getNewsVideos();
}
