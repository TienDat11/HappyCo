import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/constants/otp_scopes.dart';
import 'package:happyco/core/services/dialog_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';
import 'package:happyco/features/auth/presentation/dialogs/create_new_password_dialog.dart';
import 'package:happyco/features/auth/presentation/dialogs/forgot_password_dialog.dart';
import 'package:happyco/features/auth/presentation/dialogs/login_dialog.dart';
import 'package:happyco/features/auth/presentation/dialogs/otp_verify_dialog.dart';
import 'package:happyco/features/auth/presentation/dialogs/register_dialog.dart';

/// Base App Dialog Widget
///
/// Provides consistent dialog styling and auth flow integration
class AppDialog extends StatelessWidget {
  final DialogType type;
  final DialogConfig config;
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

    return BlocProvider(
      create: (_) => GetIt.I<AuthBloc>(),
      child: Dialog(
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

    switch (type) {
      case DialogType.login:
        return _buildLoginContent();
      case DialogType.register:
        return _buildRegisterContent();
      case DialogType.otpVerification:
        return _buildOtpContent();
      case DialogType.forgotPassword:
        return _buildForgotPasswordContent();
      case DialogType.createNewPassword:
        return _buildCreatePasswordContent();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLoginContent() {
    return LoginDialog(
      config: config,
      onLoginSuccess: () {
        onDismiss?.call();
      },
      onForgotPassword: () {
        _navigateToDialog(DialogType.forgotPassword);
      },
      onRegister: () {
        _navigateToDialog(DialogType.register);
      },
    );
  }

  Widget _buildRegisterContent() {
    return RegisterDialog(
      config: config,
      onRegistered: (email) {
        final nextConfig =
            DialogConfig.getDefault(DialogType.otpVerification).copyWith(
          extra: {
            'email': email,
            'scope': OtpScopes.confirmEmail,
          },
        );
        _navigateToDialog(DialogType.otpVerification, config: nextConfig);
      },
      onLogin: () {
        _navigateToDialog(DialogType.login);
      },
    );
  }

  Widget _buildOtpContent() {
    final extra = config.extra ?? {};
    final scope = extra['scope'] ?? OtpScopes.confirmEmail;
    return OtpVerifyDialog(
      config: config,
      email: extra['email'] ?? '',
      scope: scope,
      onVerified: () {
        final dialogService = GetIt.I<DialogService>();

        if (scope == OtpScopes.confirmEmail) {
          dialogService.closeAll();
          dialogService.show(DialogType.login);
          return;
        }

        final authBloc = GetIt.I<AuthBloc>();
        final currentState = authBloc.state;

        String resetToken = '';
        if (currentState is OtpVerified) {
          resetToken = currentState.resetToken;
        }

        dialogService.show(
          DialogType.createNewPassword,
          config:
              DialogConfig.getDefault(DialogType.createNewPassword).copyWith(
            extra: {
              'email': extra['email'] ?? '',
              'token': resetToken,
            },
          ),
        );
      },
      onBack: () {
        GetIt.I<DialogService>().close();
      },
    );
  }

  Widget _buildForgotPasswordContent() {
    return ForgotPasswordDialog(
      config: config,
      onOtpSent: () {},
    );
  }

  Widget _buildCreatePasswordContent() {
    return CreateNewPasswordDialog(
      config: config,
      onSuccess: () {
        _closeAllAndShowLogin();
      },
      onBackToLogin: () {
        _navigateToDialog(DialogType.login);
      },
    );
  }

  void _navigateToDialog(DialogType nextType, {DialogConfig? config}) {
    final dialogService = GetIt.I<DialogService>();
    dialogService.close();
    dialogService.show(nextType, config: config);
  }

  void _closeAllAndShowLogin() {
    final dialogService = GetIt.I<DialogService>();
    dialogService.closeAll();
    dialogService.show(DialogType.login);
  }
}
