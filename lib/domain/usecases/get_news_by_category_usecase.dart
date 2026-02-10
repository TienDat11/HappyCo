import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// Parameters for fetching news articles.
class GetNewsParams {
  final String? categoryId;
  final String? search;
  final int? limit;
  final int? offset;

  const GetNewsParams({
    this.categoryId,
    this.search,
    this.limit,
    this.offset,
  });
}

/// Fetches news articles with optional category, search, and pagination.
class GetNewsUseCase extends StatelessUseCase<List<NewsEntity>, GetNewsParams> {
  final NewsRepository repository;

  GetNewsUseCase({required this.repository});

  @override
  Future<List<NewsEntity>> exec(GetNewsParams params) => repository.getNews(
        categoryId: params.categoryId,
        search: params.search,
        limit: params.limit,
        offset: params.offset,
      );
}
