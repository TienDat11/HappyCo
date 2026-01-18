import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happyco/data/data_locator.config.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';
import 'package:happyco/data/repositories/news_repository_mock.dart';
import 'package:happyco/data/repositories/storage_repository_impl.dart';
import 'package:happyco/data/repositories/product_repository_mock.dart';
import 'package:happyco/domain/repositories/news_repository.dart';
import 'package:happyco/domain/repositories/product_repository.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';

final dataLocator = GetIt.instance;

/// Setup data layer dependencies using @Injectable codegen
///
/// Registers:
/// - RemoteConfig
/// - StorageRepository
/// - ProductRepository
/// - SharedPreferences
/// - All @injectable classes in data layer (repositories, datasources)
@InjectableInit(initializerName: 'initDataLocator')
Future<void> setupDataLocator() async {
  final prefs = await SharedPreferences.getInstance();
  dataLocator.registerSingleton<SharedPreferences>(prefs);
  dataLocator.registerLazySingleton<RemoteConfig>(() => RemoteConfig());
  dataLocator.registerLazySingleton<StorageRepository>(
    () => StorageRepositoryImpl(dataLocator<SharedPreferences>()),
  );
  dataLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryMock(),
  );
  dataLocator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryMock(),
  );

  dataLocator.initDataLocator();
}
