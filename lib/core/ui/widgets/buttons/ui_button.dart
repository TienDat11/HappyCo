import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/buttons/app_button_style.dart';

/// Standardized Button Widget for Happyco Design System
///
/// Usage:
/// ```dart
/// UIButton(
///   text: 'Add to Cart',
///   onPressed: () => print('Pressed'),
///   style: UIButtonStyle.primary,
/// )
/// ```
enum UIButtonStyle {
  primary,
  secondary,
  white,
  small,
}

class UIButton extends StatelessWidget {
  /// Button text label
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button style variant
  final UIButtonStyle style;

  /// Whether button should expand to full width
  final bool isFullWidth;

  /// Custom text color (overrides default)
  final Color? textColor;

  /// Custom background color (overrides style)
  final Color? backgroundColor;

  /// Whether button is enabled
  final bool isEnabled;

  /// Optional icon to display before text
  final IconData? icon;

  const UIButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = UIButtonStyle.primary,
    this.isFullWidth = false,
    this.textColor,
    this.backgroundColor,
    this.isEnabled = true,
    this.icon,
  });

  ButtonStyle get _buttonStyle {
    switch (style) {
      case UIButtonStyle.primary:
        return AppButtonStyle.primaryFillButtonStyle;
      case UIButtonStyle.secondary:
        return AppButtonStyle.secondaryOutlineButtonStyle;
      case UIButtonStyle.white:
        return AppButtonStyle.whiteFillButtonStyle;
      case UIButtonStyle.small:
        return AppButtonStyle.smallButtonStyle;
    }
  }

  Color get _textColor {
    if (textColor != null) return textColor!;
    switch (style) {
      case UIButtonStyle.primary:
      case UIButtonStyle.small:
        return UIColors.white;
      case UIButtonStyle.secondary:
        return UIColors.primary;
      case UIButtonStyle.white:
        return UIColors.gray900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle effectiveStyle = backgroundColor != null
        ? _buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
          )
        : _buttonStyle;

    final button = _buildButton(effectiveStyle);

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildButton(ButtonStyle buttonStyle) {
    if (style == UIButtonStyle.secondary) {
      return OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: buttonStyle,
        child: _buildContent(),
      );
    }

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: buttonStyle,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: UISizes.width.w16, color: _textColor),
          SizedBox(width: UISizes.width.w8),
          Text(
            text,
            style: TextStyle(
              fontSize: UISizes.font.sp14,
              fontWeight: FontWeight.w600,
              color: _textColor,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: UISizes.font.sp14,
        fontWeight: FontWeight.w600,
        color: _textColor,
      ),
    );
  }
}
