import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';

/// Refresh OTP params
class RefreshOtpParams {
  final String email;

  RefreshOtpParams({required this.email});
}

/// Refresh OTP UseCase
///
/// Used to resend OTP when the original OTP expires or is not received.
class RefreshOtpUseCase extends StatelessUseCase<void, RefreshOtpParams> {
  final AuthRepository repository;

  RefreshOtpUseCase({required this.repository});

  @override
  Future<void> exec(RefreshOtpParams params) =>
      repository.refreshOtp(email: params.email);
}
