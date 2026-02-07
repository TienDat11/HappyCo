import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/auth_footer.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/utils/extensions/context_extensions.dart';
import 'package:happyco/core/utils/validators/auth_validators.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

/// Register Dialog
class RegisterDialog extends StatefulWidget {
  final DialogConfig config;
  final ValueChanged<String>? onRegistered;
  final VoidCallback? onLogin;

  const RegisterDialog({
    super.key,
    required this.config,
    this.onRegistered,
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
  final _fullNameController = TextEditingController();

  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();
  final _fullNameFocusNode = FocusNode();

  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;
  String? _fullNameError;

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    _fullNameFocusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _phoneError = AuthValidators.validatePhone(_phoneController.text);
      _emailError = AuthValidators.validateEmail(_emailController.text);
      _fullNameError =
          AuthValidators.validateFullName(_fullNameController.text);
      _passwordError =
          AuthValidators.validateStrongPassword(_passwordController.text);
      _confirmError = AuthValidators.validateConfirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });

    if (_phoneError == null &&
        _emailError == null &&
        _fullNameError == null &&
        _passwordError == null &&
        _confirmError == null) {
      final bloc = context.read<AuthBloc>();
      bloc.add(OnRegister(
        username: _phoneController.text, // username = phone per API spec
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phone: _phoneController.text,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent) {
          // After successful registration, navigate to OTP verification
          widget.onRegistered?.call(state.email);
        } else if (state is AuthFieldError) {
          setState(() {
            _phoneError =
                state.fieldErrors['phone'] ?? state.fieldErrors['username'];
            _emailError = state.fieldErrors['email'];
            _passwordError = state.fieldErrors['password'];
            _fullNameError = state.fieldErrors['fullName'] ??
                state.fieldErrors['fullname'] ??
                state.fieldErrors['name'];
          });
        } else if (state is AuthError) {
          final message = state.error;
          final cleanMessage = message.replaceAll('Exception: ', '');
          context.clearSnackBars();
          context.showError(cleanMessage);
        }
      },
      child: Container(
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
              Container(
                width: UISizes.width.w109,
                height: UISizes.height.h52,
                margin: EdgeInsets.only(top: UISizes.height.h8),
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
                title: 'Đăng ký',
                titleSize: UISizes.font.sp18,
                fontWeight: FontWeight.bold,
                titleColor: UIColors.primary,
              ),

              SizedBox(height: UISizes.height.h12),

              // Full Name input
              UITextInput(
                controller: _fullNameController,
                focusNode: _fullNameFocusNode,
                label: 'Họ và tên',
                placeholder: 'Vui lòng nhập',
                isRequired: true,
                errorMessage: _fullNameError,
                semanticLabel: 'Nhập họ và tên',
                onChanged: (_) {
                  if (_fullNameError != null) {
                    setState(() => _fullNameError = null);
                  }
                },
              ),

              SizedBox(height: UISizes.height.h8),

              // Phone input
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
                onChanged: (_) {
                  if (_phoneError != null) {
                    setState(() => _phoneError = null);
                  }
                },
              ),

              SizedBox(height: UISizes.height.h8),

              // Email input
              UITextInput(
                controller: _emailController,
                focusNode: _emailFocusNode,
                label: 'Email',
                placeholder: 'Vui lòng nhập',
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                errorMessage: _emailError,
                semanticLabel: 'Nhập email',
                onChanged: (_) {
                  if (_emailError != null) {
                    setState(() => _emailError = null);
                  }
                },
              ),

              SizedBox(height: UISizes.height.h8),

              // Password input
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

              SizedBox(height: UISizes.height.h8),

              // Confirm password input
              UITextInput(
                controller: _confirmPasswordController,
                focusNode: _confirmFocusNode,
                label: 'Xác nhận mật khẩu',
                placeholder: 'Vui lòng nhập',
                isRequired: true,
                obscureText: !_isConfirmVisible,
                showPasswordToggle: true,
                errorMessage: _confirmError,
                semanticLabel: 'Nhập lại mật khẩu',
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
                    text: 'Đăng ký ngay!',
                    onPressed: isLoading ? null : _validateAndSubmit,
                    style: UIButtonStyle.primary,
                    isFullWidth: true,
                  );
                },
              ),

              SizedBox(height: UISizes.height.h12),

              // Login link
              AuthFooter(
                leftText: 'Bạn đã có tài khoản?',
                rightText: 'Đăng nhập ngay!',
                onLinkTap: widget.onLogin,
              ),

              SizedBox(height: UISizes.height.h8),
            ],
          ),
        ),
      ),
    );
  }
}
