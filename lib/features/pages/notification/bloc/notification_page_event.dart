part of 'notification_page_bloc.dart';

/// Notification Events
sealed class NotificationPageEvent extends BaseEvent {}

/// Initialize notification page
class OnNotificationInitialize extends NotificationPageEvent {}

/// Refresh notification page
class OnNotificationRefresh extends NotificationPageEvent {}

/// Mark all notifications as read (optional – dùng sau)
class OnNotificationMarkAllRead extends NotificationPageEvent {}
