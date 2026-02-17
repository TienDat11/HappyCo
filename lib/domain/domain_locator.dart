import 'package:happyco/domain/repositories/auth_repository.dart';
import 'package:happyco/domain/repositories/banner_repository.dart';
import 'package:happyco/domain/repositories/category_repository.dart';
import 'package:happyco/domain/repositories/notification_repository.dart';
import 'package:happyco/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:happyco/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:happyco/domain/usecases/auth/login_usecase.dart';
import 'package:happyco/domain/usecases/auth/logout_usecase.dart';
import 'package:happyco/domain/usecases/auth/refresh_otp_usecase.dart';
import 'package:happyco/domain/usecases/auth/register_usecase.dart';
import 'package:happyco/domain/usecases/auth/reset_password_usecase.dart';
import 'package:happyco/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_product_detail_usecase.dart';
import 'package:happyco/domain/usecases/get_products_usecase.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_news_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_news_videos_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';
import 'package:happyco/domain/usecases/search_products_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/domain/usecases/get_notification_detail_usecase.dart';
import 'package:happyco/domain/usecases/get_nottification_items_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:happyco/domain/domain_locator.config.dart';
import 'package:happyco/domain/repositories/news_repository.dart';
import 'package:happyco/domain/repositories/product_repository.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

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
  domainLocator.registerFactory<GetProductsUseCase>(
    () => GetProductsUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );
  domainLocator.registerFactory<GetProductDetailUseCase>(
    () => GetProductDetailUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );
  domainLocator.registerFactory<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(
      repository: domainLocator<CategoryRepository>(),
    ),
  );
  domainLocator.registerFactory<SearchProductsUseCase>(
    () => SearchProductsUseCase(
      repository: domainLocator<ProductRepository>(),
    ),
  );
  domainLocator.registerFactory<GetBannersUseCase>(
    () => GetBannersUseCase(
      repository: domainLocator<BannerRepository>(),
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
  domainLocator.registerFactory<GetNewsCategoriesUseCase>(
    () => GetNewsCategoriesUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetNewsUseCase>(
    () => GetNewsUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );
  domainLocator.registerFactory<GetNewsVideosUseCase>(
    () => GetNewsVideosUseCase(
      repository: domainLocator<NewsRepository>(),
    ),
  );

  // Auth use cases
  domainLocator.registerFactory<LoginUseCase>(
    () => LoginUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<RefreshOtpUseCase>(
    () => RefreshOtpUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );
  domainLocator.registerFactory<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(
      repository: domainLocator<AuthRepository>(),
    ),
  );

  // Auth Bloc - Singleton to persist auth state across app
  domainLocator.registerSingleton<AuthBloc>(
    AuthBloc(
      loginUseCase: domainLocator<LoginUseCase>(),
      registerUseCase: domainLocator<RegisterUseCase>(),
      forgotPasswordUseCase: domainLocator<ForgotPasswordUseCase>(),
      verifyOtpUseCase: domainLocator<VerifyOtpUseCase>(),
      refreshOtpUseCase: domainLocator<RefreshOtpUseCase>(),
      resetPasswordUseCase: domainLocator<ResetPasswordUseCase>(),
      logoutUseCase: domainLocator<LogoutUseCase>(),
      checkAuthStatusUseCase: domainLocator<CheckAuthStatusUseCase>(),
      authRepository: domainLocator<AuthRepository>(),
    ),
  );

  // Auto-register all @injectable classes in domain layer
  domainLocator.initDomainLocator();
}
