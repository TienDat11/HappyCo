import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// OTP verift password Dialog
class OtpVerifyDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onConfirm;

  const OtpVerifyDialog({
    super.key,
    required this.config,
    this.onConfirm,
  });

  @override
  State<OtpVerifyDialog> createState() => _OtpVerifyDialogState();
}

class _OtpVerifyDialogState extends State<OtpVerifyDialog> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  static const int otpLength = 4;

  final List<FocusNode> _focusNodes =
      List.generate(otpLength, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UISizes.width.w358,
      padding: EdgeInsets.all(UISizes.width.w16),
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(UISizes.square.r24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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

          UIText(
            title: 'Nhập mã OTP',
            titleSize: UISizes.font.sp18,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.primary,
          ),

          SizedBox(height: UISizes.height.h12),

          const UIText(
            title:
                'Nhập mã OTP đã được gửi email của bạn để tạo lại mật khẩu mới.',
            titleColor: UIColors.textSecondary,
          ),

          SizedBox(height: UISizes.height.h16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              otpLength,
              (index) => _buildOtpBox(index),
            ),
          ),

          SizedBox(height: UISizes.height.h24),

          UIButton(
            text: 'Xác nhận',
            onPressed: widget.onConfirm,
            style: UIButtonStyle.primary,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: UISizes.width.w56,
      height: UISizes.height.h56,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: UISizes.font.sp20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: UIColors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UISizes.square.r12),
            borderSide: const BorderSide(color: UIColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UISizes.square.r12),
            borderSide: const BorderSide(color: UIColors.primary),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }
}
