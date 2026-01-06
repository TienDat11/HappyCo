import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Standardized Card Widget for Happyco Design System
///
/// Usage:
/// ```dart
/// UICard(
///   child: UIText(title: 'Content'),
/// )
/// ```
class UICard extends StatelessWidget {
  /// Child widget inside the card
  final Widget child;

  /// Background color (defaults to UIColors.white)
  final Color? backgroundColor;

  /// Border radius (defaults to r8)
  final double? borderRadius;

  /// Optional border
  final BoxBorder? border;

  /// Optional shadow/elevation
  final bool hasShadow;

  /// Optional padding
  final EdgeInsetsGeometry? padding;

  /// Optional margin
  final EdgeInsetsGeometry? margin;

  /// Optional width constraint
  final double? width;

  /// Optional height constraint
  final double? height;

  const UICard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.hasShadow = false,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? UIColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? UISizes.square.r8),
        border: border,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: UISizes.square.r8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      padding: padding,
      child: child,
    );
  }
}
