import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/base_bloc.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';
import 'package:happyco/core/exceptions/auth_exception.dart';
import 'package:happyco/domain/entities/user_entity.dart';
import 'package:happyco/domain/repositories/auth_repository.dart';
import 'package:happyco/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:happyco/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:happyco/domain/usecases/auth/login_usecase.dart';
import 'package:happyco/domain/usecases/auth/logout_usecase.dart';
import 'package:happyco/domain/usecases/auth/register_usecase.dart';
import 'package:happyco/domain/usecases/auth/refresh_otp_usecase.dart';
import 'package:happyco/domain/usecases/auth/reset_password_usecase.dart';
import 'package:happyco/domain/usecases/auth/verify_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Auth Bloc
///
/// Handles authentication state management for login, register, password recovery.
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final RefreshOtpUseCase _refreshOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final AuthRepository _authRepository;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required RefreshOtpUseCase refreshOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required LogoutUseCase logoutUseCase,
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _refreshOtpUseCase = refreshOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _logoutUseCase = logoutUseCase,
        _checkAuthStatusUseCase = checkAuthStatusUseCase,
        _authRepository = authRepository,
        super(AuthInitial()) {
    on<OnAuthInitialize>(_onAuthInitialize);
    on<OnLogin>(_onLogin);
    on<OnRegister>(_onRegister);
    on<OnForgotPassword>(_onForgotPassword);
    on<OnVerifyOtp>(_onVerifyOtp);
    on<OnRefreshOtp>(_onRefreshOtp);
    on<OnResetPassword>(_onResetPassword);
    on<OnLogout>(_onLogout);
    on<OnCheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onAuthInitialize(
    OnAuthInitialize event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = _authRepository.isLoggedIn();
    if (isLoggedIn) {
      try {
        final user = await _authRepository.getCurrentUser();
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(OnLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _loginUseCase.exec(
        LoginParams(
          username: event.username,
          password: event.password,
        ),
      );
      final user = await _authRepository.getCurrentUser();
      emit(AuthAuthenticated(user: user));
    } on AuthException catch (e, stackTrace) {
      emitError(
        emit,
        AuthFieldError(e.message, fieldErrors: e.fieldErrors ?? {}),
        e,
        stackTrace,
      );
    } catch (e, stackTrace) {
      final message = e.toString().replaceAll('Exception: ', '');
      emitError(emit, AuthError(error: message), e, stackTrace);
    }
  }

  Future<void> _onRegister(OnRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _registerUseCase.exec(
        RegisterParams(
          username: event.username,
          password: event.password,
          fullName: event.fullName,
          phone: event.phone,
          email: event.email,
        ),
      );
      final otpTarget = (event.email != null && event.email!.isNotEmpty)
          ? event.email!
          : event.username;
      // After successful registration, redirect to OTP verification
      emit(OtpSent(email: otpTarget));
    } on AuthException catch (e, stackTrace) {
      emitError(
        emit,
        AuthFieldError(e.message, fieldErrors: e.fieldErrors ?? {}),
        e,
        stackTrace,
      );
    } catch (e, stackTrace) {
      final message = e.toString().replaceAll('Exception: ', '');
      emitError(emit, AuthError(error: message), e, stackTrace);
    }
  }

  Future<void> _onForgotPassword(
    OnForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _forgotPasswordUseCase.exec(
        ForgotPasswordParams(email: event.email),
      );
      emit(OtpSent(email: event.email));
    } catch (e, stackTrace) {
      emitError(emit, AuthError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _onVerifyOtp(OnVerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final resetToken = await _verifyOtpUseCase.exec(
        VerifyOtpParams(
          email: event.email,
          code: event.code,
          scope: event.scope,
        ),
      );
      // Emit verified state with token for password reset flow
      emit(OtpVerified(email: event.email, resetToken: resetToken));
    } catch (e, stackTrace) {
      emitError(emit, AuthError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _onRefreshOtp(
      OnRefreshOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _refreshOtpUseCase.exec(
        RefreshOtpParams(email: event.email),
      );
      // Re-emit OtpSent state to reset timer
      emit(OtpSent(email: event.email));
    } catch (e, stackTrace) {
      emitError(emit, AuthError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _onResetPassword(
    OnResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _resetPasswordUseCase.exec(
        ResetPasswordParams(
          email: event.email,
          token: event.token,
          newPassword: event.newPassword,
        ),
      );
      emit(PasswordResetSuccess());
    } catch (e, stackTrace) {
      emitError(emit, AuthError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _onLogout(OnLogout event, Emitter<AuthState> emit) async {
    try {
      await _logoutUseCase.exec();
      emit(AuthUnauthenticated());
    } catch (e, stackTrace) {
      emitError(emit, AuthError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _onCheckAuthStatus(
    OnCheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = _authRepository.isLoggedIn();
    if (isLoggedIn) {
      try {
        final user = await _authRepository.getCurrentUser();
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
