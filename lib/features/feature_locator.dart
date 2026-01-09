import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/features/feature_locator.config.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';

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

  // Auto-register all @injectable classes in feature layer
  featureLocator.initFeatureLocator();
}
