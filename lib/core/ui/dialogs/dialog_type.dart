/// Dialog Types for Happyco App
///
/// Defines all dialog types used in the application
enum DialogType {
  // Authentication dialogs
  login,
  register,
  createNewPassword,
  forgotPassword,
  otpVerification,

  // Confirmation dialogs
  confirmation,
  deleteConfirmation,
  logoutConfirmation,

  // Information dialogs
  info,
  success,
  warning,
  error,

  // Settings dialogs
  language,
  notification,
  privacy,

  // Product dialogs
  productDetails,
  addToCartSuccess,
  outOfStock,

  // Order dialogs
  orderConfirmation,
  orderSuccess,
  orderCancel,

  // Custom dialogs
  custom,
}
