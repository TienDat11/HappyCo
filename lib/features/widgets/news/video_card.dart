import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/domain/entities/news_entity.dart';

/// Video card widget with play icon overlay.
///
/// Features 118px height thumbnail, rounded corners, and shadow.
/// Based on Figma design node-id=1:2570.
class VideoCard extends StatelessWidget {
  /// The video to display.
  final NewsEntity video;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r8,
      padding: EdgeInsets.zero,
      hasShadow: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UISizes.square.r8),
        child: Stack(
          children: [
            _buildThumbnail(),
            _buildPlayIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UISizes.square.r4),
      child: Image.network(
        video.imageUrl,
        width: double.infinity,
        height: UISizes.height.h120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: UISizes.height.h120,
            color: UIColors.gray100,
            child: Icon(
              Icons.image_outlined,
              size: UISizes.width.w24,
              color: UIColors.gray300,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Positioned.fill(
        child: Center(
      child: Container(
        width: UISizes.width.w48,
        height: UISizes.width.w48,
        decoration: BoxDecoration(
          color: UIColors.black.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.play_circle_filled,
          size: UISizes.width.w24,
          color: UIColors.white,
        ),
      ),
    ));
  }
}
