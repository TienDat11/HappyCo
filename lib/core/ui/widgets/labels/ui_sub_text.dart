// import 'package:flutter/material.dart';
// import 'package:happyco/core/theme/ui_colors.dart';
// import 'package:happyco/core/theme/ui_sizes.dart';
// import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

// class UiSubText extends StatelessWidget {
//   final String text;
//   final Widget? icon;
//   final Color? textColor;
//   final double? fontSize;
//   final FontWeight? fontWeight;
//   final EdgeInsetsGeometry? padding;

//   const UiSubText({
//     super.key,
//     required this.text,
//     this.icon,
//     this.textColor,
//     this.fontSize,
//     this.fontWeight,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding ??
//           EdgeInsets.only(bottom: UISizes.height.h6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null) ...[
//             icon!,
//             SizedBox(width: UISizes.width.w8),
//           ],

//           Expanded(
//             child: UIText(
//               title: text,
//               titleSize: fontSize ?? UISizes.font.sp14,
//               titleColor: textColor ?? UIColors.gray500,
//               fontWeight: fontWeight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
