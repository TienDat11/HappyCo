import 'package:happyco/domain/entities/notification_entity.dart';
import 'package:happyco/domain/repositories/notification_repository.dart';

class NotificationRepositoryMock implements NotificationRepository {
  final Map<String, List<NotificationEntity>> _mockData;

  NotificationRepositoryMock()
      : _mockData = {
          'dining_set': [
            NotificationEntity(
              id: 'nt_1',
              title: 'Khuyến mãi 20% trên tất cả các gói dịch vụ',
              description:
                  'Nhận ngay 20% giảm giá trên tất cả sản phẩm và dịch vụ hôm nay.',
              iconName: 'discount',
              isRead: false,
              createdAt: DateTime.now(),
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
            ),
            NotificationEntity(
              id: 'nt_2',
              title: 'Đơn hàng của bạn đã được xác nhận',
              description:
                  'Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị.',
              iconName: 'order_confirm',
              isRead: false,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              createdAt: DateTime.now(),
            ),
            NotificationEntity(
              id: 'nt_3',
              title: 'Đơn hàng của bạn đã được vận chuyển',
              description:
                  'Đơn hàng của bạn đang trên đường giao đến địa chỉ nhận.',
              iconName: 'shipping',
              isRead: true,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              createdAt: DateTime.now(),
            ),
            NotificationEntity(
              id: 'nt_4',
              title: 'Đơn hàng của bạn đã giao thành công',
              description:
                  'Đơn hàng đã được giao thành công. Cảm ơn bạn đã mua sắm!',
              iconName: 'delivered',
              isRead: true,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              createdAt: DateTime.now(),
            ),
            NotificationEntity(
              id: 'nt_5',
              title: 'Khuyến mãi 20% trên tất cả các gói dịch vụ',
              description:
                  'Ưu đãi đặc biệt chỉ áp dụng trong thời gian giới hạn.',
              iconName: 'discount',
              isRead: true,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              createdAt: DateTime.now(),
            ),
            NotificationEntity(
              id: 'nt_6',
              title: 'Ra mắt sản phẩm mới - Bàn lễ 2025',
              description:
                  'Khám phá ngay mẫu bàn lễ 2025 với thiết kế hoàn toàn mới.',
              iconName: 'new_product',
              isRead: true,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              createdAt: DateTime.now(),
            ),
          ],
        };

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockData['dining_set'] ?? [];
  }

  @override
  Future<NotificationEntity> getNotificationDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final allItems = _mockData.values.expand((e) => e).toList();

    return allItems.firstWhere(
      (e) => e.id == id,
      orElse: () => throw Exception('Notification not found'),
    );
  }
}
