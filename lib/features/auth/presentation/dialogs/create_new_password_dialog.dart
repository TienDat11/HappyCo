import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/utils/validators/auth_validators.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

/// Create new password Dialog
class CreateNewPasswordDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onSuccess;
  final VoidCallback? onBackToLogin;

  const CreateNewPasswordDialog({
    super.key,
    required this.config,
    this.onSuccess,
    this.onBackToLogin,
  });

  @override
  State<CreateNewPasswordDialog> createState() =>
      _CreateNewPasswordDialogState();
}

class _CreateNewPasswordDialogState extends State<CreateNewPasswordDialog> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();

  String? _passwordError;
  String? _confirmError;

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _passwordError =
          AuthValidators.validateStrongPassword(_passwordController.text);
      _confirmError = AuthValidators.validateConfirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });

    if (_passwordError == null && _confirmError == null) {
      final bloc = context.read<AuthBloc>();
      // Get email from previous state or config
      final email = widget.config.extra?['email'] ?? '';
      bloc.add(OnResetPassword(
        email: email,
        token: widget.config.extra?['token'] ?? '',
        newPassword: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          widget.onSuccess?.call();
          // Dialog is closed via _closeAllAndShowLogin() in AppDialog
          // No need for additional Navigator.pop() here
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Container(
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
                child: Image.asset(
                  UIImages.logo,
                  width: UISizes.width.w109,
                  height: UISizes.height.h52,
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
            SizedBox(height: UISizes.height.h12),
            UITextInput(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              label: 'Mật khẩu mới',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              obscureText: !_isPasswordVisible,
              showPasswordToggle: true,
              errorMessage: _passwordError,
              onChanged: (_) {
                if (_passwordError != null) {
                  setState(() => _passwordError = null);
                }
              },
            ),
            SizedBox(height: UISizes.height.h8),
            UITextInput(
              controller: _confirmPasswordController,
              focusNode: _confirmFocusNode,
              label: 'Nhập lại mật khẩu',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              obscureText: !_isConfirmVisible,
              showPasswordToggle: true,
              errorMessage: _confirmError,
              onChanged: (_) {
                if (_confirmError != null) {
                  setState(() => _confirmError = null);
                }
              },
            ),
            SizedBox(height: UISizes.height.h16),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return UIButton(
                  text: 'Xác nhận',
                  onPressed: isLoading ? null : _validateAndSubmit,
                  style: UIButtonStyle.primary,
                  isFullWidth: true,
                );
              },
            ),
            SizedBox(height: UISizes.height.h12),
            GestureDetector(
              onTap: widget.onBackToLogin,
              child: UIText(
                title: 'Quay lại đăng nhập',
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
