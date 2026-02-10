import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/core/ui/widgets/video/happy_video_player.dart';

class ProductVideoSection extends StatefulWidget {
  final String? linkVideo;

  const ProductVideoSection({
    super.key,
    this.linkVideo,
  });

  @override
  State<ProductVideoSection> createState() => _ProductVideoSectionState();
}

class _ProductVideoSectionState extends State<ProductVideoSection> {
  bool _isPlaying = false;

  String? _getYouTubeId(String url) {
    if (url.isEmpty) return null;
    final regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\\/u\/\w\/)|(embed\/)|(watch\?)|(shorts\/))\\??v?=?([^#\&?]*).*',
    );
    final match = regExp.firstMatch(url);
    return (match != null && match.group(8)!.length == 11)
        ? match.group(8)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.linkVideo == null || widget.linkVideo!.isEmpty) {
      return const SizedBox.shrink();
    }

    final videoId = _getYouTubeId(widget.linkVideo!);
    if (videoId == null) return const SizedBox.shrink();

    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(
            title: 'Video sản phẩm',
            titleSize: UISizes.font.sp16,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.gray700,
          ),
          SizedBox(height: UISizes.height.h12),
          ClipRRect(
            borderRadius: BorderRadius.circular(UISizes.square.r12),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isPlaying
                  ? _buildVideoPlayer()
                  : _buildThumbnail(thumbnailUrl),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(String thumbnailUrl) {
    return GestureDetector(
      key: const ValueKey('thumbnail'),
      onTap: () => setState(() => _isPlaying = true),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: thumbnailUrl,
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
                Icons.video_library_outlined,
                size: UISizes.width.w48,
                color: UIColors.gray300,
              ),
            ),
          ),
          Container(
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
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return SizedBox(
      key: const ValueKey('player'),
      height: UISizes.height.h200,
      child: HappyVideoPlayer(
        videoUrl: widget.linkVideo!,
        autoPlay: true,
        videoAspectRatio: 16 / 9,
        onClose: () => setState(() => _isPlaying = false),
      ),
    );
  }
}
