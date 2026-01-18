import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// News Repository Mock Implementation
///
/// Provides mock data for development.
/// Replace with NewsRepositoryImpl connected to API for production.
class NewsRepositoryMock implements NewsRepository {
  @override
  Future<List<NewsEntity>> getNewsByCategory(NewsCategory category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockNews.where((news) => news.category == category).toList();
  }

  @override
  Future<List<NewsEntity>> getPromotions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getNewsByCategory(NewsCategory.promotion);
  }

  @override
  Future<List<NewsEntity>> getLatestNews() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockNews.take(3).toList();
  }

  @override
  Future<List<NewsEntity>> getQA() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return getNewsByCategory(NewsCategory.qa);
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockProducts;
  }

  @override
  Future<List<NewsEntity>> getRelatedVideos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVideos;
  }

  // Mock data matching Figma design node-id=1:2452
  final List<NewsEntity> _mockNews = const [
    // Promotions
    NewsEntity(
      id: '1',
      title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
      description:
          'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%, hàng trăm quà tặng thiết thực như mũi khoan, máy khoan, máy mài...',
      imageUrl:
          'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=800',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.promotion,
    ),
    NewsEntity(
      id: '2',
      title: 'Flash Sale cuối tuần - Giảm đến 40% cho mọi sản phẩm',
      description:
          'Chương trình áp dụng cho tất cả sản phẩm nội thất gỗ, ghế sofa, bàn ăn... Đừng bỏ lỡ cơ hội sở hữu sản phẩm chất lượng với giá ưu đãi nhất!',
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      publishDate: '14:30 PM, 18/12/2025',
      category: NewsCategory.promotion,
    ),
    NewsEntity(
      id: '3',
      title: 'Khai trương showroom mới - Ưu đãi khủng',
      description:
          'Nhân dịp khai trương showroom tại Quận 7, Happyco tặng voucher 500k cho 100 khách hàng đầu tiên. Miễn phí vận chuyển toàn quốc!',
      imageUrl:
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=800',
      publishDate: '10:00 AM, 15/12/2025',
      category: NewsCategory.promotion,
    ),

    // Q&A
    NewsEntity(
      id: '4',
      title: 'Happyco là gì? Cửa hàng sử dụng như thế nào?',
      description:
          'Happyco là nền tảng giúp cửa hàng quản lý sản phẩm, theo dõi đơn hàng, quản lý kho hàng và tăng doanh thu một cách hiệu quả...',
      imageUrl:
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=800',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.qa,
    ),
    NewsEntity(
      id: '5',
      title: 'Khách mua hàng tại cửa hàng có cần tải ứng dụng không?',
      description:
          'Nhiều khách thắc mắc liệu họ có cần tải ứng dụng hoặc đăng ký tài khoản Happy khi mua sắm tại cửa hàng. Câu trả lời là KHÔNG...',
      imageUrl:
          'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?w=800',
      publishDate: '15:30 PM, 19/12/2025',
      category: NewsCategory.qa,
    ),
    NewsEntity(
      id: '6',
      title: 'Happyco có ảnh hưởng đến chính sách bảo hành không?',
      description:
          'Một số khách hàng lo lắng việc áp dụng hệ thống mới có làm thay đổi quyền lợi của họ. Xin cam đoan rằng tất cả chính sách đều được giữ nguyên...',
      imageUrl:
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=800',
      publishDate: '11:00 AM, 17/12/2025',
      category: NewsCategory.qa,
    ),

    // Knowledge
    NewsEntity(
      id: '7',
      title: '5 Tips chọn bàn ăn phù hợp với không gian nhà bạn',
      description:
          'Việc lựa chọn bàn ăn phù hợp sẽ giúp không gian bếp của bạn trở nên sang trọng và tiện nghi hơn. Cùng tìm hiểu các mẹo hay...',
      imageUrl:
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=800',
      publishDate: '09:00 AM, 16/12/2025',
      category: NewsCategory.knowledge,
    ),
    NewsEntity(
      id: '8',
      title: 'Cách bảo quản đồ gỗ để luôn bền đẹp',
      description:
          'Đồ gỗ cần được chăm sóc đúng cách để giữ được vẻ đẹp tự nhiên và độ bền cao. Dưới đây là những tips hữu ích từ chuyên gia...',
      imageUrl:
          'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=800',
      publishDate: '14:00 PM, 14/12/2025',
      category: NewsCategory.knowledge,
    ),
  ];

  final List<ProductEntity> _mockProducts = const [
    ProductEntity(
      id: 'p1',
      name: 'Kệ tường treo Minimalist',
      priceInVnd: 2150000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
      category: 'Furniture',
      isFeatured: true,
    ),
    ProductEntity(
      id: 'p2',
      name: 'Đồng hồ treo tường gỗ',
      priceInVnd: 1130000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?w=400',
      category: 'Decor',
      isFeatured: true,
    ),
    ProductEntity(
      id: 'p3',
      name: 'Bàn thờ treo tường Happyco',
      priceInVnd: 1120000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=400',
      category: 'Furniture',
      isFeatured: true,
    ),
  ];

  final List<NewsEntity> _mockVideos = const [
    NewsEntity(
      id: 'v1',
      title: 'Hướng dẫn lắp đặt kệ sách gỗ đơn giản',
      description: 'Video chi tiết từng bước lắp đặt',
      imageUrl:
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=800',
      publishDate: '12:00 PM, 13/12/2025',
      category: NewsCategory.knowledge,
      videoUrl: 'https://example.com/video1.mp4',
    ),
    NewsEntity(
      id: 'v2',
      title: 'Bí quyết chọn sofa phù hợp với phòng khách',
      description: 'Tư vấn từ chuyên gia nội thất',
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      publishDate: '10:30 AM, 12/12/2025',
      category: NewsCategory.knowledge,
      videoUrl: 'https://example.com/video2.mp4',
    ),
    NewsEntity(
      id: 'v3',
      title: 'Review bộ bàn ăn gỗ sồi cao cấp',
      description: 'Đánh giá chi tiết chất lượng sản phẩm',
      imageUrl:
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=800',
      publishDate: '08:00 AM, 11/12/2025',
      category: NewsCategory.knowledge,
      videoUrl: 'https://example.com/video3.mp4',
    ),
  ];
}
