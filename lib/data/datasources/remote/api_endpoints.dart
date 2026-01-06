/// API Endpoint Definitions
///
/// Centralized endpoint paths for Happyco API
class ApiEndpoints {
  ApiEndpoints._();

  static const String _api = "/api";

  // ============================================
  // AUTH ENDPOINTS
  // ============================================
  static const String login = "$_api/auth/login";
  static const String register = "$_api/auth/register";
  static const String logout = "$_api/auth/logout";
  static const String refreshToken = "$_api/auth/refresh-token";
  static const String forgotPassword = "$_api/auth/forgot-password";
  static const String verifyOtp = "$_api/auth/verify-otp";
  static const String resendOtp = "$_api/auth/resend-otp";
  static const String resetPassword = "$_api/auth/reset-password";
  static const String changePassword = "$_api/auth/change-password";

  // ============================================
  // USER ENDPOINTS
  // ============================================
  static const String profile = "$_api/users/me";
  static const String updateProfile = "$_api/users/me";
  static const String uploadAvatar = "$_api/users/me/avatar";

  // ============================================
  // PRODUCT ENDPOINTS
  // ============================================
  static const String products = "$_api/products";
  static String productDetail(String id) => "$_api/products/$id";
  static const String featuredProducts = "$_api/products/featured";
  static const String recommendedProducts = "$_api/products/recommended";
  static const String searchProducts = "$_api/products/search";

  // ============================================
  // CATEGORY ENDPOINTS
  // ============================================
  static const String categories = "$_api/categories";
  static String categoryProducts(String id) => "$_api/categories/$id/products";

  // ============================================
  // CART ENDPOINTS
  // ============================================
  static const String cart = "$_api/cart";
  static String cartItem(String id) => "$_api/cart/items/$id";
  static const String cartClear = "$_api/cart/clear";

  // ============================================
  // ORDER ENDPOINTS
  // ============================================
  static const String orders = "$_api/orders";
  static String orderDetail(String id) => "$_api/orders/$id";
  static String cancelOrder(String id) => "$_api/orders/$id/cancel";

  // ============================================
  // PAYMENT ENDPOINTS
  // ============================================
  static const String paymentMethods = "$_api/payments/methods";
  static String paymentProcess(String orderId) =>
      "$_api/payments/orders/$orderId";

  // ============================================
  // PROMOTION ENDPOINTS
  // ============================================
  static const String vouchers = "$_api/vouchers";
  static const String promotions = "$_api/promotions";

  // ============================================
  // NOTIFICATION ENDPOINTS
  // ============================================
  static const String notifications = "$_api/notifications";
  static const String notificationsReadAll = "$_api/notifications/read-all";
  static String notificationRead(String id) => "$_api/notifications/$id/read";

  // ============================================
  // REVIEW ENDPOINTS
  // ============================================
  static const String reviews = "$_api/reviews";
  static String productReviews(String productId) =>
      "$_api/products/$productId/reviews";

  // ============================================
  // ADDRESS ENDPOINTS
  // ============================================
  static const String addresses = "$_api/addresses";
  static String addressDefault(String id) => "$_api/addresses/$id/default";
  static String addressDelete(String id) => "$_api/addresses/$id";
}
