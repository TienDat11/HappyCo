import 'package:happyco/domain/entities/news_category_entity.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

/// News Repository Mock Implementation
///
/// Provides mock data for development.
/// Replace with NewsRepositoryImpl connected to API for production.
class NewsRepositoryMock implements NewsRepository {
  @override
  Future<List<NewsCategoryEntity>> getNewsCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      NewsCategoryEntity(id: '1', name: 'Tin khuyến mãi & Sự kiện'),
      NewsCategoryEntity(id: '2', name: 'Hỏi đáp về Happyco'),
    ];
  }

  @override
  Future<List<NewsEntity>> getNews({
    String? categoryId,
    String? search,
    int? limit,
    int? offset,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockNews;
  }

  @override
  Future<List<NewsEntity>> getNewsVideos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockVideos;
  }

  final List<NewsEntity> _mockNews = const [
    NewsEntity(
      id: '1',
      title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
      description:
          'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%...',
      imageUrl:
          'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=800',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.promotion,
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
  ];
}
