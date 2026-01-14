import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Error404Page - Page Not Found
///
/// Displayed when a resource is not found
class Error404Page extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final VoidCallback? onGoHome;

  const Error404Page({
    super.key,
    this.message,
    this.onRetry,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UISizes.width.w24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: UISizes.width.w250,
                height: UISizes.height.h250,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(UISizes.square.r16),
                  boxShadow: [
                    BoxShadow(
                      color: UIColors.cardShadow,
                      blurRadius: UISizes.square.r16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.search_off,
                  size: UISizes.width.w100,
                  color: UIColors.gray300,
                ),
              ),
              SizedBox(height: UISizes.height.h32),
              UIText(
                title: 'Trang không tìm thấy',
                titleSize: UISizes.font.sp24,
                fontWeight: FontWeight.bold,
                titleColor: UIColors.gray900,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: UISizes.height.h8),
              if (message != null)
                UIText(
                  title: message ??
                      'Trang bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.',
                  titleSize: UISizes.font.sp14,
                  titleColor: UIColors.gray500,
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: UISizes.height.h32),
              if (onRetry != null)
                UIButton(
                  text: 'Thử lại',
                  onPressed: onRetry,
                  style: UIButtonStyle.primary,
                  isFullWidth: true,
                ),
              if (onRetry != null && onGoHome != null)
                SizedBox(height: UISizes.height.h12),
              if (onGoHome != null)
                UIButton(
                  text: 'Về trang chủ',
                  onPressed: onGoHome,
                  style: UIButtonStyle.secondary,
                  isFullWidth: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
