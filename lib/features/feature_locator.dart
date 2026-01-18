import 'package:happyco/features/pages/category/bloc/category_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/features/feature_locator.config.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/features/pages/news/bloc/news_bloc.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_latest_news_usecase.dart';
import 'package:happyco/domain/usecases/get_promotions_usecase.dart';
import 'package:happyco/domain/usecases/get_qa_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';
import 'package:happyco/domain/usecases/get_related_videos_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';

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
      getRecommendedProductsUseCase:
          featureLocator<GetRecommendedProductsUseCase>(),
    ),
  );
  featureLocator.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoryProductsUseCase: featureLocator<GetCategoryProductsUseCase>(),
    ),
  );
  featureLocator.registerFactory<NewsBloc>(
    () => NewsBloc(
      getNewsByCategoryUseCase: featureLocator<GetNewsByCategoryUseCase>(),
      getLatestNewsUseCase: featureLocator<GetLatestNewsUseCase>(),
      getQAUseCase: featureLocator<GetQAUseCase>(),
      getPromotionsUseCase: featureLocator<GetPromotionsUseCase>(),
      getFeaturedProductsUseCase: featureLocator<GetFeaturedProductsUseCase>(),
      getRelatedVideosUseCase: featureLocator<GetRelatedVideosUseCase>(),
    ),
  );

  // Auto-register all @injectable classes in feature layer
  featureLocator.initFeatureLocator();
}
