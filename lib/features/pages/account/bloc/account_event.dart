part of 'account_bloc.dart';

/// Account Events
///
/// UI-specific events for the Account page.
/// Auth state is managed by AuthBloc - AccountBloc reads from it.
sealed class AccountEvent extends BaseEvent {}

/// Initialize account page - check auth status via AuthBloc
class OnAccountInitialize extends AccountEvent {
  OnAccountInitialize();
}
