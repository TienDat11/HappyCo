import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Auth Dialog Frame - Modal container for auth screens
///
/// Specifications from Figma Auth Dialogs:
/// - Background: White (#FFFFFF)
/// - Border radius: 24px
/// - Padding: 16px all sides
/// - Backdrop blur: 20px (on the overlay)
class AuthDialogFrame extends StatelessWidget {
  /// Child widget to display inside the dialog
  final Widget child;

  /// Whether the dialog is visible
  final bool isVisible;

  /// Callback when dialog should be dismissed (backdrop tap)
  final VoidCallback? onDismiss;

  const AuthDialogFrame({
    super.key,
    required this.child,
    required this.isVisible,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onDismiss != null ? () => onDismiss!() : null,
      child: Material(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent clicks from reaching backdrop
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: UISizes.width.w16,
              ),
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(UISizes.square.r24),
              ),
              padding: EdgeInsets.all(UISizes.width.w16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Extension to show auth dialog with animation
extension AuthDialogExtension on AuthDialogFrame {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    VoidCallback? onDismiss,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: onDismiss != null,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AuthDialogFrame(
          isVisible: true,
          onDismiss: onDismiss,
          child: content,
        );
      },
    );
  }
}
