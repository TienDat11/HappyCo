import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/theme/ui_svgs.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/notification_entity.dart';

class NotificationItemWidget extends StatelessWidget {
  final List<NotificationEntity> items;
  final void Function(NotificationEntity)? onTap;

  const NotificationItemWidget({
    super.key,
    required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final bool isUnread = !item.isRead;

        return GestureDetector(
          onTap: () => onTap?.call(item),
          child: Container(
            margin: EdgeInsets.only(bottom: UISizes.height.h12),
            padding: EdgeInsets.all(UISizes.width.w12),
            decoration: BoxDecoration(
              color: isUnread ? UIColors.red50 : UIColors.white,
              borderRadius: BorderRadius.circular(UISizes.square.r12),
              border: BoxBorder.all(color: UIColors.gray200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(item.iconName),
                SizedBox(width: UISizes.width.w12),

                /// Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIText(
                        title: item.title,
                        titleSize: UISizes.font.sp14,
                        fontWeight: FontWeight.w600,
                        titleColor: UIColors.red500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      ),
                      SizedBox(height: UISizes.height.h4),
                      UIText(
                        title: item.description,
                        titleSize: UISizes.font.sp13,
                        titleColor: UIColors.gray500,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                /// Unread dot
                if (isUnread)
                  Padding(
                    padding: EdgeInsets.only(
                      left: UISizes.width.w8,
                      top: UISizes.height.h4,
                    ),
                    child: Container(
                      width: UISizes.square.r7,
                      height: UISizes.square.r7,
                      decoration: const BoxDecoration(
                        color: UIColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIcon(String? iconName) {
    return Container(
      width: UISizes.width.w40,
      height: UISizes.height.h40,
      decoration: BoxDecoration(
        color: UIColors.red50,
        borderRadius: BorderRadius.circular(UISizes.square.r10),
      ),
      child: Center(
        child: SizedBox(
          width: UISizes.width.w24,
          height: UISizes.height.h24,
          child: SvgPicture.asset(
            _mapIcon(iconName),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  String _mapIcon(String? iconName) {
    switch (iconName) {
      case 'discount':
        return UISvgs.notiDiscountSvg;
      case 'order_confirm':
        return UISvgs.notiOderSvg;
      case 'shipping':
        return UISvgs.notiCarInTransitSvg;
      case 'delivered':
        return UISvgs.notiCarDeliveredSvg;
      case 'new_product':
        return UISvgs.notiSettingSvg;
      default:
        return UISvgs.notiSettingSvg;
    }
  }
}
