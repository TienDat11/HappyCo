import 'package:happyco/core/usecase.dart';
import 'package:happyco/domain/entities/notification_entity.dart';
import 'package:happyco/domain/repositories/notification_repository.dart';

/// GetCategoryProductsUseCase
///
/// Fetches products filtered by category ID
class GetNottificationItemsUsecase
    extends UseCase<List<NotificationEntity>> {
  final NotificationRepository repository;

  GetNottificationItemsUsecase({required this.repository});

  @override
  Future<List<NotificationEntity>> exec() => repository.getNotifications();
}
