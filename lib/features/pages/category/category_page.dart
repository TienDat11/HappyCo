import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/pages/category/bloc/category_bloc.dart';
import 'package:happyco/features/widgets/sections/promotional_banner.dart';
import 'package:happyco/features/widgets/sections/home_categories.dart';
import 'package:happyco/features/widgets/common/home_header.dart';
import 'package:happyco/features/widgets/product/product_grid.dart';
import 'package:happyco/features/widgets/sections/section_title.dart';

/// Category Page - Furniture Category Detail
///
/// Displays:
/// - Header with search & notification (reuse HomeHeader)
/// - Banner carousel (reuse HomeBanner)
/// - Category chips (reuse HomeCategories with selected state)
/// - Product grid by category (reuse HomeProductGrid)
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
          const HomeHeader(),
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return _buildLoadingState();
                }

                if (state is CategoryError) {
                  return _buildErrorState(context, state.error);
                }

                return _buildMainContent(context, state);
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
            title: '',
            isLoading: true,
            products: [],
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
            child: UIText(
              title: 'Thử lại',
              titleColor: UIColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, CategoryState state) {
    final isLoading = state is CategoryLoading;
    final isProductsLoading = state is CategoryProductsLoading;

    String selectedCategoryId;
    List<ProductEntity> products;

    if (state is CategoryLoaded) {
      selectedCategoryId = state.selectedCategoryId;
      products = state.products;
    } else if (state is CategoryProductsLoading) {
      selectedCategoryId = state.selectedCategoryId;
      products = state.products;
    } else {
      selectedCategoryId = 'dining_set';
      products = [];
    }

    if (isLoading) {
      return _buildLoadingState();
    }

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
            const PromotionalBanner(),
            SizedBox(height: UISizes.height.h24),
            HomeCategories(
              selectedCategoryId: selectedCategoryId,
              onCategoryTap: (categoryId) {
                context.read<CategoryBloc>().add(OnCategorySelect(categoryId));
              },
            ),
            SizedBox(height: UISizes.height.h14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
              child: SectionTitle(
                title: _getCategoryName(selectedCategoryId),
              ),
            ),
            SizedBox(height: UISizes.height.h14),
            ProductGrid(
              title: '',
              isLoading: isProductsLoading,
              products: products,
              onProductTap: _onProductTap,
              onAddToCart: _onAddToCart,
            ),
            SizedBox(height: UISizes.height.h32),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    const categoryNames = {
      'dining_set': 'Bộ bàn ăn',
      'dining_chair': 'Ghế ăn',
      'sofa': 'Sofa gỗ',
      'shoe_cabinet': 'Tủ giày',
      'vanity_table': 'Bàn trang điểm',
      'altar': 'Tủ thờ',
      'display_shelf': 'Kệ trang trí',
      'kitchen_cabinet': 'Tủ bếp',
    };
    return categoryNames[categoryId] ?? 'Sản phẩm';
  }

  void _onProductTap(ProductEntity product) {
    // Navigate to product details
  }

  void _onAddToCart(ProductEntity product) {
    // Add to cart action
  }
}
