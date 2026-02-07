import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/constants/otp_scopes.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_images.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/core/ui/widgets/buttons/ui_button.dart';
import 'package:happyco/core/ui/widgets/inputs/ui_text_input.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/utils/validators/auth_validators.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

/// Forgot password Dialog
class ForgotPasswordDialog extends StatefulWidget {
  final DialogConfig config;
  final VoidCallback? onOtpSent;

  const ForgotPasswordDialog({
    super.key,
    required this.config,
    this.onOtpSent,
  });

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _emailError = AuthValidators.validateEmail(_emailController.text);
    });

    if (_emailError == null) {
      final bloc = context.read<AuthBloc>();
      bloc.add(OnForgotPassword(email: _emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent) {
          final dialogService = GetIt.I<DialogService>();
          dialogService.close();
          dialogService.show(
            DialogType.otpVerification,
            config:
                DialogConfig.getDefault(DialogType.otpVerification).copyWith(
              extra: {
                'email': _emailController.text,
                'scope': OtpScopes.forgotPassword,
              },
            ),
          );
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
              title: 'Quên mật khẩu',
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.primary,
            ),
            SizedBox(height: UISizes.height.h12),
            const UIText(
              title:
                  'Vui lòng nhập Email bạn đã đăng ký để nhận mã OTP khôi phục mật khẩu của bạn!',
              titleColor: UIColors.textSecondary,
            ),
            SizedBox(height: UISizes.height.h12),
            UITextInput(
              controller: _emailController,
              focusNode: _emailFocusNode,
              label: 'Email',
              placeholder: 'Vui lòng nhập',
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              errorMessage: _emailError,
              onChanged: (_) {
                if (_emailError != null) {
                  setState(() => _emailError = null);
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
          ],
        ),
      ),
    );
  }
}
