import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Decorative Section Title Widget
///
/// Displays section title with dashed red lines on both sides
/// Used for product sections like "Sản phẩm nổi bật" and "Gợi ý hôm nay"
class DecorativeSectionTitle extends StatelessWidget {
  final String title;

  const DecorativeSectionTitle({
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
