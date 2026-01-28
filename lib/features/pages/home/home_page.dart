import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/config/app_constants.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/features/widgets/sections/promotional_banner.dart';
import 'package:happyco/features/widgets/sections/home_categories.dart';
import 'package:happyco/features/widgets/common/home_header.dart';
import 'package:happyco/features/widgets/product/product_grid.dart';

/// Home Page - Vietnamese Furniture E-commerce
///
/// Based on Figma design node-id=1-728
/// Architecture: Feature-first presentation layer with BLoC state management
///
/// Features:
/// - Header with search bar and notification
/// - Hero banner carousel
/// - Category icons (8 furniture categories)
/// - Product grid sections (Featured & Recommended)
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          HomeCategories(isLoading: true),
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
            const PromotionalBanner(),
            SizedBox(height: UISizes.height.h24),
            HomeCategories(),
            SizedBox(height: UISizes.height.h24),
            ProductGrid(
              title: AppSectionTitles.featuredProducts,
              actionText: AppActionTexts.viewAll,
              onActionTap: () {
                // Navigate to all featured products
              },
              products: state.featuredProducts,
              onProductTap: _onProductTap,
              onAddToCart: _onAddToCart,
            ),
            SizedBox(height: UISizes.height.h24),
            ProductGrid(
              title: AppSectionTitles.recommendedProducts,
              actionText: AppActionTexts.viewAll,
              onActionTap: () {
                // Navigate to all recommended products
              },
              products: state.recommendedProducts,
              onProductTap: _onProductTap,
              onAddToCart: _onAddToCart,
            ),
            SizedBox(height: UISizes.height.h32),
          ],
        ),
      ),
    );
  }

  void _onProductTap(ProductEntity product) {
    // Navigate to product details
  }

  void _onAddToCart(ProductEntity product) {
    // Add to cart action
  }
}
