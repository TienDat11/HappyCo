import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';

/// Home Banner Widget
///
/// Displays promotional banner image with dots indicator
/// Banner is a pure image-based marketing component from Figma
class HomeBanner extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;
  final bool isLoading;

  const HomeBanner({
    super.key,
    this.imageUrl = UIImages.bannerImage,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading)
            HappyShimmer.rounded(
              width: double.infinity,
              height: UISizes.height.h180,
              borderRadius: UISizes.square.r16,
            )
          else
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: UISizes.height.h180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: UIColors.primary,
                  borderRadius: BorderRadius.circular(UISizes.square.r16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(UISizes.square.r16),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: UISizes.height.h180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: UISizes.height.h180,
                        color: UIColors.gray100,
                        child: Icon(
                          Icons.image_outlined,
                          size: UISizes.width.w40,
                          color: UIColors.gray400,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          if (!isLoading) ...[
            SizedBox(height: UISizes.height.h8),
            const BannerDotsIndicator(),
          ],
        ],
      ),
    );
  }
}

/// Banner Dots Indicator Widget
///
/// Displays pagination dots below banner image
class BannerDotsIndicator extends StatelessWidget {
  const BannerDotsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        UISvgs.dotsIcon,
        width: UISizes.width.w44,
        height: UISizes.height.h6,
      ),
    );
  }
}
