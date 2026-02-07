import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/auth_footer.dart';
import 'package:happyco/core/ui/widgets/inputs/toggle_switch.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/utils/validators/auth_validators.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

/// Login Dialog
class LoginDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onLoginSuccess;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onRegister;

  const LoginDialog({
    super.key,
    required this.config,
    this.onLoginSuccess,
    this.onForgotPassword,
    this.onRegister,
  });

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? _phoneError;
  String? _passwordError;
  String? _authErrorMessage;

  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _phoneError = AuthValidators.validatePhone(_phoneController.text);
      _passwordError =
          AuthValidators.validatePassword(_passwordController.text);
      _authErrorMessage = null;
    });

    if (_phoneError == null && _passwordError == null) {
      final bloc = context.read<AuthBloc>();
      bloc.add(OnLogin(
        username: _phoneController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          widget.onLoginSuccess?.call();
          Navigator.of(context).pop();
        } else if (state is AuthFieldError) {
          final usernameError =
              state.fieldErrors['username'] ?? state.fieldErrors['phone'];
          final passwordError = state.fieldErrors['password'];
          final isCredentialFailure = usernameError != null &&
              passwordError != null &&
              usernameError == passwordError;

          setState(() {
            if (isCredentialFailure) {
              _phoneError = null;
              _passwordError = null;
              _authErrorMessage = usernameError;
            } else {
              _phoneError = usernameError;
              _passwordError = passwordError;
              _authErrorMessage = null;
            }
          });
        } else if (state is AuthError) {
          final message = state.error.replaceAll('Exception: ', '');
          setState(() {
            _authErrorMessage = message;
          });
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
              title: 'Đăng nhập ngay!',
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.primary,
            ),

            SizedBox(height: UISizes.height.h12),

            UITextInput(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              label: 'Số điện thoại',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              errorMessage: _phoneError,
              semanticLabel: 'Nhập số điện thoại',
              onChanged: (_) {
                if (_phoneError != null) {
                  setState(() => _phoneError = null);
                }
              },
            ),

            SizedBox(height: UISizes.height.h8),
            UITextInput(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              label: 'Mật khẩu',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              obscureText: !_isPasswordVisible,
              showPasswordToggle: true,
              errorMessage: _passwordError,
              semanticLabel: 'Nhập mật khẩu',
              onChanged: (_) {
                if (_passwordError != null) {
                  setState(() => _passwordError = null);
                }
              },
            ),

            SizedBox(height: UISizes.height.h12),

            // Remember me and forgot password row
            Semantics(
              container: true,
              child: Row(
                children: [
                  ToggleSwitch(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                    label: 'Nhớ tài khoản',
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: widget.onForgotPassword,
                    child: Semantics(
                      label: 'Quên mật khẩu',
                      button: true,
                      child: UIText(
                        title: 'Quên mật khẩu?',
                        titleSize: UISizes.font.sp14,
                        titleColor: UIColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: UISizes.height.h16),

            // Login button
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return UIButton(
                  text: 'Đăng nhập ngay!',
                  onPressed: isLoading ? null : _validateAndSubmit,
                  style: UIButtonStyle.primary,
                  isFullWidth: true,
                );
              },
            ),

            if (_authErrorMessage != null) ...[
              SizedBox(height: UISizes.height.h8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: UISizes.width.w12,
                  vertical: UISizes.height.h10,
                ),
                decoration: BoxDecoration(
                  color: UIColors.red50,
                  borderRadius: BorderRadius.circular(UISizes.square.r12),
                  border:
                      Border.all(color: UIColors.error.withValues(alpha: 0.3)),
                ),
                child: UIText(
                  title: _authErrorMessage!,
                  titleSize: UISizes.font.sp13,
                  titleColor: UIColors.error,
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            SizedBox(height: UISizes.height.h12),

            // Register link
            AuthFooter(
              leftText: 'Bạn chưa có tài khoản?',
              rightText: 'Đăng ký ngay!',
              onLinkTap: widget.onRegister,
            ),

            SizedBox(height: UISizes.height.h8),
          ],
        ),
      ),
    );
  }
}
