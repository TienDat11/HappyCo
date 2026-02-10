import 'package:happyco/data/datasources/remote/category_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';
import 'package:happyco/data/mappers/category_mapper.dart';
import 'package:happyco/data/models/category_dto.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/repositories/category_repository.dart';

/// Category Repository Implementation
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _dataSource;
  final RemoteConfig _remoteConfig;

  CategoryRepositoryImpl({
    required CategoryRemoteDataSource dataSource,
    required RemoteConfig remoteConfig,
  })  : _dataSource = dataSource,
        _remoteConfig = remoteConfig;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await _dataSource.getCategories();
    final categoryListResponse = CategoryListResponse.fromJson(response);
    return categoryListResponse.toEntityList();
  }
}
