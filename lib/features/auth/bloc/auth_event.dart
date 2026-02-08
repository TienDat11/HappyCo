part of 'auth_bloc.dart';

/// Auth Events
sealed class AuthEvent extends BaseEvent {
  AuthEvent();
}

class OnAuthInitialize extends AuthEvent {
  OnAuthInitialize();
}

class OnLogin extends AuthEvent {
  final String username;
  final String password;

  OnLogin({required this.username, required this.password});
}

class OnRegister extends AuthEvent {
  final String username;
  final String password;
  final String fullName;
  final String phone;
  final String? email;

  OnRegister({
    required this.username,
    required this.password,
    required this.fullName,
    required this.phone,
    this.email,
  });
}

class OnForgotPassword extends AuthEvent {
  final String email;

  OnForgotPassword({required this.email});
}

class OnVerifyOtp extends AuthEvent {
  final String email;
  final String code;
  final String scope;

  OnVerifyOtp({required this.email, required this.code, required this.scope});
}

class OnRefreshOtp extends AuthEvent {
  final String email;

  OnRefreshOtp({required this.email});
}

class OnResetPassword extends AuthEvent {
  final String email;
  final String token;
  final String newPassword;

  OnResetPassword({
    required this.email,
    required this.token,
    required this.newPassword,
  });
}

class OnLogout extends AuthEvent {
  OnLogout();
}

class OnCheckAuthStatus extends AuthEvent {
  OnCheckAuthStatus();
}
