import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Gets all promotions and events.
class GetPromotionsUseCase extends UseCase<List<NewsEntity>> {
  final NewsRepository repository;

  GetPromotionsUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec() => repository.getPromotions();
}
