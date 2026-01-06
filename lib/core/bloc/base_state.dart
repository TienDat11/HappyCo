/// Base State for all BLoC states
///
/// Provides common state properties for UI feedback
abstract class BaseBlocState {
  /// Whether the state is currently loading
  bool get isLoading => false;

  /// Error message if any
  String? get error => null;

  /// Whether there's an error
  bool get hasError => error != null;
}

/// Initial state marker interface
abstract class InitialState extends BaseBlocState {}

/// Loading state marker interface
abstract class LoadingState extends BaseBlocState {
  @override
  bool get isLoading => true;
}

/// Error state base class
abstract class ErrorState extends BaseBlocState {
  @override
  String get error;
}
