import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/services/html_rendering_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/features/pages/product_detail/bloc/product_detail_bloc.dart';
import 'package:happyco/features/pages/product_detail/widgets/product_description_section.dart';
import 'package:happyco/features/pages/product_detail/widgets/product_image_gallery.dart';
import 'package:happyco/features/pages/product_detail/widgets/product_info_section.dart';
import 'package:happyco/features/pages/product_detail/widgets/product_video_section.dart';
import 'package:happyco/features/pages/product_detail/widgets/related_products_section.dart';
import 'package:happyco/features/pages/product_detail/widgets/variant_selection_section.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ProductDetailBloc>()
        ..add(OnProductDetailInit(productId: productId)),
      child: Scaffold(
        backgroundColor: UIColors.background,
        appBar: _buildAppBar(context),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading ||
                state is ProductDetailInitial) {
              return _buildLoadingState();
            }
            if (state is ProductDetailError) {
              return _buildErrorState(state.error);
            }
            if (state is ProductDetailLoaded) {
              return _buildProductContent(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: UIColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            size: UISizes.width.w20, color: UIColors.gray900),
        onPressed: () => context.router.back(),
      ),
      title: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          String title = 'Chi tiết sản phẩm';
          if (state is ProductDetailLoaded) {
            title = state.product.name;
          }
          return UIText(
            title: title,
            titleSize: UISizes.font.sp16,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.gray900,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      centerTitle: true,
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          HappyShimmer.rounded(width: double.infinity, height: 280.h),
          SizedBox(height: UISizes.height.h16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HappyShimmer.rounded(width: 200.w, height: 24.h),
                SizedBox(height: UISizes.height.h8),
                HappyShimmer.rounded(width: 150.w, height: 20.h),
                SizedBox(height: UISizes.height.h24),
                HappyShimmer.rounded(width: 100.w, height: 16.h),
                SizedBox(height: UISizes.height.h12),
                Row(
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: HappyShimmer.rounded(width: 60.w, height: 32.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 48.w, color: UIColors.error),
          SizedBox(height: UISizes.height.h16),
          UIText(
            title: error,
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.gray700,
          ),
        ],
      ),
    );
  }

  Widget _buildProductContent(BuildContext context, ProductDetailLoaded state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageGallery(imageUrls: state.product.imageUrls),
          SizedBox(height: UISizes.height.h24),
          ProductInfoSection(
            name: state.product.name,
            displayPrice: state.displayPriceFormatted,
            displayOldPrice: state.displayOldPriceFormatted,
          ),
          SizedBox(height: UISizes.height.h24),
          const Divider(height: 1, color: UIColors.divider),
          SizedBox(height: UISizes.height.h24),
          VariantSelectionSection(
            product: state.product,
            selectedAttributes: state.selectedAttributes,
            quantity: state.quantity,
            maxQuantity: state.maxQuantity,
            onAttributeSelected: (key, value) {
              context.read<ProductDetailBloc>().add(
                    OnVariantAttributeSelected(key: key, value: value),
                  );
            },
            onQuantityChanged: (q) {
              context.read<ProductDetailBloc>().add(
                    OnQuantityChanged(quantity: q),
                  );
            },
          ),
          SizedBox(height: UISizes.height.h24),
          ProductDescriptionSection(
            description: state.product.description,
            htmlRenderingService: GetIt.I<HtmlRenderingService>(),
          ),
          SizedBox(height: UISizes.height.h24),
          ProductVideoSection(linkVideo: state.product.linkVideo),
          SizedBox(height: UISizes.height.h24),
          RelatedProductsSection(
              relatedProducts: state.product.relatedProducts),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UISizes.width.w16),
      decoration: BoxDecoration(
        color: UIColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            final isLoaded = state is ProductDetailLoaded;
            final isFullySelected = isLoaded && state.isFullySelected;

            return UIButton(
              text: 'Thêm vào giỏ hàng',
              isFullWidth: true,
              isEnabled: isFullySelected,
              onPressed: isFullySelected
                  ? () {
                      // Handle add to cart logic
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}
