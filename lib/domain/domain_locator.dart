import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/domain/domain_locator.config.dart';
import 'package:happyco/domain/repositories/product_repository.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';

final domainLocator = GetIt.instance;

/// Setup domain layer dependencies using @Injectable codegen
///
/// Registers:
/// - UseCases (manual)
/// - All @injectable classes in domain layer (use cases, repositories interfaces)
@InjectableInit(initializerName: 'initDomainLocator')
void setupDomainLocator() {
  // Register use cases manually
  domainLocator.registerFactory<GetFeaturedProductsUseCase>(
    () => GetFeaturedProductsUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );
  domainLocator.registerFactory<GetRecommendedProductsUseCase>(
    () => GetRecommendedProductsUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );

  // Auto-register all @injectable classes in domain layer
  domainLocator.initDomainLocator();
}
