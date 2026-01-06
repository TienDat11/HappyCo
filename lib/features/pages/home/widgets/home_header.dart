import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Home Header Widget
///
/// Displays:
/// - Current time
/// - Notification bell icon
/// - Search bar with placeholder
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UISizes.width.w16),
      color: UIColors.white,
      child: Column(
        children: [
          // Top row: Time and notification
          _buildTopRow(),
          SizedBox(height: UISizes.height.h8),
          // Search bar
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIText(
          title: _getCurrentTime(),
          titleColor: UIColors.gray600,
          titleSize: UISizes.font.sp14,
          fontWeight: FontWeight.w500,
        ),
        Container(
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(UISizes.square.r8),
            boxShadow: [
              BoxShadow(
                color: UIColors.cardShadow,
                blurRadius: UISizes.square.r8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Icon(
            Icons.notifications_outlined,
            size: UISizes.width.w24,
            color: UIColors.gray700,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: UIColors.gray100,
        borderRadius: BorderRadius.circular(UISizes.square.r8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: UISizes.width.w16,
        vertical: UISizes.height.h8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: UISizes.width.w20,
            color: UIColors.gray400,
          ),
          SizedBox(width: UISizes.width.w8),
          UIText(
            title: 'Tìm kiếm sản phẩm...',
            titleColor: UIColors.gray400,
            titleSize: UISizes.font.sp14,
          ),
        ],
      ),
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
