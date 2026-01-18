import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/news_entity.dart';

/// Horizontal card widget for displaying news articles.
///
/// Features a 80x56px thumbnail, title, description, and publish date.
/// Based on Figma design node-id=1:2492.
class CompactNewsCard extends StatelessWidget {
  /// The news article to display.
  final NewsEntity news;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  const CompactNewsCard({
    super.key,
    required this.news,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r8,
      padding: EdgeInsets.all(UISizes.width.w8),
      hasShadow: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UISizes.square.r8),
        child: Row(
          children: [
            _buildThumbnail(),
            SizedBox(width: UISizes.width.w12),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UISizes.square.r4),
      child: Image.network(
        news.imageUrl,
        width: UISizes.width.w80,
        height: UISizes.height.h56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: UISizes.width.w80,
            height: UISizes.height.h56,
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

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(
          title: news.title,
          titleSize: UISizes.font.sp14,
          fontWeight: FontWeight.w600,
          titleColor: UIColors.gray700,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: UISizes.height.h4),
        UIText(
          title: news.description,
          titleSize: UISizes.font.sp12,
          titleColor: UIColors.gray500,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: UISizes.height.h8),
        UIText(
          title: news.publishDate,
          titleSize: UISizes.font.sp12,
          titleColor: UIColors.gray500,
        ),
      ],
    );
  }
}
