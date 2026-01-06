import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';

/// Dialog Configuration for Happyco App
///
/// Provides default styling and behavior for each dialog type
class DialogConfig {
  /// Dialog title
  final String? title;

  /// Dialog message/content
  final String? message;

  /// Positive button text
  final String? confirmText;

  /// Negative button text
  final String? cancelText;

  /// Whether dialog is barrier dismissible
  final bool barrierDismissible;

  /// Barrier color (overlay background)
  final Color? barrierColor;

  /// Dialog background color
  final Color? backgroundColor;

  /// Dialog border radius
  final double borderRadius;

  /// Dialog elevation/shadow
  final double? elevation;

  /// Custom widget for dialog content
  final Widget? customContent;

  /// Custom widget for dialog title
  final Widget? customTitle;

  /// Custom buttons
  final List<Widget>? customActions;

  /// Dialog padding
  final EdgeInsets? padding;

  /// Dialog width (null for default)
  final double? width;

  /// Dialog max width
  final double? maxWidth;

  /// Dialog height (null for content-based)
  final double? height;

  /// Whether dialog should consume taps
  final bool consumeOutsideTap;

  const DialogConfig({
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
    this.barrierDismissible = true,
    this.barrierColor,
    this.backgroundColor,
    this.borderRadius = 16,
    this.elevation,
    this.customContent,
    this.customTitle,
    this.customActions,
    this.padding,
    this.width,
    this.maxWidth,
    this.height,
    this.consumeOutsideTap = false,
  });

  /// Get default config for each dialog type
  factory DialogConfig.getDefault(DialogType type) {
    switch (type) {
      // Authentication dialogs
      case DialogType.login:
        return const DialogConfig(
          barrierDismissible: true,
          barrierColor: Color(0x80000000),
          backgroundColor: UIColors.white,
          borderRadius: 16,
          padding: EdgeInsets.all(24),
        );

      case DialogType.register:
        return const DialogConfig(
          barrierDismissible: true,
          barrierColor: Color(0x80000000),
          backgroundColor: UIColors.white,
          borderRadius: 16,
          padding: EdgeInsets.all(24),
        );

      case DialogType.forgotPassword:
        return const DialogConfig(
          title: 'Quên mật khẩu',
          message: 'Nhập email để nhận liên kết đặt lại mật khẩu',
          confirmText: 'Gửi',
          cancelText: 'Hủy',
          barrierDismissible: true,
        );

      case DialogType.otpVerification:
        return const DialogConfig(
          title: 'Xác thực OTP',
          message: 'Nhập mã OTP đã được gửi đến điện thoại của bạn',
          confirmText: 'Xác nhận',
          cancelText: 'Hủy',
          barrierDismissible: false,
        );

      // Confirmation dialogs
      case DialogType.confirmation:
        return const DialogConfig(
          title: 'Xác nhận',
          confirmText: 'Đồng ý',
          cancelText: 'Hủy',
          barrierDismissible: true,
        );

      case DialogType.deleteConfirmation:
        return const DialogConfig(
          title: 'Xác nhận xóa',
          message: 'Bạn có chắc muốn xóa mục này không?',
          confirmText: 'Xóa',
          cancelText: 'Hủy',
          barrierDismissible: true,
        );

      case DialogType.logoutConfirmation:
        return const DialogConfig(
          title: 'Đăng xuất',
          message: 'Bạn có chắc muốn đăng xuất không?',
          confirmText: 'Đăng xuất',
          cancelText: 'Hủy',
          barrierDismissible: true,
        );

      // Information dialogs
      case DialogType.info:
        return const DialogConfig(
          title: 'Thông báo',
          confirmText: 'Đóng',
          barrierDismissible: true,
        );

      case DialogType.success:
        return const DialogConfig(
          title: 'Thành công',
          confirmText: 'Đóng',
          barrierDismissible: true,
        );

      case DialogType.warning:
        return const DialogConfig(
          title: 'Cảnh báo',
          confirmText: 'Đồng ý',
          barrierDismissible: true,
        );

      case DialogType.error:
        return const DialogConfig(
          title: 'Lỗi',
          confirmText: 'Đóng',
          barrierDismissible: true,
        );

      // Product dialogs
      case DialogType.productDetails:
        return const DialogConfig(
          barrierDismissible: true,
          backgroundColor: UIColors.white,
          borderRadius: 16,
          padding: EdgeInsets.all(16),
        );

      case DialogType.addToCartSuccess:
        return const DialogConfig(
          title: 'Thành công',
          message: 'Đã thêm sản phẩm vào giỏ hàng',
          confirmText: 'Tiếp tục mua',
          cancelText: 'Xem giỏ hàng',
          barrierDismissible: true,
        );

      case DialogType.outOfStock:
        return const DialogConfig(
          title: 'Hết hàng',
          message: 'Sản phẩm này hiện đã hết hàng',
          confirmText: 'Đóng',
          barrierDismissible: true,
        );

      // Order dialogs
      case DialogType.orderConfirmation:
        return const DialogConfig(
          title: 'Xác nhận đơn hàng',
          confirmText: 'Xác nhận',
          cancelText: 'Hủy',
          barrierDismissible: true,
        );

      case DialogType.orderSuccess:
        return const DialogConfig(
          title: 'Đặt hàng thành công',
          message: 'Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ liên hệ sớm.',
          confirmText: 'Tiếp tục mua',
          cancelText: 'Xem đơn hàng',
          barrierDismissible: false,
        );

      case DialogType.orderCancel:
        return const DialogConfig(
          title: 'Hủy đơn hàng',
          message: 'Bạn có chắc muốn hủy đơn hàng này không?',
          confirmText: 'Hủy đơn',
          cancelText: 'Không',
          barrierDismissible: true,
        );

      // Settings dialogs
      case DialogType.language:
        return const DialogConfig(
          title: 'Chọn ngôn ngữ',
          cancelText: 'Đóng',
          barrierDismissible: true,
        );

      case DialogType.notification:
        return const DialogConfig(
          title: 'Cài đặt thông báo',
          cancelText: 'Đóng',
          barrierDismissible: true,
        );

      case DialogType.privacy:
        return const DialogConfig(
          title: 'Chính sách bảo mật',
          cancelText: 'Đóng',
          barrierDismissible: true,
        );

      // Custom dialog
      case DialogType.custom:
        return const DialogConfig(
          barrierDismissible: true,
          backgroundColor: UIColors.white,
          borderRadius: 16,
        );
    }
  }

  /// Create a copy with modified fields
  DialogConfig copyWith({
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool? barrierDismissible,
    Color? barrierColor,
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
    Widget? customContent,
    Widget? customTitle,
    List<Widget>? customActions,
    EdgeInsets? padding,
    double? width,
    double? maxWidth,
    double? height,
    bool? consumeOutsideTap,
  }) {
    return DialogConfig(
      title: title ?? this.title,
      message: message ?? this.message,
      confirmText: confirmText ?? this.confirmText,
      cancelText: cancelText ?? this.cancelText,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      customContent: customContent ?? this.customContent,
      customTitle: customTitle ?? this.customTitle,
      customActions: customActions ?? this.customActions,
      padding: padding ?? this.padding,
      width: width ?? this.width,
      maxWidth: maxWidth ?? this.maxWidth,
      height: height ?? this.height,
      consumeOutsideTap: consumeOutsideTap ?? this.consumeOutsideTap,
    );
  }
}
