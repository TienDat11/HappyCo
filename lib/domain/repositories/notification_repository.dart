import 'package:happyco/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();

  Future<NotificationEntity> getNotificationDetail(String id);
}
