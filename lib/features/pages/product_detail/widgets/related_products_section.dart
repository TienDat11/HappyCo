import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/products/widgets/product_card.dart';

class RelatedProductsSection extends StatelessWidget {
  final List<ProductEntity> relatedProducts;

  const RelatedProductsSection({
    super.key,
    required this.relatedProducts,
  });

  @override
  Widget build(BuildContext context) {
    if (relatedProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: UIColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: UISizes.width.w8),
              UIText(
                title: 'Sản phẩm liên quan',
                titleSize: UISizes.font.sp16,
                fontWeight: FontWeight.bold,
                titleColor: UIColors.gray700,
              ),
            ],
          ),
        ),
        SizedBox(height: UISizes.height.h16),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: UISizes.width.w16,
            crossAxisSpacing: UISizes.width.w16,
            childAspectRatio: 173 / 260,
          ),
          itemCount: relatedProducts.length,
          itemBuilder: (context, index) {
            final product = relatedProducts[index];
            return ProductCard(
              product: product,
              onTap: () {
                context.router.push(ProductDetailRoute(productId: product.id));
              },
            );
          },
        ),
        SizedBox(height: UISizes.height.h32),
      ],
    );
  }
}
