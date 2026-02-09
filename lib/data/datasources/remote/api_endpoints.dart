/// API Endpoint Definitions
///
/// Centralized endpoint paths for Happyco API
/// Base URL: http://103.9.211.145:3014
/// Swagger: http://103.9.211.145:3014/api-docs/#/
class ApiEndpoints {
  ApiEndpoints._();

  // ============================================
  // AUTH ENDPOINTS (no /api prefix per API spec)
  // ============================================
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh_token";
  static const String forgotPassword = "/auth/forgot_password";
  static const String confirmOtp = "/auth/confirm_otp";
  static const String refreshOtp = "/auth/refresh_otp";
  static const String resetPassword = "/auth/reset_password";
  static const String changePassword = "/auth/change-password";

  // ============================================
  // USER ENDPOINTS (no /api prefix per API spec)
  // ============================================
  static const String profile = "/users/me";
  static const String updateProfile = "/users/me";
  static const String uploadAvatar = "/users/me/avatar";

  // ============================================
  // PRODUCT ENDPOINTS
  // ============================================
  static const String products = "/products";
  static String productDetail(String id) => "/products/$id";
  static const String featuredProducts = "/products/featured";
  static const String recommendedProducts = "/products/recommended";
  static const String searchProducts = "/products/search";

  // ============================================
  // CATEGORY ENDPOINTS
  // ============================================
  static const String categories = "/categories";
  static String categoryProducts(String id) => "/categories/$id/products";

  // ============================================
  // BANNER ENDPOINTS
  // ============================================
  static const String banners = "/banners";

  // ============================================
  // CART ENDPOINTS
  // ============================================
  static const String cart = "/cart";
  static String cartItem(String id) => "/cart/items/$id";
  static const String cartClear = "/cart/clear";

  // ============================================
  // ORDER ENDPOINTS
  // ============================================
  static const String orders = "/orders";
  static String orderDetail(String id) => "/orders/$id";
  static String cancelOrder(String id) => "/orders/$id/cancel";

  // ============================================
  // PAYMENT ENDPOINTS
  // ============================================
  static const String paymentMethods = "/payments/methods";
  static String paymentProcess(String orderId) => "/payments/orders/$orderId";

  // ============================================
  // PROMOTION ENDPOINTS
  // ============================================
  static const String vouchers = "/vouchers";
  static const String promotions = "/promotions";

  // ============================================
  // NOTIFICATION ENDPOINTS
  // ============================================
  static const String notifications = "/notifications";
  static const String notificationsReadAll = "/notifications/read-all";
  static String notificationRead(String id) => "/notifications/$id/read";

  // ============================================
  // REVIEW ENDPOINTS
  // ============================================
  static const String reviews = "/reviews";
  static String productReviews(String productId) =>
      "/products/$productId/reviews";

  // ============================================
  // ADDRESS ENDPOINTS
  // ============================================
  static const String addresses = "/addresses";
  static String addressDefault(String id) => "/addresses/$id/default";
  static String addressDelete(String id) => "/addresses/$id";
}
