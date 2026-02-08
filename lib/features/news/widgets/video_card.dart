import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/core/ui/widgets/video/happy_video_player.dart';
import 'package:happyco/domain/entities/news_entity.dart';

/// Video card widget with play icon overlay and inline video playback.
///
/// Features:
/// - CachedNetworkImage for optimized thumbnail loading
/// - Gradient overlay with video title
/// - Styled play button
/// - Close button when playing
/// - Smooth transition between thumbnail and video
///
/// Based on Figma design node-id=1:2570.
class VideoCard extends StatefulWidget {
  /// The video to display.
  final NewsEntity video;

  /// Callback when card is tapped.
  /// If null, tapping will toggle inline video playback.
  final VoidCallback? onTap;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _playIconController;

  @override
  void initState() {
    super.initState();
    _playIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 1.0,
      upperBound: 1.15,
    );
  }

  @override
  void dispose() {
    _playIconController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }

    // Toggle inline video playback if videoUrl is available
    if (widget.video.videoUrl != null && widget.video.videoUrl!.isNotEmpty) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _handleClose() {
    setState(() {
      _isPlaying = false;
    });
  }

  void _onPlayButtonTapDown(TapDownDetails details) {
    _playIconController.forward();
  }

  void _onPlayButtonTapUp(TapUpDetails details) {
    _playIconController.reverse();
  }

  void _onPlayButtonTapCancel() {
    _playIconController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: UISizes.height.h12),
      child: UICard(
        borderRadius: UISizes.square.r12,
        padding: EdgeInsets.zero,
        hasShadow: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(UISizes.square.r12),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                _isPlaying ? _buildVideoPlayer() : _buildThumbnailWithOverlay(),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailWithOverlay() {
    return GestureDetector(
      onTap: _handleTap,
      onTapDown: _onPlayButtonTapDown,
      onTapUp: _onPlayButtonTapUp,
      onTapCancel: _onPlayButtonTapCancel,
      child: Stack(
        children: [
          _buildThumbnail(),
          _buildGradientOverlay(),
          _buildVideoTitle(),
          _buildPlayIcon(),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return SizedBox(
      height: UISizes.height.h200,
      child: HappyVideoPlayer(
        videoUrl: widget.video.videoUrl!,
        autoPlay: true,
        videoAspectRatio: 16 / 9,
        onClose: _handleClose,
        placeholder: _buildThumbnail(),
      ),
    );
  }

  Widget _buildThumbnail() {
    return CachedNetworkImage(
      imageUrl: widget.video.imageUrl,
      width: double.infinity,
      height: UISizes.height.h200,
      fit: BoxFit.cover,
      placeholder: (context, url) => HappyShimmer.rounded(
        width: double.infinity,
        height: UISizes.height.h200,
        borderRadius: 0,
      ),
      errorWidget: (context, url, error) => Container(
        width: double.infinity,
        height: UISizes.height.h200,
        color: UIColors.gray100,
        child: Icon(
          Icons.image_outlined,
          size: UISizes.width.w40,
          color: UIColors.gray300,
        ),
      ),
    );
  }

  /// Gradient overlay for text visibility.
  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              UIColors.black.withValues(alpha: 0.7),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  /// Video title at bottom of thumbnail.
  Widget _buildVideoTitle() {
    if (widget.video.title.isEmpty) return const SizedBox.shrink();

    return Positioned(
      left: UISizes.width.w12,
      right: UISizes.width.w12,
      bottom: UISizes.height.h12,
      child: UIText(
        title: widget.video.title,
        titleSize: UISizes.font.sp14,
        fontWeight: FontWeight.w600,
        titleColor: UIColors.white,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Animated play button with subtle scale effect.
  Widget _buildPlayIcon() {
    return Positioned.fill(
      child: Center(
        child: AnimatedBuilder(
          animation: _playIconController,
          builder: (context, child) {
            return Transform.scale(
              scale: _playIconController.value,
              child: child,
            );
          },
          child: Container(
            width: UISizes.width.w56,
            height: UISizes.width.w56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  UIColors.primary,
                  UIColors.primary.withValues(alpha: 0.8),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: UIColors.primary.withValues(alpha: 0.4),
                  blurRadius: UISizes.square.r16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              size: UISizes.width.w32,
              color: UIColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
