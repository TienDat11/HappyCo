import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';
import 'package:happyco/core/services/talker_service.dart';

/// Base BLoC class with built-in logging and error handling
///
/// Usage:
/// ```dart
/// part 'home_event.dart';
/// part 'home_state.dart';
///
/// class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
///   HomeBloc() : super(HomeInitial()) {
///     on<OnLoadHome>(_onLoadHome);
///   }
/// }
/// ```
abstract class BaseBloc<E extends BaseEvent, S extends BaseBlocState>
    extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    talker.debug('$runtimeType created');
  }

  @override
  void onEvent(E event) {
    super.onEvent(event);
    talker.debug('$runtimeType event: ${event.runtimeType}');
  }

  @override
  void onChange(Change<S> change) {
    super.onChange(change);
    talker.debug(
      '$runtimeType state: ${change.currentState.runtimeType} → ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.error('$runtimeType error', error, stackTrace);
  }

  @override
  Future<void> close() {
    talker.debug('$runtimeType closed');
    return super.close();
  }

  /// Helper to emit loading state
  void emitLoading(Emitter<S> emit, S loadingState) {
    emit(loadingState);
  }

  /// Helper to emit error state with logging
  void emitError(Emitter<S> emit, S errorState, Object error,
      [StackTrace? stackTrace]) {
    talker.error('$runtimeType emitting error state', error, stackTrace);
    emit(errorState);
  }
}
