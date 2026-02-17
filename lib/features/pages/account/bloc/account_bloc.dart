import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/repositories/storage_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

/// AccountBloc
///
/// Thin BLoC for Account page UI state.
/// Auth state is managed by AuthBloc - this bloc reads from StorageRepository
/// for login status check. Does NOT duplicate auth logic.
///
/// Responsibilities:
/// - Check login status on initialize
/// - Fetch current user if logged in
class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  final StorageRepository _storageRepository;

  AccountBloc({
    required StorageRepository storageRepository,
  })  : _storageRepository = storageRepository,
        super(AccountInitial()) {
    on<OnAccountInitialize>(_onInitialize);
  }

  Future<void> _onInitialize(
    OnAccountInitialize event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());

    final isLoggedIn = _storageRepository.isLoggedIn();
    if (!isLoggedIn) {
      emit(AccountNotLoggedIn());
      return;
    }

    // User is logged in - emit logged in state
    // User data will be read from AuthBloc in the widget layer
    emit(AccountLoggedIn());
  }
}
