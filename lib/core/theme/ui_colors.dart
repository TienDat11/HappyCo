import 'package:flutter/material.dart';

/// UIColors - Happyco Furniture E-commerce Theme
///
/// Based on Figma Design Node 1-728
/// Primary Color: #C0333C (Red)
/// Design System: Clean, modern e-commerce UI
class UIColors {
  // ============================================
  // FIGMA DESIGN SYSTEM COLORS
  // ============================================

  /// Primary Brand Color - Red from Figma (#C0333C)
  static const Color primary = Color(0xFFC0333C);
  static const Color primaryLight = Color(0xFFE57373);
  static const Color primaryDark = Color(0xFF8B2229);

  /// Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color backgroundSecondary = Color(0xFFFAFAFA); // Gray/50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  /// Text Colors (from Figma)
  static const Color text = Color(0xFF3F3F46); // Gray/700
  static const Color textSecondary = Color(0xFF71717A); // Gray/500
  /// Text color for category labels
  static const Color categoryLabel = Color(0xFF40484F);
  static const Color textHint = Color(0xFFD4D4D8); // Gray/300

  static const Color textOnPrimary =
      Color(0xFFFAFAFA); // Gray/50 (almost white)

  // ============================================
  // GRAY SCALE (from Figma)
  // ============================================

  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF4F4F5);
  static const Color gray200 = Color(0xFFE4E4E7);
  static const Color gray300 = Color(0xFFD4D4D8);
  static const Color gray400 = Color(0xFFA1A1AA);
  static const Color gray500 = Color(0xFF71717A);
  static const Color gray600 = Color(0xFF52525B);
  static const Color gray700 = Color(0xFF3F3F46);
  static const Color gray800 = Color(0xFF27272A);
  static const Color gray900 = Color(0xFF18181B);

  // ============================================
  // RED ACCENT COLORS (from Figma)
  // ============================================

  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red200 = Color(0xFFFECACA);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = Color(0xFFEF4444); // Notification badge
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);
  static const Color red800 = Color(0xFF991B1B);
  static const Color red900 = Color(0xFF7F1D1D);

  // ============================================
  // FUNCTIONAL COLORS
  // ============================================

  static const Color success = Color(0xFF22C55E); // Green
  static const Color warning = Color(0xFFF59E0B); // Orange
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // ============================================
  // BASE COLORS
  // ============================================

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  // ============================================
  // UI ELEMENT COLORS
  // ============================================

  /// Borders & Dividers
  static const Color border = Color(0xFFF4F4F5); // Gray/100
  static const Color divider = Color(0xFFE4E4E7); // Gray/200

  /// Shadows (with opacity for runtime use)
  static Color get cardShadow => Colors.black.withValues(alpha: 0.08);
  static Color get navBarShadow =>
      const Color(0xFFC0333C).withValues(alpha: 0.08);
  static Color get shadowSubtle => Colors.black.withValues(alpha: 0.05);
  static Color get shadowMedium => Colors.black.withValues(alpha: 0.12);

  // ============================================
  // WOOD/FURNITURE MATERIAL COLORS (Legacy)
  // ============================================

  /// Oak Wood
  static final Color oakWood = HexColor.fromHex("#DEB887");

  /// Walnut Wood
  static final Color walnutWood = HexColor.fromHex("#8B4513");

  /// Pine Wood
  static final Color pineWood = HexColor.fromHex("#F4E4C1");

  /// Teak Wood
  static final Color teakWood = HexColor.fromHex("#D2691E");

  /// Mahogany Wood
  static final Color mahoganyWood = HexColor.fromHex("#CD853F");

  /// Cedar Wood
  static final Color cedarWood = HexColor.fromHex("#A0522D");

  // ============================================
  // ADDITIONAL PALETTES (for comprehensive coverage)
  // ============================================

  // Green Palette (success states)
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green200 = Color(0xFFBBF7D0);
  static const Color green300 = Color(0xFF86EFAC);
  static const Color green400 = Color(0xFF4ADE80);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);

  // Blue Palette (info states)
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color blue300 = Color(0xFF93C5FD);
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);

  // Orange Palette (warning states)
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange200 = Color(0xFFFED7AA);
  static const Color orange300 = Color(0xFFFDBA74);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
  static const Color orange600 = Color(0xFFEA580C);
}

/// HexColor extension for converting hex strings to Color
///
/// Supports formats:
/// - `#RRGGBB` (6-digit hex)
/// - `#AARRGGBB` (8-digit hex with alpha)
/// - `RRGGBB` (6-digit without #)
/// - `AARRGGBB` (8-digit without #)
extension HexColor on Color {
  /// Creates a Color from a hex string
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();

    // Add alpha if not present (opaque by default)
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }

    // Remove # if present
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
