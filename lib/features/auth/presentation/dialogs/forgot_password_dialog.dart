import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_sub_text.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onSuggest;

  const ForgotPasswordDialog({super.key, required this.config, this.onSuggest});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UISizes.width.w358,
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(UISizes.square.r24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo placeholder (109x52)
          SizedBox(
            width: UISizes.width.w109,
            height: UISizes.height.h52,
            child: Center(
              child: UIText(
                title: 'LOGO',
                titleSize: UISizes.font.sp20,
                titleColor: UIColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: UISizes.height.h16),

          // Title
          UIText(
            title: 'Quên mật khẩu',
            titleSize: UISizes.font.sp18,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.primary,
          ),

          SizedBox(height: UISizes.height.h12),
          const UIText(
            title: 'Vui lòng nhập Email bạn đã đăng ký để nhận mã OTP khôi phục mật khẩu của bạn!',
            titleColor: UIColors.textSecondary,
            ),
          SizedBox(height: UISizes.height.h8),
          // New Password input
          const UITextInput(
            label: 'Số điện thoại',
            placeholder: 'Vui lòng nhập',
            isRequired: true,
            obscureText: true,
            showPasswordToggle: true,
          ),

          SizedBox(height: UISizes.height.h12),

          // Suggest button
          UIButton(
            text: 'Xác nhận',
            onPressed: widget.onSuggest,
            style: UIButtonStyle.primary,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
