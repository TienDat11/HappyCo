import 'package:get_it/get_it.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/search_products_usecase.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_news_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_news_videos_usecase.dart';
import 'package:happyco/domain/usecases/get_product_detail_usecase.dart';
import 'package:happyco/domain/usecases/get_products_usecase.dart';
import 'package:happyco/domain/usecases/get_notification_detail_usecase.dart';
import 'package:happyco/domain/usecases/get_nottification_items_usecase.dart';
import 'package:happyco/features/feature_locator.config.dart';
import 'package:happyco/features/pages/category/bloc/category_bloc.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/features/pages/news/bloc/news_bloc.dart';
import 'package:happyco/features/pages/notification-detail/bloc/notification_detail_bloc.dart';
import 'package:happyco/features/pages/notification/bloc/notification_page_bloc.dart';
import 'package:happyco/features/pages/product_detail/bloc/product_detail_bloc.dart';
import 'package:injectable/injectable.dart';

final featureLocator = GetIt.instance;

/// Setup feature layer dependencies using @Injectable codegen
///
/// Registers:
/// - BLoCs (manual)
/// - All @injectable classes in feature layer (BLoCs, pages, widgets)
@InjectableInit(initializerName: 'initFeatureLocator')
void setupFeatureLocator() {
  // Register BLoCs manually

  featureLocator.registerFactory<HomeBloc>(
    () => HomeBloc(
      getFeaturedProductsUseCase: featureLocator<GetFeaturedProductsUseCase>(),
      getCategoriesUseCase: featureLocator<GetCategoriesUseCase>(),
      getCategoryProductsUseCase: featureLocator<GetCategoryProductsUseCase>(),
      searchProductsUseCase: featureLocator<SearchProductsUseCase>(),
      getBannersUseCase: featureLocator<GetBannersUseCase>(),
      getProductsUseCase: featureLocator<GetProductsUseCase>(),
    ),
  );
  featureLocator.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoriesUseCase: featureLocator<GetCategoriesUseCase>(),
      getCategoryProductsUseCase: featureLocator<GetCategoryProductsUseCase>(),
      searchProductsUseCase: featureLocator<SearchProductsUseCase>(),
      getBannersUseCase: featureLocator<GetBannersUseCase>(),
    ),
  );
  featureLocator.registerFactory<NewsBloc>(
    () => NewsBloc(
      getNewsCategoriesUseCase: featureLocator<GetNewsCategoriesUseCase>(),
      getNewsUseCase: featureLocator<GetNewsUseCase>(),
      getNewsVideosUseCase: featureLocator<GetNewsVideosUseCase>(),
    ),
  );
  featureLocator.registerFactory<NotificationPageBloc>(
    () => NotificationPageBloc(
      getNottificationItemsUsecase:
          featureLocator<GetNottificationItemsUsecase>(),
    ),
  );
  featureLocator.registerFactory<NotificationDetailBloc>(
    () => NotificationDetailBloc(
      getNotificationDetailUsecase:
          featureLocator<GetNotificationDetailUsecase>(),
    ),
  );
  featureLocator.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(
      getProductDetailUseCase: featureLocator<GetProductDetailUseCase>(),
    ),
  );

  // Auto-register all @injectable classes in feature layer
  featureLocator.initFeatureLocator();
}
