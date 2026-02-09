import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/domain/entities/product_entity.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        title: UIText(
          title: 'Chi tiết sản phẩm',
          titleSize: 18,
          titleColor: UIColors.primary,
        ),
        centerTitle: true,
        leading: const AutoLeadingButton(),
        backgroundColor: UIColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: UIColors.primary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: 'product_${product.id}',
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => HappyShimmer.rounded(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: UIColors.gray100,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: UIColors.gray400,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(UISizes.width.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIText(
                    title: product.name,
                    titleSize: UISizes.font.sp20,
                    titleColor: UIColors.primary,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                  ),

                  SizedBox(height: UISizes.height.h8),

                  // Price
                  UIText(
                    title: product.formattedPrice,
                    titleSize: UISizes.font.sp18,
                    titleColor: UIColors.primary,
                    fontWeight: FontWeight.bold,
                  ),

                  SizedBox(height: UISizes.height.h16),

                  UIText(
                    title: 'Mô tả sản phẩm',
                    titleSize: 16,
                    fontWeight: FontWeight.w600,
                    titleColor: UIColors.primary,
                  ),
                  SizedBox(height: UISizes.height.h8),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(UISizes.width.w16),
        decoration: BoxDecoration(
          color: UIColors.white,
          boxShadow: [
            BoxShadow(
              color: UIColors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: UIButton(
                  text: 'Thêm vào giỏ',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Đã thêm ${product.name} vào giỏ hàng')),
                    );
                  },
                  style: UIButtonStyle.secondary,
                ),
              ),
              SizedBox(width: UISizes.width.w16),
              Expanded(
                child: UIButton(
                  text: 'Mua ngay',
                  onPressed: () {
                    // TODO: Implement buy now logic
                  },
                  style: UIButtonStyle.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
