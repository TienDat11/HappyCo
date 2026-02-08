import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// A decorative section title widget with dashed lines on both sides.
///
/// This widget displays a centered title text flanked by horizontal dashed
/// lines, creating a visually distinctive section header. The dashed lines
/// are rendered using a custom painter for pixel-perfect accuracy.
///
/// **Used in:**
/// - [HomePage]: Section headers for "Sản phẩm nổi bật" and "Gợi ý hôm nay"
/// - [CategoryPage]: Category name header (e.g., "Bộ bàn ăn", "Ghế ăn")
/// - [ProductGrid]: Optional decorative title for product sections
///
/// **Design Specs:**
/// - Title: Primary color (#D32D27), 16sp, SemiBold (600)
/// - Dashed lines: Primary color, 4px dash + 4px space, 1px height
/// - Horizontal padding: 8px between title and lines
///
/// **Example:**
/// ```dart
/// SectionTitle(title: 'Sản phẩm nổi bật')
/// ```
///
/// **Example (Category):**
/// ```dart
/// SectionTitle(title: 'Bộ bàn ăn')
/// ```
class SectionTitle extends StatelessWidget {
  /// The title text to display in the center.
  ///
  /// Typically a section name like "Sản phẩm nổi bật" or category name.
  /// Should be concise to fit within the available width.
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _DashedLine(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w8),
          child: UIText(
            title: title,
            titleSize: UISizes.font.sp16,
            titleColor: UIColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Expanded(
          child: _DashedLine(),
        ),
      ],
    );
  }
}

/// Internal widget that renders a horizontal dashed line.
///
/// Uses [LayoutBuilder] to calculate the number of dashes based on
/// available width, ensuring consistent dash spacing across different
/// screen sizes.
///
/// **Specifications:**
/// - Dash width: 4px
/// - Dash height: 1px
/// - Dash spacing: 4px
/// - Color: Primary color (#D32D27)
class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dashCount, (index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index == dashCount - 1 ? 0 : dashSpace),
              child: const SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: UIColors.primary),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
