import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:video_player/video_player.dart';

/// A custom video player widget using [video_player] and [chewie].
///
/// Features:
/// - HappyShimmer loading state
/// - Customized controls with app colors
/// - Styled error UI
/// - Optional close button callback
///
/// This widget handles the initialization and disposal of video controllers.
class HappyVideoPlayer extends StatefulWidget {
  /// URL of the video to play.
  final String videoUrl;

  /// Whether to auto-play on load.
  final bool autoPlay;

  /// Whether to loop the video.
  final bool looping;

  /// Aspect ratio of the video player (default 16:9).
  final double videoAspectRatio;

  /// Custom placeholder widget while loading.
  final Widget? placeholder;

  /// Callback when close button is tapped.
  /// If provided, a close button will appear in the top-right corner.
  final VoidCallback? onClose;

  const HappyVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = true,
    this.looping = false,
    this.videoAspectRatio = 16 / 9,
    this.placeholder,
    this.onClose,
  });

  @override
  State<HappyVideoPlayer> createState() => _HappyVideoPlayerState();
}

class _HappyVideoPlayerState extends State<HappyVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  String? _error;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (_isDisposed) return;

    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      _videoPlayerController = controller;

      await controller.initialize();

      if (_isDisposed) {
        controller.dispose();
        return;
      }

      _chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: widget.videoAspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        allowFullScreen: false,
        showControlsOnInitialize: false,
        // Custom colors matching app theme
        materialProgressColors: ChewieProgressColors(
          playedColor: UIColors.primary,
          handleColor: UIColors.primary,
          bufferedColor: UIColors.primary.withValues(alpha: 0.3),
          backgroundColor: UIColors.gray300,
        ),
        placeholder: widget.placeholder ?? _buildShimmerPlaceholder(),
        errorBuilder: (context, errorMessage) =>
            _buildErrorWidget(errorMessage),
      );

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted && !_isDisposed) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  /// Shimmer loading placeholder using HappyShimmer.
  Widget _buildShimmerPlaceholder() {
    return Container(
      color: UIColors.gray100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Shimmer play button placeholder
            HappyShimmer.rounded(
              width: UISizes.width.w48,
              height: UISizes.width.w48,
              borderRadius: UISizes.width.w24,
            ),
            SizedBox(height: UISizes.height.h12),
            // Loading text shimmer
            HappyShimmer.rounded(
              width: UISizes.width.w100,
              height: UISizes.height.h16,
              borderRadius: UISizes.square.r4,
            ),
          ],
        ),
      ),
    );
  }

  /// Styled error widget matching app design.
  Widget _buildErrorWidget(String errorMessage) {
    return Container(
      color: UIColors.gray900,
      padding: EdgeInsets.all(UISizes.width.w16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(UISizes.width.w12),
              decoration: BoxDecoration(
                color: UIColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: UIColors.error,
                size: UISizes.width.w32,
              ),
            ),
            SizedBox(height: UISizes.height.h12),
            Text(
              'Không thể phát video',
              style: TextStyle(
                color: UIColors.white,
                fontSize: UISizes.font.sp14,
                fontWeight: FontWeight.w600,
                fontFamily: UIFonts.gilroy,
              ),
            ),
            SizedBox(height: UISizes.height.h4),
            Text(
              'Vui lòng kiểm tra kết nối mạng',
              style: TextStyle(
                color: UIColors.gray400,
                fontSize: UISizes.font.sp12,
                fontFamily: UIFonts.gilroy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildVideoContent(),
        if (widget.onClose != null) _buildCloseButton(),
      ],
    );
  }

  Widget _buildVideoContent() {
    if (_error != null) {
      return AspectRatio(
        aspectRatio: widget.videoAspectRatio,
        child: _buildErrorWidget(_error!),
      );
    }

    final controller = _chewieController;
    if (controller != null &&
        controller.videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: widget.videoAspectRatio,
        child: Chewie(controller: controller),
      );
    }

    return AspectRatio(
      aspectRatio: widget.videoAspectRatio,
      child: widget.placeholder ?? _buildShimmerPlaceholder(),
    );
  }

  /// Close button in top-right corner.
  Widget _buildCloseButton() {
    return Positioned(
      top: UISizes.height.h8,
      right: UISizes.width.w8,
      child: GestureDetector(
        onTap: widget.onClose,
        child: Container(
          width: UISizes.width.w32,
          height: UISizes.width.w32,
          decoration: BoxDecoration(
            color: UIColors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: UIColors.white,
            size: UISizes.width.w20,
          ),
        ),
      ),
    );
  }
}
