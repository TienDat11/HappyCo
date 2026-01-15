import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';

/// A promotional banner widget for marketing campaigns and announcements.
///
/// This widget displays a full-width banner image with rounded corners and
/// pagination dots indicator below. It's designed for hero sections and
/// promotional content throughout the app.
///
/// **Used in:**
/// - [HomePage]: Hero banner at the top of the home screen
/// - [CategoryPage]: Category-specific promotional banners
/// - Marketing and campaign screens
///
/// **Design Specs:**
/// - Height: 180px
/// - Border radius: 16px
/// - Horizontal padding: 16px
/// - Dots indicator: 44x6px below banner
/// - Supports image loading state with shimmer
///
/// **Features:**
/// - Asset-based image loading (can be extended for network images)
/// - Shimmer loading state
/// - Error fallback with placeholder icon
/// - Tap gesture support for navigation
/// - Pagination dots indicator
///
/// **Example:**
/// ```dart
/// PromotionalBanner(
///   imageUrl: 'assets/images/summer_sale_banner.png',
///   onTap: () => navigateToSalePage(),
/// )
/// ```
///
/// **Example (Default Banner):**
/// ```dart
/// PromotionalBanner()  // Uses default banner image
/// ```
///
/// **Example (Loading State):**
/// ```dart
/// PromotionalBanner(isLoading: true)
/// ```
///
/// **Future Enhancements:**
/// - Support for carousel/swipe functionality
/// - Network image loading
/// - Auto-play timer
/// - Dynamic dots indicator based on banner count
class PromotionalBanner extends StatelessWidget {
  /// The image URL or asset path to display.
  ///
  /// Defaults to [UIImages.bannerImage] if not provided.
  /// Can be extended to support network URLs.
  final String imageUrl;

  /// Callback when the banner is tapped.
  ///
  /// Typically used to navigate to a promotional page or product.
  /// Disabled when [isLoading] is true.
  final VoidCallback? onTap;

  /// Whether to show skeleton loading state.
  ///
  /// When true:
  /// - Displays shimmer placeholder
  /// - Hides dots indicator
  /// - Disables tap interaction
  final bool isLoading;

  const PromotionalBanner({
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
          if (isLoading) _buildLoadingState() else _buildBannerImage(),
          if (!isLoading) ...[
            SizedBox(height: UISizes.height.h8),
            const BannerDotsIndicator(),
          ],
        ],
      ),
    );
  }

  /// Builds the shimmer loading state.
  Widget _buildLoadingState() {
    return HappyShimmer.rounded(
      width: double.infinity,
      height: UISizes.height.h180,
      borderRadius: UISizes.square.r16,
    );
  }

  /// Builds the actual banner image with tap gesture and error handling.
  Widget _buildBannerImage() {
    return GestureDetector(
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
    );
  }
}

/// Banner pagination dots indicator widget.
///
/// Displays horizontal dots to indicate the current banner position
/// in a carousel. Currently shows a static SVG, but can be extended
/// to support dynamic active/inactive states.
///
/// **Design Specs:**
/// - Width: 44px
/// - Height: 6px
/// - Centered below banner
///
/// **Future Enhancements:**
/// - [currentIndex] parameter for active dot
/// - [totalCount] parameter for number of dots
/// - Custom dot colors and sizes
/// - Animated dot transitions
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
