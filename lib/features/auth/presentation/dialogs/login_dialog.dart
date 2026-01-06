import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Login Dialog
class LoginDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onRegister;

  const LoginDialog({
    super.key,
    required this.config,
    this.onLogin,
    this.onForgotPassword,
    this.onRegister,
  });

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
          // Logo placeholder (109x52)
          SizedBox(
            width: 109,
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
            title: 'Đăng nhập ngay!',
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

          // Password input
          const UITextInput(
            label: 'Mật khẩu',
            placeholder: 'Vui lòng nhập',
            isRequired: true,
            obscureText: true,
            showPasswordToggle: true,
          ),

          SizedBox(height: UISizes.height.h12),

          // Remember me and forgot password row
          Row(
            children: [
              // Remember me toggle
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Container(
                      width: UISizes.width.w36,
                      height: UISizes.height.h20,
                      decoration: BoxDecoration(
                        color:
                            _rememberMe ? UIColors.primary : UIColors.gray200,
                        borderRadius: BorderRadius.circular(UISizes.square.r100),
                      ),
                      child: Align(
                        alignment: _rememberMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: UISizes.width.w16,
                          height: UISizes.width.w16,
                          decoration: const BoxDecoration(
                            color: UIColors.white,
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.all(UISizes.width.w2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: UISizes.width.w8),
                  UIText(
                    title: 'Nhớ tài khoản',
                    titleSize: UISizes.font.sp14,
                    titleColor: UIColors.gray500,
                  ),
                ],
              ),

              const Spacer(),

              // Forgot password link
              GestureDetector(
                onTap: widget.onForgotPassword,
                child: UIText(
                  title: 'Quên mật khẩu?',
                  titleSize: UISizes.font.sp14,
                  titleColor: UIColors.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: UISizes.height.h12),

          // Login button
          UIButton(
            text: 'Đăng nhập ngay!',
            onPressed: widget.onLogin,
            style: UIButtonStyle.primary,
            isFullWidth: true,
          ),

          SizedBox(height: UISizes.height.h12),

          // Register link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIText(
                title: 'Bạn chưa có tài khoản?',
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.gray700,
              ),
              SizedBox(width: UISizes.width.w8),
              GestureDetector(
                onTap: widget.onRegister,
                child: UIText(
                  title: 'Đăng ký ngay!',
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
    );
  }
}
