import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/features/auth/presentation/dialogs/login_dialog.dart';
import 'package:happyco/features/auth/presentation/dialogs/register_dialog.dart';

/// Base App Dialog Widget
///
/// Provides consistent dialog styling across the app
/// Handles lifecycle, animations, and content rendering
class AppDialog extends StatelessWidget {
  /// Dialog type
  final DialogType type;

  /// Dialog configuration
  final DialogConfig config;

  /// Callback when dialog is dismissed
  final VoidCallback? onDismiss;

  const AppDialog({
    super.key,
    required this.type,
    required this.config,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final dialogContent = _buildDialogContent();

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: type == DialogType.productDetails ? 16 : 40,
        vertical: 24,
      ),
      child: Container(
        width: config.width,
        constraints: BoxConstraints(
          maxWidth: config.maxWidth ?? 400,
          minHeight: config.height ?? 100,
        ),
        decoration: BoxDecoration(
          color: config.backgroundColor ?? UIColors.white,
          borderRadius: BorderRadius.circular(config.borderRadius),
          boxShadow: [
            BoxShadow(
              color: UIColors.shadowMedium,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: dialogContent,
      ),
    );
  }

  Widget _buildDialogContent() {
    if (config.customContent != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(config.borderRadius),
        child: config.customContent,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (config.customTitle != null || config.title != null)
          _buildHeader(),

        Flexible(
          child: Padding(
            padding: config.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _buildBody(),
          ),
        ),

        if (config.customActions != null ||
            config.confirmText != null || config.cancelText != null)
          _buildActions(),
      ],
    );
  }

  Widget _buildHeader() {
    if (config.customTitle != null) {
      return config.customTitle!;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          Expanded(
            child: UIText(
              title: config.title ?? '',
              titleSize: 20,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.gray900,
            ),
          ),
          if (config.barrierDismissible)
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(
                Icons.close,
                color: UIColors.gray500,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (config.message != null) {
      return UIText(
        title: config.message!,
        titleSize: 14,
        titleColor: UIColors.gray700,
      );
    }

    switch (type) {
      case DialogType.login:
        return _buildLoginContent();
      case DialogType.register:
        return _buildRegisterContent();
      case DialogType.otpVerification:
        return _buildOtpContent();
      case DialogType.forgotPassword:
        return _buildForgotPasswordContent();
      case DialogType.productDetails:
        return _buildProductDetailsContent();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildActions() {
    if (config.customActions != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: config.customActions!,
        ),
      );
    }

    final children = <Widget>[];

    if (config.cancelText != null) {
      children.add(
        TextButton(
          onPressed: () => onDismiss?.call(),
          child: UIText(
            title: config.cancelText!,
            titleColor: UIColors.gray600,
            titleSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (config.confirmText != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: 8));
      }
      children.add(
        ElevatedButton(
          onPressed: () => onDismiss?.call(),
          style: ElevatedButton.styleFrom(
            backgroundColor: UIColors.primary,
            foregroundColor: UIColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: UIText(
            title: config.confirmText!,
            titleColor: UIColors.white,
            titleSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }

  Widget _buildLoginContent() {
    return LoginDialog(
      config: config,
      onRegister: () => onDismiss?.call(),
    );
  }

  Widget _buildRegisterContent() {
    return RegisterDialog(
      config: config,
      onLogin: () => onDismiss?.call(),
    );
  }

  Widget _buildOtpContent() {
    return const Center(
      child: UIText(
        title: 'OTP input will be implemented here',
        titleColor: UIColors.gray500,
      ),
    );
  }

  Widget _buildForgotPasswordContent() {
    return const Center(
      child: UIText(
        title: 'Email input will be implemented here',
        titleColor: UIColors.gray500,
      ),
    );
  }

  Widget _buildProductDetailsContent() {
    return const Center(
      child: UIText(
        title: 'Product details will be implemented here',
        titleColor: UIColors.gray500,
      ),
    );
  }
}
