part of 'account_bloc.dart';

/// Account States
///
/// UI-specific states for the Account page.
sealed class AccountState extends BaseBlocState {
  AccountState();
}

/// Initial state before checking auth status
class AccountInitial extends AccountState implements InitialState {
  AccountInitial();
}

/// Loading state while checking auth status
class AccountLoading extends AccountState implements LoadingState {
  AccountLoading();
}

/// User is logged in - user data comes from AuthBloc
class AccountLoggedIn extends AccountState {
  AccountLoggedIn();
}

/// User is not logged in
class AccountNotLoggedIn extends AccountState {
  AccountNotLoggedIn();
}

/// Error state
class AccountError extends AccountState implements ErrorState {
  @override
  final String error;

  AccountError({required this.error});
}
