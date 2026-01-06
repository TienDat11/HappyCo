import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Standardized Text Widget for Happyco Design System
///
/// Usage:
/// ```dart
/// UIText(title: 'Hello', titleColor: UIColors.primary)
/// ```
class UIText extends StatelessWidget {
  /// The text content to display
  final String title;

  /// Maximum number of lines for text to span
  final int? maxLines;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// Text color (defaults to UIColors.black if not specified)
  final Color? titleColor;

  /// Font size (defaults to sp14 if not specified)
  final double? titleSize;

  /// Font weight (defaults to FontWeight.normal if not specified)
  final FontWeight? fontWeight;

  /// Font style (normal or italic)
  final FontStyle? fontStyle;

  /// Text alignment
  final TextAlign? textAlign;

  /// Decoration (e.g., underline, lineThrough)
  final TextDecoration? decoration;

  /// Strut style for consistent text rendering
  final StrutStyle? strutStyle;

  /// Custom font family (defaults to UIFonts.gilroy if not specified)
  final String? fontFamily;

  /// Line height multiplier (defaults to 4/3 if not specified)
  final double? lineHeight;

  const UIText({
    super.key,
    required this.title,
    this.maxLines,
    this.overflow,
    this.titleColor,
    this.titleSize,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.decoration,
    this.strutStyle,
    this.fontFamily,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        overflow: overflow,
        decoration: decoration,
        decorationColor: titleColor ?? UIColors.gray900,
        fontFamily: fontFamily ?? UIFonts.gilroy,
        fontSize: titleSize ?? UISizes.font.sp14,
        color: titleColor ?? UIColors.gray900,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: lineHeight ?? 4 / 3,
      ),
      strutStyle: strutStyle,
    );
  }
}
