import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// Standardized Button Styles for Happyco Design System
///
/// All buttons should use these predefined styles for consistency
class AppButtonStyle {
  /// Primary filled button style with wood theme
  static ButtonStyle get primaryFillButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: UIColors.primary,
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISizes.square.r12),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }

  /// Secondary outlined button style
  static ButtonStyle get secondaryOutlineButtonStyle {
    return OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: UISizes.width.w16,
        vertical: UISizes.height.h8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISizes.square.r12),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      side: const BorderSide(
        width: 1.0,
        color: UIColors.primary,
      ),
    );
  }

  /// White filled button style (for contrast on dark backgrounds)
  static ButtonStyle get whiteFillButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: UIColors.white,
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISizes.square.r12),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }

  /// Small button style for compact spaces
  static ButtonStyle get smallButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: UIColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: UISizes.width.w12,
        vertical: UISizes.height.h6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISizes.square.r8),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      minimumSize: Size(UISizes.width.w64, UISizes.height.h32),
    );
  }
}
