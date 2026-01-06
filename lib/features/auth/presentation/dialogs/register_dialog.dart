import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Register Dialog
class RegisterDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onRegister;
  final VoidCallback? onLogin;

  const RegisterDialog({
    super.key,
    required this.config,
    this.onRegister,
    this.onLogin,
  });

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo placeholder (109x52)
            Container(
              width: UISizes.width.w109,
              height: UISizes.height.h52,
              margin: EdgeInsets.only(top: UISizes.height.h8),
              decoration: BoxDecoration(
                color: UIColors.gray100,
                borderRadius: BorderRadius.circular(UISizes.square.r8),
              ),
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
              title: 'Đăng ký',
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.primary,
            ),

            SizedBox(height: UISizes.height.h12),

            // Phone input
            UITextInput(
              label: 'Số điện thoại',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            SizedBox(height: UISizes.height.h8),

            // Email input
            const UITextInput(
              label: 'Email',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: UISizes.height.h8),

            // Password input
            const UITextInput(
              label: 'Mật khẩu',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              obscureText: true,
              showPasswordToggle: true,
            ),

            SizedBox(height: UISizes.height.h8),

            // Confirm password input
            const UITextInput(
              label: 'Xác nhận mật khẩu',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              obscureText: true,
              showPasswordToggle: true,
            ),

            SizedBox(height: UISizes.height.h12),

            // Register button
            UIButton(
              text: 'Đăng ký ngay!',
              onPressed: widget.onRegister,
              style: UIButtonStyle.primary,
              isFullWidth: true,
            ),

            SizedBox(height: UISizes.height.h12),

            // Login link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UIText(
                  title: 'Bạn đã có tài khoản?',
                  titleSize: UISizes.font.sp14,
                  titleColor: UIColors.gray700,
                ),
                SizedBox(width: UISizes.width.w8),
                GestureDetector(
                  onTap: widget.onLogin,
                  child: UIText(
                    title: 'Đăng nhập ngay!',
                    titleSize: UISizes.font.sp14,
                    titleColor: UIColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: UISizes.height.h8),
          ],
        ),
      ),
    );
  }
}
