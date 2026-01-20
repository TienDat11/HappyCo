import 'package:happyco/domain/repositories/notification_repository.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_latest_news_usecase.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_promotions_usecase.dart';
import 'package:happyco/domain/usecases/get_qa_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';
import 'package:happyco/domain/usecases/get_related_videos_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/domain/usecases/get_notification_detail_usecase.dart';
import 'package:happyco/domain/usecases/get_nottification_items_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/domain/domain_locator.config.dart';
import 'package:happyco/domain/repositories/news_repository.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

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
  domainLocator.registerFactory<GetCategoryProductsUseCase>(
    () => GetCategoryProductsUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );
  domainLocator.registerFactory<GetNottificationItemsUsecase>(
    () => GetNottificationItemsUsecase(
      repository: domainLocator<NotificationRepository>(),
    ),
  );
  domainLocator.registerFactory<GetNotificationDetailUsecase>(
    () => GetNotificationDetailUsecase(
      repository: domainLocator<NotificationRepository>(),
    ),
  );

  // Register news use cases
  domainLocator.registerFactory<GetNewsByCategoryUseCase>(
    () => GetNewsByCategoryUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetLatestNewsUseCase>(
    () => GetLatestNewsUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetQAUseCase>(
    () => GetQAUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetPromotionsUseCase>(
    () => GetPromotionsUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetRelatedVideosUseCase>(
    () => GetRelatedVideosUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );

  // Auto-register all @injectable classes in domain layer
  domainLocator.initDomainLocator();
}
