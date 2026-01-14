import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

class UIText extends StatelessWidget {
  /// label title
  final String title;

  final int? maxLines;

  final TextOverflow? overflow;

  /// label color appearance
  final Color? titleColor;

  final double? titleSize;

  final FontWeight? fontWeight;

  final FontStyle? fontStyle;

  final TextAlign? textAlign;

  /// The decorations to paint near the text (e.g., an underline).
  ///
  /// Multiple decorations can be applied using [TextDecoration.combine].
  final TextDecoration? decoration;

  final StrutStyle? strutStyle;

  final String? fontFamily;

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
        decorationColor: titleColor ?? UIColors.black,
        fontFamily: fontFamily ?? UIFonts.gilroy,
        fontSize: titleSize ?? UISizes.font.sp14,
        color: titleColor ?? UIColors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: lineHeight ?? 4 / 3,
      ),
      strutStyle: strutStyle,
    );
  }
}
