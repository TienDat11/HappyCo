import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<List<NewsEntity>> getNewsByCategory(NewsCategory category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockNews.where((element) => element.category == category).toList();
  }

  @override
  Future<List<NewsEntity>> getPromotions() async {
    return getNewsByCategory(NewsCategory.promotion);
  }

  @override
  Future<List<NewsEntity>> getLatestNews() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockNews.take(3).toList();
  }

  @override
  Future<List<NewsEntity>> getQA() async {
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

  // Mock data matching Figma design node-id=1:2452.
  // Using local assets for development.

  final List<NewsEntity> _mockNews = [
    NewsEntity(
      id: '1',
      title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
      description:
          'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%, hàng trăm quà tặng thiết thực như mũi khoan...',
      imageUrl:
          'http://localhost:3845/assets/848cb452eb9bdfd8644c77db3923a3f0d3c0f67b.png',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.promotion,
    ),
    NewsEntity(
      id: '2',
      title: 'Happyco là gì? Cửa hàng sử dụng...',
      description:
          'Happyco là nền tảng giúp cửa hàng quản lý sản phẩm, theo dõi đơn hàng, quản lý...',
      imageUrl:
          'http://localhost:3845/assets/dd755649be090ecd99c06bdcc855654235101a87.png',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.qa,
    ),
    NewsEntity(
      id: '3',
      title: 'Khách mua hàng tại cửa hàng có...',
      description:
          'Nhiều khách thắc mắc liệu họ có cần tải ứng dụng hoặc đăng ký tài khoản Happy...',
      imageUrl:
          'http://localhost:3845/assets/9700730b6fb7e8e7a17df11c8b25f6445d7503a9.png',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.qa,
    ),
    NewsEntity(
      id: '4',
      title: 'Happyco có ảnh hưởng đến chính...',
      description:
          'Một số khách hàng lo lắng việc áp dụng hệ thống mới có làm thay đổi quyền lợi...',
      imageUrl:
          'http://localhost:3845/assets/2bfcea1bd8f915f1fabe34222d031f6ae4e9ed63.png',
      publishDate: '16:00 PM, 20/12/2025',
      category: NewsCategory.qa,
    ),
  ];

  final List<ProductEntity> _mockProducts = [
    ProductEntity(
      id: 'p1',
      name: 'Kệ tường treo Minimalist',
      priceInVnd: 2150000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'http://localhost:3845/assets/32706b9918779e32489eed521165237faa3e2171.png',
      category: 'Furniture',
    ),
    ProductEntity(
      id: 'p2',
      name: 'Đồng hồ treo tường gỗ',
      priceInVnd: 1130000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'http://localhost:3845/assets/32306b80b3f6ba3afb8d6e5c7721e6c74ca28289.png',
      category: 'Decor',
    ),
    ProductEntity(
      id: 'p3',
      name: 'Bàn thờ treo tường Happyco',
      priceInVnd: 1120000,
      oldPriceInVnd: 2300000,
      imageUrl:
          'http://localhost:3845/assets/79e4bedbdb669df9cc727550d766a6e5792442a1.png',
      category: 'Furniture',
    ),
  ];

  final List<NewsEntity> _mockVideos = [
    NewsEntity(
      id: 'v1',
      title: 'Video liên quan 1',
      description: '',
      imageUrl:
          'http://localhost:3845/assets/45f407ccbd5fae6135fde92aa8165ee8af0c0ee2.png',
      publishDate: '',
      category: NewsCategory.knowledge,
      videoUrl: 'https://example.com/video1.mp4',
    ),
    NewsEntity(
      id: 'v2',
      title: 'Video liên quan 2',
      description: '',
      imageUrl:
          'http://localhost:3845/assets/45f407ccbd5fae6135fde92aa8165ee8af0c0ee2.png',
      publishDate: '',
      category: NewsCategory.knowledge,
      videoUrl: 'https://example.com/video2.mp4',
    ),
  ];
}
