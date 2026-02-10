import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/config/app_constants.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/core/ui/widgets/banners/promotional_banner.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/home/widgets/home_categories.dart';
import 'package:happyco/features/home/widgets/home_header.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/features/products/widgets/product_grid.dart';

/// Home Page - Vietnamese Furniture E-commerce
///
/// Based on Figma design node-id=1-728
/// Architecture: Feature-first presentation layer with BLoC state management
///
/// Features:
/// - Header with functional search bar and notification
/// - Hero banner carousel
/// - Category icons from API with selection indicator
/// - Product grid sections (Featured & filtered by category/search)
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndShowLogin();
    });
  }

  void _checkAuthAndShowLogin() {
    final storageRepository = GetIt.I<StorageRepository>();
    if (!storageRepository.isLoggedIn()) {
      Future.delayed(const Duration(milliseconds: 500), () {
        GetIt.I<DialogService>().show(DialogType.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeBloc>()..add(OnHomeInitialize()),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          HomeHeader(
            onNotificationTap: () {
              context.router.push(const NotificationRoute());
            },
            onSearch: (query) {
              context.read<HomeBloc>().add(OnHomeSearch(query: query));
            },
            onSearchCleared: () {
              context.read<HomeBloc>().add(OnHomeSearchCleared());
            },
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return _buildLoadingState();
                }

                if (state is HomeError) {
                  return _buildErrorState(context, state.error);
                }

                if (state is HomeLoaded) {
                  return _buildLoadedState(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: UISizes.height.h16),
          const PromotionalBanner(isLoading: true),
          SizedBox(height: UISizes.height.h24),
          const HomeCategories(isLoading: true),
          SizedBox(height: UISizes.height.h24),
          const ProductGrid(
            title: AppSectionTitles.featuredProducts,
            isLoading: true,
            products: [],
          ),
          SizedBox(height: UISizes.height.h24),
          const ProductGrid(
            title: AppSectionTitles.recommendedProducts,
            isLoading: true,
            products: [],
          ),
          SizedBox(height: UISizes.height.h32),
        ],
      ),
    );
  }

  /// Displays error state with retry button
  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: UISizes.width.w48,
            color: UIColors.gray400,
          ),
          SizedBox(height: UISizes.height.h16),
          UIText(
            title: AppErrorMessages.genericError,
            titleSize: UISizes.font.sp16,
            titleColor: UIColors.gray600,
          ),
          SizedBox(height: UISizes.height.h8),
          UIText(
            title: error,
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.gray400,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: UISizes.height.h24),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(OnHomeRefresh());
            },
            child: const UIText(
              title: AppErrorMessages.retry,
              titleColor: UIColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, HomeLoaded state) {
    final productsToShow = state.displayProducts;
    final sectionTitle = state.isSearching
        ? 'Kết quả tìm kiếm'
        : state.selectedCategoryId != null
            ? AppSectionTitles.products
            : AppSectionTitles.featuredProducts;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(OnHomeRefresh());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: UISizes.height.h16),
            // Hide banner when searching or filtering
            if (!state.isSearching && state.selectedCategoryId == null)
              PromotionalBanner(
                banners: state.banners,
              ),
            SizedBox(height: UISizes.height.h24),
            HomeCategories(
              categories: state.categories,
              selectedCategoryId: state.selectedCategoryId,
              onCategoryTap: (categoryId) {
                context
                    .read<HomeBloc>()
                    .add(OnHomeCategorySelected(categoryId: categoryId));
              },
            ),
            SizedBox(height: UISizes.height.h24),
            ProductGrid(
              title: sectionTitle,
              actionText: state.isSearching || state.selectedCategoryId != null
                  ? null
                  : state.isShowingAll
                      ? 'Ẩn bớt'
                      : AppActionTexts.viewAll,
              onActionTap: () {
                context.read<HomeBloc>().add(OnHomeToggleShowAll());
              },
              products: productsToShow,
              onProductTap: (product) {
                context.router.push(ProductDetailRoute(productId: product.id));
              },
              onAddToCart: _onAddToCart,
            ),
            // Show empty state for search/filter with no results
            if (productsToShow.isEmpty &&
                (state.isSearching || state.selectedCategoryId != null))
              Padding(
                padding: EdgeInsets.symmetric(vertical: UISizes.height.h32),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: UISizes.width.w48,
                        color: UIColors.gray300,
                      ),
                      SizedBox(height: UISizes.height.h12),
                      UIText(
                        title: 'Không tìm thấy sản phẩm',
                        titleSize: UISizes.font.sp14,
                        titleColor: UIColors.gray400,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: UISizes.height.h32),
          ],
        ),
      ),
    );
  }

  void _onAddToCart(ProductEntity product) {}
}
