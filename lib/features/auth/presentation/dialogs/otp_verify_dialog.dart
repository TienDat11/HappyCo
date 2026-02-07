import 'dart:async';

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
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/utils/validators/auth_validators.dart';
import 'package:happyco/features/auth/bloc/auth_bloc.dart';

/// OTP verify password Dialog
class OtpVerifyDialog extends StatefulWidget {
  final DialogConfig config;
  final String email;
  final String scope; // OTP scope: confirm_email, forgot_passwd, etc.
  final VoidCallback? onVerified;
  final VoidCallback? onBack;

  const OtpVerifyDialog({
    super.key,
    required this.config,
    required this.email,
    required this.scope,
    this.onVerified,
    this.onBack,
  });

  @override
  State<OtpVerifyDialog> createState() => _OtpVerifyDialogState();
}

class _OtpVerifyDialogState extends State<OtpVerifyDialog> {
  final List<TextEditingController> _otpControllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  static const int otpLength = 5;
  static const int resendCooldownSeconds = 60;
  static const double _designOtpCount = 4;

  String? _otpError;
  int _resendCountdown = resendCooldownSeconds;
  Timer? _countdownTimer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_resendCountdown > 0) {
            _resendCountdown--;
          } else {
            _canResend = true;
            timer.cancel();
          }
        });
      }
    });
  }

  void _validateAndSubmit() {
    final resolvedEmail = widget.email.trim();
    if (resolvedEmail.isEmpty) {
      setState(() {
        _otpError = 'Không tìm thấy email xác thực. Vui lòng đăng ký lại.';
      });
      return;
    }

    final otpCode = _otpControllers.map((c) => c.text).join();

    setState(() {
      _otpError = AuthValidators.validateOtp(otpCode);
    });

    if (_otpError == null) {
      final bloc = context.read<AuthBloc>();
      bloc.add(OnVerifyOtp(
        email: resolvedEmail,
        code: otpCode,
        scope: widget.scope,
      ));
    }
  }

  void _onResendOtp() {
    if (_canResend) {
      final resolvedEmail = widget.email.trim();
      if (resolvedEmail.isEmpty) {
        setState(() {
          _otpError = 'Không tìm thấy email để gửi lại OTP.';
        });
        return;
      }

      final bloc = context.read<AuthBloc>();
      bloc.add(OnRefreshOtp(email: resolvedEmail));
      setState(() {
        _resendCountdown = resendCooldownSeconds;
        _canResend = false;
      });
      _startCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          // For forgot password flow, OTP verified - show password reset
          widget.onVerified?.call();
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
              title: 'Nhập mã OTP',
              titleSize: UISizes.font.sp18,
              fontWeight: FontWeight.bold,
              titleColor: UIColors.primary,
            ),

            SizedBox(height: UISizes.height.h12),

            UIText(
              title: 'Nhập mã OTP đã được gửi đến ${widget.email}',
              titleColor: UIColors.textSecondary,
            ),

            SizedBox(height: UISizes.height.h16),

            if (_otpError != null) ...[
              UIText(
                title: _otpError!,
                titleColor: UIColors.error,
                titleSize: UISizes.font.sp12,
              ),
              SizedBox(height: UISizes.height.h8),
            ],

            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) {
                  final scaleFactor = _designOtpCount / otpLength;
                  final otpBoxWidth = UISizes.width.w56 * scaleFactor;
                  final otpBoxHeight = UISizes.height.h56 * scaleFactor;
                  final otpBoxSpacing = UISizes.width.w6 * scaleFactor;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      otpLength,
                      (index) => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: otpBoxSpacing),
                        child: _buildOtpBox(index, otpBoxWidth, otpBoxHeight),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: UISizes.height.h24),

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

            // Resend OTP button with countdown
            GestureDetector(
              onTap: _canResend ? _onResendOtp : null,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading &&
                      state != context.read<AuthBloc>().state;
                  if (isLoading) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return UIText(
                    title: _canResend
                        ? 'Gửi lại mã OTP'
                        : 'Gửi lại sau $_resendCountdown giây',
                    titleSize: UISizes.font.sp14,
                    titleColor:
                        _canResend ? UIColors.primary : UIColors.gray500,
                    fontWeight: FontWeight.w500,
                  );
                },
              ),
            ),

            SizedBox(height: UISizes.height.h12),

            GestureDetector(
              onTap: () {
                if (widget.scope == OtpScopes.forgotPassword) {
                  final dialogService = GetIt.I<DialogService>();
                  dialogService.closeAll();
                  dialogService.show(DialogType.login);
                  return;
                }
                widget.onBack?.call();
              },
              child: UIText(
                title: 'Quay lại',
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

  Widget _buildOtpBox(int index, double boxWidth, double boxHeight) {
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: UISizes.font.sp20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: UISizes.width.w8,
            vertical: (boxHeight - UISizes.font.sp20) / 2,
          ),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UISizes.square.r12),
            borderSide: const BorderSide(color: UIColors.error),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < otpLength - 1) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
