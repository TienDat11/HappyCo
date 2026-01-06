import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// BuildContext Extensions for Happyco App
///
/// Provides convenient access to common Flutter properties and utilities
extension BuildContextExtensions on BuildContext {
  /// Get ThemeData from context
  ThemeData get theme => Theme.of(this);

  /// Get TextTheme from context
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get ColorScheme from context
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get MediaQuery from context
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get Screen size
  Size get screenSize => mediaQuery.size;

  /// Get Screen width
  double get screenWidth => mediaQuery.size.width;

  /// Get Screen height
  double get screenHeight => mediaQuery.size.height;

  /// Check if device is in portrait mode
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Check if device is in landscape mode
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Get safe area padding
  EdgeInsets get safePadding => mediaQuery.padding;

  /// Get safe area bottom padding
  double get safeBottom => mediaQuery.padding.bottom;

  /// Get safe area top padding
  double get safeTop => mediaQuery.padding.top;

  /// Get status bar height
  double get statusBarHeight => mediaQuery.padding.top;

  /// Get navigation bar height
  double get navigationBarHeight => mediaQuery.padding.bottom;

  /// Navigate to a new route
  Future<T?> push<T>(Route<T> route) {
    return Navigator.push(this, route);
  }

  /// Navigate to a named route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  /// Pop current route
  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  /// Pop until a specific route
  void popUntil(RoutePredicate predicate) {
    Navigator.popUntil(this, predicate);
  }

  /// Show a snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Hide current snackbar
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  /// Remove all snackbars
  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  /// Show a material dialog
  Future<T?> showCustomDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }

  /// Show a bottom sheet
  Future<T?> showBottomSheet<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      isScrollControlled: true,
      isDismissible: isDismissible,
    );
  }

  /// Show a modal bottom sheet
  Future<T?> showModal<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      isScrollControlled: true,
    );
  }

  /// Get FocusScope of current context
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Unfocus current focus
  void unfocus() {
    focusScope.unfocus();
  }

  /// Request focus
  void requestFocus(FocusNode focusNode) {
    focusScope.requestFocus(focusNode);
  }

  /// Check if dark mode is enabled
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if light mode is enabled
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Get primary color
  Color get primaryColor => theme.primaryColor;

  /// Get scaffold background color
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Get card color
  Color get cardColor => theme.cardColor;

  /// Get divider color
  Color get dividerColor => theme.dividerColor;

  /// Check if device is a tablet
  bool get isTablet {
    final shortestSide = screenSize.shortestSide;
    return shortestSide >= 600; // 600dp is standard tablet threshold
  }

  /// Check if device is a phone
  bool get isPhone => !isTablet;

  /// Get responsive value based on screen size
  T responsive<T>({
    required T mobile,
    required T tablet,
    T? desktop,
  }) {
    if (isTablet) {
      return tablet;
    }
    if (desktop != null && screenWidth > 1200) {
      return desktop;
    }
    return mobile;
  }

  /// Show loading dialog
  void showLoading({String message = 'Đang tải...'}) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (_) => PopScope(
          canPop: false,
          child: Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(UISizes.width.w24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    if (message.isNotEmpty) ...[
                      SizedBox(height: UISizes.height.h16),
                      Text(message),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoading() {
    pop();
  }

  /// Show error dialog
  Future<void> showError(
    String message, {
    String title = 'Lỗi',
    String confirmText = 'Đóng',
  }) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => pop(),
              child: Text(confirmText),
            ),
          ],
        ),
      ),
    );
  }

  /// Show confirmation dialog
  Future<bool?> showConfirmation({
    required String title,
    required String message,
    String confirmText = 'Đồng ý',
    String cancelText = 'Hủy',
  }) {
    return Navigator.of(this).push(
      MaterialPageRoute<bool>(
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => pop(false),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () => pop(true),
              child: Text(confirmText),
            ),
          ],
        ),
      ),
    );
  }

  /// Show bottom modal dialog with rounded corners
  Future<T?> showRoundedModal<T>({
    required Widget child,
    double borderRadius = 20,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(UISizes.square.r20)),
        ),
        child: child,
      ),
    );
  }

  /// Get localized text (if you have intl setup)
  /// Example: context.l10n.loginButtonText
  // AppLocalizations get l10n => AppLocalizations.of(this)!;
}
