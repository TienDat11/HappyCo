part of 'notification_detail_bloc.dart';

sealed class NotificationDetailState extends BaseBlocState {}

class NotificationDetailInitial extends NotificationDetailState {}

class NotificationDetailLoading extends NotificationDetailState {}

class NotificationDetailLoaded extends NotificationDetailState {
  final NotificationEntity notificationDetail;

  NotificationDetailLoaded({required this.notificationDetail});
}

class NotificationDetailError extends NotificationDetailState
    implements ErrorState {
  @override
  final String error;

  NotificationDetailError({required this.error});
}
