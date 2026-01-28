part of 'notification_page_bloc.dart';

/// Notification States
sealed class NotificationPageState extends BaseBlocState {
  NotificationPageState();
}

/// Initial state before data is loaded
class NotificationInitial extends NotificationPageState implements InitialState {
  NotificationInitial();
}

/// Loading state while fetching data
class NotificationLoading extends NotificationPageState implements LoadingState {
  NotificationLoading();
}

/// Loaded state with product data
class NotificationLoaded extends NotificationPageState {
  final List<NotificationEntity> notifications;

  NotificationLoaded({
    required this.notifications,
  });
}

/// Error state when data fetch fails
class NotificationError extends NotificationPageState implements ErrorState {
  @override
  final String error;

  NotificationError({required this.error});
}
