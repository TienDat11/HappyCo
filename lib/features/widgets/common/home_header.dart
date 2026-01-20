import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Home Header Widget
///
/// Displays:
/// - Search bar with pill shape
/// - Notification with badge
class HomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const HomeHeader({super.key, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: UIColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(UISizes.square.r12),
          bottomRight: Radius.circular(UISizes.square.r12),
        ),
      ),
      padding: EdgeInsets.only(
        top: topPadding + UISizes.height.h12,
        bottom: UISizes.height.h12,
      ),
      child: Column(
        children: [
          // Search bar and notification row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            child: Row(
              children: [
                Expanded(child: _buildSearchBar()),
                SizedBox(width: UISizes.width.w12),
                _buildNotification(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the search input field with pill-shaped container
  Widget _buildSearchBar() {
    return Container(
      height: UISizes.height.h44,
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(UISizes.square.r128),
        border: Border.all(
          color: UIColors.gray100,
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: UISizes.width.w16,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: UISizes.width.w24,
            color: UIColors.gray700,
          ),
          SizedBox(width: UISizes.width.w12),
          UIText(
            title: 'Tìm kiếm sản phẩm',
            titleColor: UIColors.gray300,
            titleSize: UISizes.font.sp14,
          ),
        ],
      ),
    );
  }

  /// Builds the notification icon with badge counter
  Widget _buildNotification() {
    return GestureDetector(
      onTap: onNotificationTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(UISizes.width.w10),
            decoration: BoxDecoration(
              color: UIColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: UISizes.square.r4,
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
          Positioned(
            top: 0,
            right: -2,
            child: Container(
              padding: EdgeInsets.all(UISizes.width.w1),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UISizes.width.w4,
                  vertical: UISizes.height.h2,
                ),
                decoration: const BoxDecoration(
                  color: UIColors.red500,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: UIText(
                    title: '4',
                    titleColor: UIColors.white,
                    titleSize: UISizes.font.sp10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
