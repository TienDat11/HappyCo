part of 'notification_detail_bloc.dart';

sealed class NotificationDetailEvent extends BaseEvent {}

class OnNotificationDetailInitialize extends NotificationDetailEvent {
  final String id;

  OnNotificationDetailInitialize({required this.id});
}

class OnNotificationDetailRefresh extends NotificationDetailEvent {
  final String id;

  OnNotificationDetailRefresh({required this.id});
}
