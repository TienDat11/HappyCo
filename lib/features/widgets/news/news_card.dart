import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/news_entity.dart';

/// A large card widget for displaying news articles.
///
/// Features a 160px height image, publication date, title, and description.
/// Based on Figma design node-id=1:2465.
class NewsCard extends StatelessWidget {
  /// The news article to display.
  final NewsEntity news;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.news,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UICard(
      borderRadius: UISizes.square.r12,
      padding: EdgeInsets.all(UISizes.width.w12),
      hasShadow: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UISizes.square.r12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(height: UISizes.height.h12),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UISizes.square.r12),
      child: Image.network(
        news.imageUrl,
        width: double.infinity,
        height: UISizes.height.h160,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: UISizes.height.h160,
            color: UIColors.gray100,
            child: Icon(
              Icons.image_outlined,
              size: UISizes.width.w40,
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
      children: [
        UIText(
          title: news.publishDate,
          titleSize: UISizes.font.sp14,
          titleColor: UIColors.gray500,
        ),
        SizedBox(height: UISizes.height.h8),
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
          titleSize: UISizes.font.sp14,
          titleColor: UIColors.gray500,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
