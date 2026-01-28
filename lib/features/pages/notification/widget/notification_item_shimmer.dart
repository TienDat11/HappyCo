import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: UISizes.height.h12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon / image
          HappyShimmer.circular(
            size: UISizes.square.r40,
          ),

          SizedBox(width: UISizes.width.w12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                HappyShimmer.rounded(
                  width: double.infinity, // ✅ OK vì trong Expanded
                  height: UISizes.height.h14,
                  borderRadius: UISizes.square.r6,
                ),

                SizedBox(height: UISizes.height.h8),

                // Description
                HappyShimmer.rounded(
                  width: UISizes.width.w200,
                  height: UISizes.height.h12,
                  borderRadius: UISizes.square.r6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
