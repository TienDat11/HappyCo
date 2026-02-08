import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Auth Footer Widget - Login/Register switcher text
///
/// Specifications from Figma Auth Dialogs:
/// - Left text: "Bạn chưa có tài khoản?" or "Bạn đã có tài khoản?"
///   - Font: Roboto Regular 14px, Color: #3F3F46 (gray700)
/// - Right text (link): "Đăng ký ngay!" or "Đăng nhập ngay!"
///   - Font: Roboto Medium 14px, Color: #C0333C (primary)
/// - Gap between text: 8px
class AuthFooter extends StatelessWidget {
  /// Left text (non-clickable)
  final String leftText;

  /// Right text (clickable link)
  final String rightText;

  /// Callback when link is tapped
  final VoidCallback? onLinkTap;

  const AuthFooter({
    super.key,
    required this.leftText,
    required this.rightText,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: leftText,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: UISizes.font.sp14,
              fontWeight: FontWeight.w400,
              color: UIColors.gray700,
              height: 22 / 14,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: rightText,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: UISizes.font.sp14,
              fontWeight: FontWeight.w500,
              color: UIColors.primary,
              height: 22 / 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onLinkTap != null ? onLinkTap : () {},
          ),
        ],
      ),
    );
  }
}
