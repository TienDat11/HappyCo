/// Application-wide constants with semantic meaning.
///
/// Centralizes hardcoded strings and numbers that are used throughout the app.
/// These constants have semantic meaning and are repeated in multiple places.
///
/// Usage:
/// ```dart
/// // Error messages
/// AppErrorMessages.genericError
///
/// // Action texts
/// AppActionTexts.viewAll
///
/// // Section titles
/// AppSectionTitles.featuredProducts
///
/// // Category names
/// AppCategoryNames.diningSet
///
/// // Numbers with semantic meaning
/// AppNumbers.defaultSectionItemCount
/// ```
library;

/// Error messages displayed to users
class AppErrorMessages {
  AppErrorMessages._();

  /// Generic error message when something goes wrong
  static const String genericError = 'Đã có lỗi xảy ra';

  /// Retry button text
  static const String retry = 'Thử lại';
}

/// Action button/label texts
class AppActionTexts {
  AppActionTexts._();

  /// "View all" button text for sections
  static const String viewAll = 'Xem tất cả';
}

/// Section titles across the app
class AppSectionTitles {
  AppSectionTitles._();

  /// Featured products section title
  static const String featuredProducts = 'Sản phẩm nổi bật';

  /// Recommended products section title
  static const String recommendedProducts = 'Gợi ý hôm nay';

  /// Latest news section title
  static const String latestNews = 'Tin tức mới nhất';

  /// Q&A section title
  static const String qAndA = 'Hỏi đáp về Happyco';

  /// Videos section title
  static const String relatedVideos = 'Video liên quan';

  /// Default product title
  static const String products = 'Sản phẩm';
}

/// Category names mapping
class AppCategoryNames {
  AppCategoryNames._();

  /// Dining set category
  static const String diningSet = 'Bộ bàn ăn';

  /// Dining chair category
  static const String diningChair = 'Ghế ăn';

  /// Wooden sofa category
  static const String sofa = 'Sofa gỗ';

  /// Shoe cabinet category
  static const String shoeCabinet = 'Tủ giày';

  /// Vanity table category
  static const String vanityTable = 'Bàn trang điểm';

  /// Altar category
  static const String altar = 'Tủ thờ';

  /// Display shelf category
  static const String displayShelf = 'Kệ trang trí';

  /// Kitchen cabinet category
  static const String kitchenCabinet = 'Tủ bếp';

  /// Default category name
  static const String products = 'Sản phẩm';
}

/// Category IDs mapping
class AppCategoryIds {
  AppCategoryIds._();

  static const String diningSet = 'dining_set';
  static const String diningChair = 'dining_chair';
  static const String sofa = 'sofa';
  static const String shoeCabinet = 'shoe_cabinet';
  static const String vanityTable = 'vanity_table';
  static const String altar = 'altar';
  static const String displayShelf = 'display_shelf';
  static const String kitchenCabinet = 'kitchen_cabinet';
}

/// Numbers with semantic meaning
class AppNumbers {
  AppNumbers._();

  /// Default number of items to show in a section
  static const int defaultSectionItemCount = 3;

  /// Bottom navigation bar height for padding
  static const int bottomNavBarHeight = 80;
}
