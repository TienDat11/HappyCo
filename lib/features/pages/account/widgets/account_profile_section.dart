import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/user_entity.dart';

/// Account Profile Section Widget
///
/// Shows user avatar (with initials), name, and email.
/// Has two states: logged in and not logged in.
class AccountProfileSection extends StatelessWidget {
  /// User entity (null if not logged in)
  final UserEntity? user;

  /// Whether user is logged in
  final bool isLoggedIn;

  /// Callback when "Đăng nhập ngay" button is tapped
  final VoidCallback? onLoginTap;

  const AccountProfileSection({
    super.key,
    this.user,
    this.isLoggedIn = false,
    this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: UISizes.height.h24),
      child: Column(
        children: [
          _buildAvatar(),
          SizedBox(height: UISizes.height.h16),
          if (isLoggedIn && user != null) ...[
            // User name
            UIText(
              title: user!.fullName,
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.w700,
              titleColor: UIColors.gray700,
            ),
            SizedBox(height: UISizes.height.h4),
            // User email
            UIText(
              title: user!.email ?? '',
              titleSize: UISizes.font.sp14,
              fontWeight: FontWeight.w400,
              titleColor: UIColors.gray500,
            ),
          ] else ...[
            // Login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UISizes.width.w100),
              child: UIButton(
                text: 'Đăng nhập ngay',
                onPressed: onLoginTap,
                style: UIButtonStyle.primary,
                isFullWidth: true,
              ),
            ),
            SizedBox(height: UISizes.height.h16),
            // Message
            UIText(
              title: 'Vui lòng đăng nhập để sử dụng dịch vụ',
              titleSize: UISizes.font.sp14,
              fontWeight: FontWeight.w400,
              titleColor: UIColors.gray700,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: UISizes.square.r88,
      height: UISizes.square.r88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: UIColors.primary,
          width: UISizes.square.r2,
        ),
      ),
      padding: EdgeInsets.all(UISizes.square.r4),
      child: ClipOval(
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (isLoggedIn && user != null && user!.fullName.isNotEmpty) {
      // Show initials
      final initials = _getInitials(user!.fullName);
      return Container(
        color: UIColors.primary,
        child: Center(
          child: UIText(
            title: initials,
            titleSize: UISizes.font.sp32,
            fontWeight: FontWeight.w700,
            titleColor: UIColors.white,
          ),
        ),
      );
    }

    // Show placeholder
    return Container(
      color: UIColors.gray100,
      child: Icon(
        Icons.person_outline_rounded,
        size: UISizes.square.r48,
        color: UIColors.gray400,
      ),
    );
  }

  String _getInitials(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    // Get first letter of last word (Vietnamese name convention)
    return parts.last[0].toUpperCase();
  }
}
