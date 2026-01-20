import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/notification_entity.dart';
import 'package:happyco/domain/repositories/notification_repository.dart';

class GetNotificationDetailUsecase
    extends StatelessUseCase<NotificationEntity, String> {
  final NotificationRepository repository;

  GetNotificationDetailUsecase({required this.repository});

  @override
  Future<NotificationEntity> exec(String id) {
    return repository.getNotificationDetail(id);
  }
}
