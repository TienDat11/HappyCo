part of 'auth_bloc.dart';

/// Auth States
sealed class AuthState extends BaseBlocState {
  AuthState();
}

class AuthInitial extends AuthState implements InitialState {
  AuthInitial();
}

class AuthLoading extends AuthState implements LoadingState {
  AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  AuthAuthenticated({required this.user});
}

class AuthUnauthenticated extends AuthState {
  AuthUnauthenticated();
}

class AuthError extends AuthState implements ErrorState {
  @override
  final String error;

  AuthError({required this.error});
}

class AuthFieldError extends AuthState implements ErrorState {
  @override
  final String error;
  final Map<String, String> fieldErrors;

  AuthFieldError(this.error, {this.fieldErrors = const {}});
}

class OtpSent extends AuthState {
  final String email;

  OtpSent({required this.email});
}

class OtpVerified extends AuthState {
  final String email;
  final String resetToken;

  OtpVerified({required this.email, required this.resetToken});
}

class PasswordResetSuccess extends AuthState {
  PasswordResetSuccess();
}
