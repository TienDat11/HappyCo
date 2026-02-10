import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Home Header Widget
///
/// Displays:
/// - Functional search bar with pill shape
/// - Notification with badge
class HomeHeader extends StatefulWidget {
  final VoidCallback? onNotificationTap;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onSearchCleared;

  const HomeHeader({
    super.key,
    this.onNotificationTap,
    this.onSearch,
    this.onSearchCleared,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    if (value.trim().isEmpty) {
      widget.onSearchCleared?.call();
    } else {
      widget.onSearch?.call(value);
    }
  }

  void _onClear() {
    _searchController.clear();
    _focusNode.unfocus();
    setState(() {});
    widget.onSearchCleared?.call();
  }

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
    final hasText = _searchController.text.isNotEmpty;

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
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: _onChanged,
              style: TextStyle(
                fontSize: UISizes.font.sp14,
                color: UIColors.gray700,
              ),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm sản phẩm',
                hintStyle: TextStyle(
                  fontSize: UISizes.font.sp14,
                  color: UIColors.gray300,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (hasText)
            GestureDetector(
              onTap: _onClear,
              child: Icon(
                Icons.close,
                size: UISizes.width.w20,
                color: UIColors.gray400,
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the notification icon with badge counter
  Widget _buildNotification() {
    return GestureDetector(
      onTap: widget.onNotificationTap,
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
