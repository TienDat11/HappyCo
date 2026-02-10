import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/domain/entities/banner_entity.dart';

/// A promotional banner widget for marketing campaigns and announcements.
///
/// This widget displays a full-width banner carousel with rounded corners and
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
/// - Dots indicator: Dynamic based on banner count
///   - Active dot: 20x6px, primary color, rounded
///   - Inactive dot: 6x6px circle, gray300
/// - Supports image loading state with shimmer
///
/// **Features:**
/// - List of [BannerEntity] for carousel
/// - PageView with swipe navigation
/// - Shimmer loading state
/// - Error fallback with placeholder icon
/// - Tap gesture support for navigation
/// - Dynamic dots indicator based on banner count
/// - Cached network image loading
/// - Default banner image when no banners provided
///
/// **Example:**
/// ```dart
/// PromotionalBanner(
///   banners: [
///     BannerEntity(
///       id: '1',
///       title: 'Summer Sale',
///       imageUrl: 'https://example.com/banner1.jpg',
///       actionUrl: '/sale',
///     ),
///   ],
///   onBannerTap: (banner) => navigateToAction(banner.actionUrl),
/// )
/// ```
///
/// **Example (Loading State):**
/// ```dart
/// PromotionalBanner(isLoading: true)
/// ```
///
/// **Example (Default Banner - Empty List):**
/// ```dart
/// PromotionalBanner(banners: [])  // Shows default banner image
/// ```
class PromotionalBanner extends StatefulWidget {
  /// List of banner entities to display in carousel.
  final List<BannerEntity> banners;

  /// Callback when a banner is tapped.
  ///
  /// Provides the tapped [BannerEntity] with its actionUrl for navigation.
  /// Disabled when [isLoading] is true.
  final void Function(BannerEntity)? onBannerTap;

  /// Whether to show skeleton loading state.
  ///
  /// When true:
  /// - Displays shimmer placeholder
  /// - Hides dots indicator
  /// - Disables tap interaction
  final bool isLoading;

  const PromotionalBanner({
    super.key,
    this.banners = const [],
    this.onBannerTap,
    this.isLoading = false,
  });

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLoading)
            _buildLoadingState()
          else
            _buildBannerCarousel(),
          if (!widget.isLoading && widget.banners.isNotEmpty) ...[
            SizedBox(height: UISizes.height.h8),
            _BannerDotsIndicator(
              currentIndex: _currentIndex,
              totalCount: widget.banners.length,
            ),
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

  /// Builds the banner carousel or default banner.
  Widget _buildBannerCarousel() {
    // Show default banner if no banners provided
    if (widget.banners.isEmpty) {
      return _buildDefaultBanner();
    }

    return GestureDetector(
      onTap: () {
        if (widget.onBannerTap != null && widget.banners.isNotEmpty) {
          widget.onBannerTap!(widget.banners[_currentIndex]);
        }
      },
      child: Container(
        height: UISizes.height.h180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: UIColors.gray100,
          borderRadius: BorderRadius.circular(UISizes.square.r16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(UISizes.square.r16),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return _buildBannerImage(banner);
            },
          ),
        ),
      ),
    );
  }

  /// Builds a single banner image with cached network image.
  Widget _buildBannerImage(BannerEntity banner) {
    return CachedNetworkImage(
      imageUrl: banner.imageUrl,
      width: double.infinity,
      height: UISizes.height.h180,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: double.infinity,
        height: UISizes.height.h180,
        color: UIColors.gray100,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => _buildErrorPlaceholder(),
    );
  }

  /// Builds the default banner with asset image.
  Widget _buildDefaultBanner() {
    return Container(
      height: UISizes.height.h180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: UIColors.primary,
        borderRadius: BorderRadius.circular(UISizes.square.r16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UISizes.square.r16),
        child: Image.asset(
          UIImages.bannerImage,
          width: double.infinity,
          height: UISizes.height.h180,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorPlaceholder();
          },
        ),
      ),
    );
  }

  /// Builds error placeholder with icon.
  Widget _buildErrorPlaceholder() {
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
  }
}

/// Banner pagination dots indicator widget.
///
/// Displays horizontal dots to indicate the current banner position
/// in a carousel. Shows dynamic active/inactive states.
///
/// **Design Specs:**
/// - Active dot: 20x6px, primary color, rounded (borderRadius.r4)
/// - Inactive dot: 6x6px circle, gray300
/// - Centered below banner
/// - Automatically hides when [totalCount] is 0
class _BannerDotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const _BannerDotsIndicator({
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    if (totalCount <= 1) return const SizedBox.shrink();

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalCount, (index) {
          final isActive = index == currentIndex;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: isActive ? UISizes.width.w20 : UISizes.width.w6,
              height: UISizes.height.h6,
              decoration: BoxDecoration(
                color: isActive ? UIColors.primary : UIColors.gray300,
                borderRadius: isActive
                    ? BorderRadius.circular(UISizes.square.r4)
                    : BorderRadius.circular(UISizes.width.w3),
              ),
            ),
          );
        }),
      ),
    );
  }
}
