import 'package:happyco/data/datasources/remote/news_remote_datasource.dart';
import 'package:happyco/data/mappers/news_category_mapper.dart';
import 'package:happyco/data/mappers/news_mapper.dart';
import 'package:happyco/data/mappers/news_video_mapper.dart';
import 'package:happyco/data/models/news_category_dto.dart';
import 'package:happyco/data/models/news_dto.dart';
import 'package:happyco/data/models/news_video_dto.dart';
import 'package:happyco/domain/entities/news_category_entity.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// News Repository Implementation using real API data.
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _dataSource;

  NewsRepositoryImpl({required NewsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<NewsCategoryEntity>> getNewsCategories() async {
    final response = await _dataSource.getNewsCategories();
    final listResponse = NewsCategoryListResponse.fromJson(response);
    return listResponse.toEntityList();
  }

  @override
  Future<List<NewsEntity>> getNews({
    String? categoryId,
    String? search,
    int? limit,
    int? offset,
  }) async {
    final response = await _dataSource.getNews(
      categoryId: categoryId,
      search: search,
      limit: limit,
      offset: offset,
    );
    final listResponse = NewsListResponse.fromJson(response);
    return listResponse.toEntityList();
  }

  @override
  Future<List<NewsEntity>> getNewsVideos() async {
    final response = await _dataSource.getNewsVideos();
    final listResponse = NewsVideoListResponse.fromJson(response);
    return listResponse.toEntityList();
  }
}
