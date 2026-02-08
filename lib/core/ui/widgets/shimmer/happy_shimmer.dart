import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:happyco/core/theme/ui_theme.dart';

/// HappyShimmer - Base shimmer widget for the app
///
/// Uses standard gray palette from UIColors
class HappyShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const HappyShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 0,
  });

  /// Factory for circular shimmer
  factory HappyShimmer.circular({
    required double size,
  }) {
    return HappyShimmer(
      width: size,
      height: size,
      borderRadius: size / 2,
    );
  }

  /// Factory for rounded rectangle shimmer
  factory HappyShimmer.rounded({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return HappyShimmer(
      width: width,
      height: height,
      borderRadius: borderRadius ?? 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: UIColors.gray200,
      highlightColor: UIColors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
