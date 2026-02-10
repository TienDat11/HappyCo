import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/services/html_rendering_service.dart';
import 'package:happyco/core/services/html_rendering_service_impl.dart';
import 'package:happyco/data/datasources/remote/api_interceptor.dart';
import 'package:happyco/data/datasources/remote/auth_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:happyco/data/datasources/remote/banner_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/banner_remote_datasource_impl.dart';
import 'package:happyco/data/datasources/remote/category_remote_datasource.dart';
import 'package:happyco/data/datasources/remote/category_remote_datasource_impl.dart';
import 'package:happyco/data/repositories/auth_repository_impl.dart';
import 'package:happyco/data/repositories/banner_repository_impl.dart';
import 'package:happyco/data/repositories/category_repository_impl.dart';
import 'package:happyco/data/repositories/notification_repository_mock.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';
import 'package:happyco/domain/repositories/banner_repository.dart';
import 'package:happyco/domain/repositories/category_repository.dart';
import 'package:happyco/domain/repositories/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:happyco/data/datasources/remote/remote_config.dart';
import 'package:happyco/data/datasources/remote/dio_client.dart';
import 'package:happyco/data/repositories/news_repository_mock.dart';
import 'package:happyco/domain/repositories/news_repository.dart';
import 'package:happyco/domain/repositories/product_repository.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';
import 'package:happyco/data/datasources/remote/product_remote_datasource.dart';
import 'package:happyco/data/repositories/storage_repository_impl.dart';
import 'package:happyco/data/datasources/remote/product_remote_datasource_impl.dart';
import 'package:happyco/data/repositories/product_repository_impl.dart';

final dataLocator = GetIt.instance;

/// Global navigator key for DialogService and other services
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

/// Setup data layer dependencies using @Injectable codegen
///
/// Registers:
/// - GlobalKey<NavigatorState> for DialogService
/// - DialogService
/// - RemoteConfig
/// - StorageRepository
/// - ApiInterceptor
/// - DioClient
/// - ProductRemoteDataSource
/// - ProductRepository
/// - SharedPreferences
/// - AuthRemoteDataSource
/// - AuthRepository
Future<void> setupDataLocator() async {
  final prefs = await SharedPreferences.getInstance();
  dataLocator.registerSingleton<SharedPreferences>(prefs);
  dataLocator.registerSingleton<GlobalKey<NavigatorState>>(appNavigatorKey);
  dataLocator.registerSingleton<DialogService>(DialogService(appNavigatorKey));
  dataLocator.registerLazySingleton<HtmlRenderingService>(
    () => HtmlRenderingServiceImpl(),
  );
  dataLocator.registerLazySingleton<RemoteConfig>(() => RemoteConfig());
  dataLocator.registerLazySingleton<StorageRepository>(
    () => StorageRepositoryImpl(dataLocator<SharedPreferences>()),
  );

  dataLocator.registerLazySingleton<ApiInterceptor>(
    () => ApiInterceptor(
      storage: dataLocator(),
      dio: Dio(BaseOptions(baseUrl: dataLocator<RemoteConfig>().baseUrl)),
      dialogService: dataLocator(),
      config: dataLocator(),
    ),
  );

  dataLocator.registerLazySingleton<DioClient>(() => DioClient(
        config: dataLocator(),
        interceptor: dataLocator(),
      ));

  final ProductRemoteDataSource productRemoteDataSource =
      ProductRemoteDataSourceImpl(dioClient: dataLocator<DioClient>());

  dataLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      dataSource: productRemoteDataSource,
      remoteConfig: dataLocator<RemoteConfig>(),
    ),
  );

  // Category dependencies
  final CategoryRemoteDataSource categoryRemoteDataSource =
      CategoryRemoteDataSourceImpl(dioClient: dataLocator<DioClient>());

  dataLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      dataSource: categoryRemoteDataSource,
      remoteConfig: dataLocator<RemoteConfig>(),
    ),
  );

  // Banner dependencies
  final BannerRemoteDataSource bannerRemoteDataSource =
      BannerRemoteDataSourceImpl(dioClient: dataLocator<DioClient>());

  dataLocator.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(
      dataSource: bannerRemoteDataSource,
      remoteConfig: dataLocator<RemoteConfig>(),
    ),
  );

  dataLocator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryMock(),
  );
  dataLocator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryMock(),
  );

  // Auth dependencies
  dataLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dioClient: dataLocator<DioClient>(),
    ),
  );

  dataLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: dataLocator<AuthRemoteDataSource>(),
      storage: dataLocator<StorageRepository>(),
    ),
  );
}
