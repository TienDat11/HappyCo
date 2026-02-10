import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/config/app_constants.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/pages/category/bloc/category_bloc.dart';
import 'package:happyco/core/ui/widgets/banners/promotional_banner.dart';
import 'package:happyco/features/home/widgets/home_header.dart';
import 'package:happyco/features/home/widgets/home_categories.dart';
import 'package:happyco/features/pages/category/widgets/category_section.dart';
import 'package:happyco/features/products/widgets/product_grid.dart';

/// Category Page - Browse All Categories
///
/// Displays:
/// - Header with search & notification (reuse HomeHeader)
/// - Banner carousel
/// - All categories with products in collapsible sections
/// - See More/Show Less toggle per category
@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<CategoryBloc>()..add(OnCategoryInitialize()),
      child: const _CategoryPageContent(),
    );
  }
}

class _CategoryPageContent extends StatelessWidget {
  const _CategoryPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          HomeHeader(
            onSearch: (query) {
              context.read<CategoryBloc>().add(OnCategorySearch(query));
            },
            onSearchCleared: () {
              context.read<CategoryBloc>().add(OnCategorySearchCleared());
            },
          ),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return _buildLoadingState();
                }

                if (state is CategoryError) {
                  return _buildErrorState(context, state.error);
                }

                if (state is CategoryLoaded) {
                  return _buildMainContent(context, state);
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
          SizedBox(height: UISizes.height.h16),
          const HomeCategories(isLoading: true),
          SizedBox(height: UISizes.height.h8),
          // Loading skeleton sections
          for (int i = 0; i < 3; i++)
            CategorySection(
              category: CategoryEntity.empty(),
              products: const [],
              isExpanded: false,
              onToggle: () {},
              isLoading: true,
            ),
          SizedBox(height: UISizes.height.h32),
        ],
      ),
    );
  }

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
            title: 'Đã có lỗi xảy ra',
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
              context.read<CategoryBloc>().add(OnCategoryRefresh());
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

  Widget _buildMainContent(BuildContext context, CategoryLoaded state) {
    if (state.categories.isEmpty) {
      return _buildEmptyState();
    }

    // Show filtered products when searching or category filter is active
    if (state.isSearching || state.selectedCategoryId != null) {
      return _buildFilteredProducts(context, state);
    }

    // Show all categories with their products
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CategoryBloc>().add(OnCategoryRefresh());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: UISizes.height.h16),
            PromotionalBanner(banners: state.banners),
            SizedBox(height: UISizes.height.h16),
            HomeCategories(
              categories: state.categories,
              selectedCategoryId: state.selectedCategoryId,
              onCategoryTap: (categoryId) {
                context
                    .read<CategoryBloc>()
                    .add(OnCategoryFilterSelected(categoryId));
              },
            ),
            SizedBox(height: UISizes.height.h8),
            // Dynamic category sections
            ...state.categories.map((category) {
              final products = state.productsByCategory[category.id] ?? [];
              final isExpanded =
                  state.expandedCategoryIds.contains(category.id);

              return CategorySection(
                category: category,
                products: products,
                isExpanded: isExpanded,
                onToggle: () => context
                    .read<CategoryBloc>()
                    .add(OnCategoryToggleExpansion(category.id)),
                onProductTap: _onProductTap,
                onAddToCart: _onAddToCart,
              );
            }),
            SizedBox(height: UISizes.height.h32),
          ],
        ),
      ),
    );
  }

  Widget _buildFilteredProducts(
    BuildContext context,
    CategoryLoaded state,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CategoryBloc>().add(OnCategoryRefresh());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: UISizes.height.h16),
            PromotionalBanner(banners: state.banners),
            SizedBox(height: UISizes.height.h16),
            HomeCategories(
              categories: state.categories,
              selectedCategoryId: state.selectedCategoryId,
              onCategoryTap: (categoryId) {
                context
                    .read<CategoryBloc>()
                    .add(OnCategoryFilterSelected(categoryId));
              },
            ),
            SizedBox(height: UISizes.height.h8),
            ProductGrid(
              title: state.isSearching
                  ? 'Kết quả tìm kiếm'
                  : state.categories
                          .where((c) => c.id == state.selectedCategoryId)
                          .map((c) => c.name)
                          .firstOrNull ??
                      'Sản phẩm',
              products: state.filteredProducts,
              onProductTap: _onProductTap,
              onAddToCart: _onAddToCart,
            ),
            SizedBox(height: UISizes.height.h32),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category_outlined,
            size: UISizes.width.w48,
            color: UIColors.gray400,
          ),
          SizedBox(height: UISizes.height.h16),
          UIText(
            title: 'Không có danh mục sản phẩm',
            titleSize: UISizes.font.sp16,
            titleColor: UIColors.gray600,
          ),
        ],
      ),
    );
  }

  void _onProductTap(ProductEntity product) {
    // TODO: Navigate to product detail
  }

  void _onAddToCart(ProductEntity product) {
    // TODO: Add to cart
  }
}
