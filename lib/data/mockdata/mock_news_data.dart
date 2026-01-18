import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Mock data for News screen based on Figma design node-id=1:2452.
///
/// Used for development and testing purposes.
class MockNewsData {
  MockNewsData._();

  /// Promotions and events
  static List<NewsEntity> get promotions => [
        NewsEntity(
          id: '1',
          title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
          description:
              'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%, hàng trăm quà tặng thiết thực như mũi khoan...',
          imageUrl: 'assets/images/news/promotion1.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.promotion,
          isFeatured: true,
        ),
        NewsEntity(
          id: '2',
          title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
          description:
              'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%, hàng trăm quà tặng thiết thực như mũi khoan...',
          imageUrl: 'assets/images/news/promotion2.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.promotion,
          isFeatured: true,
        ),
        NewsEntity(
          id: '3',
          title: 'Đón sinh thần - Vạn quà tri ân độc quyền tại Happyco',
          description:
              'Trong suốt thời gian diễn ra sự kiện, khách hàng khi mua sắm tại cửa hàng sẽ có cơ hội nhận ưu đãi đến 50%, hàng trăm quà tặng thiết thực như mũi khoan...',
          imageUrl: 'assets/images/news/promotion3.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.promotion,
          isFeatured: true,
        ),
      ];

  /// Banner image for middle section
  static NewsEntity get banner => NewsEntity(
        id: 'banner',
        title: 'Banner',
        description: '',
        imageUrl: 'assets/images/news/banner.jpg',
        publishDate: '',
        category: NewsCategory.promotion,
        isFeatured: false,
      );

  /// Latest news articles (compact format)
  static List<NewsEntity> get latestNews => [
        NewsEntity(
          id: '4',
          title: 'Happyco là gì? Cửa hàng sử dụng...',
          description:
              'Happyco là nền tảng giúp cửa hàng quản lý sản phẩm, theo dõi đơn hàng, quản lý...',
          imageUrl: 'assets/images/news/latest1.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.newProduct,
        ),
        NewsEntity(
          id: '5',
          title: 'Khách mua hàng tại cửa hàng có...',
          description:
              'Nhiều khách thắc mắc liệu họ có cần tải ứng dụng hoặc đăng ký tài khoản Happy...',
          imageUrl: 'assets/images/news/latest2.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.newProduct,
        ),
        NewsEntity(
          id: '6',
          title: 'Happyco có ảnh hưởng đến chính...',
          description:
              'Một số khách hàng lo lắng việc áp dụng hệ thống mới có làm thay đổi quyền lợi...',
          imageUrl: 'assets/images/news/latest3.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.newProduct,
        ),
      ];

  /// Q&A items (compact format)
  static List<NewsEntity> get qaList => [
        NewsEntity(
          id: '7',
          title: 'Happyco là gì? Cửa hàng sử dụng...',
          description:
              'Happyco là nền tảng giúp cửa hàng quản lý sản phẩm, theo dõi đơn hàng, quản lý...',
          imageUrl: 'assets/images/news/qa1.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.qa,
        ),
        NewsEntity(
          id: '8',
          title: 'Khách mua hàng tại cửa hàng có...',
          description:
              'Nhiều khách thắc mắc liệu họ có cần tải ứng dụng hoặc đăng ký tài khoản Happy...',
          imageUrl: 'assets/images/news/qa2.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.qa,
        ),
        NewsEntity(
          id: '9',
          title: 'Happyco có ảnh hưởng đến chính...',
          description:
              'Một số khách hàng lo lắng việc áp dụng hệ thống mới có làm thay đổi quyền lợi...',
          imageUrl: 'assets/images/news/qa3.jpg',
          publishDate: '16:00 PM, 20/12/2025',
          category: NewsCategory.qa,
        ),
      ];

  /// Featured products
  static List<ProductEntity> get featuredProducts => [
        ProductEntity(
          id: 'p1',
          name: 'Kệ tường treo Minimalist',
          priceInVnd: 2150000,
          oldPriceInVnd: 2300000,
          imageUrl: 'assets/images/products/product1.jpg',
          category: 'Kệ trang trí',
          isFeatured: true,
        ),
        ProductEntity(
          id: 'p2',
          name: 'Đồng hồ treo tường gỗ',
          priceInVnd: 1130000,
          oldPriceInVnd: 2300000,
          imageUrl: 'assets/images/products/product2.jpg',
          category: 'Kệ trang trí',
          isFeatured: true,
        ),
        ProductEntity(
          id: 'p3',
          name: 'Bàn thờ treo tường Happyco',
          priceInVnd: 1120000,
          oldPriceInVnd: 2300000,
          imageUrl: 'assets/images/products/product3.jpg',
          category: 'Tủ thờ',
          isFeatured: true,
        ),
      ];

  /// Related videos
  static List<NewsEntity> get relatedVideos => [
        NewsEntity(
          id: 'v1',
          title: 'Video 1',
          description: '',
          imageUrl: 'assets/images/news/video1.jpg',
          publishDate: '',
          category: NewsCategory.promotion,
          videoUrl: 'https://youtube.com/watch?v=example1',
        ),
        NewsEntity(
          id: 'v2',
          title: 'Video 2',
          description: '',
          imageUrl: 'assets/images/news/video2.jpg',
          publishDate: '',
          category: NewsCategory.promotion,
          videoUrl: 'https://youtube.com/watch?v=example2',
        ),
        NewsEntity(
          id: 'v3',
          title: 'Video 3',
          description: '',
          imageUrl: 'assets/images/news/video3.jpg',
          publishDate: '',
          category: NewsCategory.promotion,
          videoUrl: 'https://youtube.com/watch?v=example3',
        ),
      ];

  /// News by category
  static Map<NewsCategory, List<NewsEntity>> get newsByCategory => {
        NewsCategory.promotion: promotions,
        NewsCategory.newProduct: latestNews,
        NewsCategory.knowledge: latestNews,
        NewsCategory.guide: latestNews,
        NewsCategory.qa: qaList,
      };
}
