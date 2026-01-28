import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Create new password Dialog
class CreateNewPasswordDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onSuggest;

  const CreateNewPasswordDialog(
      {super.key, required this.config, this.onSuggest});

  @override
  State<CreateNewPasswordDialog> createState() =>
      _CreateNewPasswordDialogState();
}

class _CreateNewPasswordDialogState extends State<CreateNewPasswordDialog> {
  final _verifyPassswordContoller = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _verifyPassswordContoller.dispose();
    _passwordController.dispose();
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
            title: 'Tạo mật khẩu mới',
            titleSize: UISizes.font.sp18,
            fontWeight: FontWeight.bold,
            titleColor: UIColors.primary,
          ),

          SizedBox(height: UISizes.height.h12),
          _bulletText('Mật khẩu mới phải có ít nhất 8 ký tự bao gồm:'),
          SizedBox(height: UISizes.height.h8),
          _bulletText('Ít nhất có 1 chữ cái in hoa'),
          SizedBox(height: UISizes.height.h8),
          _bulletText('Ít nhất có 1 chữ số'),
          SizedBox(height: UISizes.height.h8),
          _bulletText('Không chứa các ký tự đặc biệt'),

          SizedBox(height: UISizes.height.h8),
          const UITextInput(
            label: 'Mật khẩu mới',
            placeholder: 'Vui lòng nhập',
            isRequired: true,
            obscureText: true,
            showPasswordToggle: true,
          ),

          SizedBox(height: UISizes.height.h8),

          const UITextInput(
            label: 'Nhập lại mật khẩu',
            placeholder: 'Vui lòng nhập',
            isRequired: true,
            obscureText: true,
            showPasswordToggle: true,
          ),

          SizedBox(height: UISizes.height.h12),

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

  Widget _bulletText(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText(
          title: '•',
          titleSize: UISizes.font.sp14,
          titleColor: UIColors.textSecondary,
        ),
        SizedBox(width: UISizes.width.w6),
        Expanded(
          child: UIText(
            title: text,
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
