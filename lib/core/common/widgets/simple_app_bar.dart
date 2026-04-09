// import 'package:caesar_cipher/core/constants/app_icons.dart';
// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:caesar_cipher/core/theme/font_size.dart';
// import 'package:caesar_cipher/core/theme/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class SimpleAppBar extends StatelessWidget {
//   final String title;
//   final void Function()? onBackPress;

//   const SimpleAppBar({super.key, required this.title, this.onBackPress});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Stack(
//           children: [
//             Container(
//               width: 54.w,
//               height: 24.h,
//               color: AppColors.kColorTransparent,
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 12.w, left: 18.w),
//               child: SvgPicture.asset(
//                 AppIcons.arrowBackIc,
//                 height: 24.h,
//                 width: 24.h,
//               ),
//             ),
//             GestureDetector(
//               onTap: onBackPress,
//               child: Container(
//                 width: 54.w,
//                 height: 24.h,
//                 color: AppColors.kColorTransparent,
//               ),
//             ),
//           ],
//         ),

//         // SizedBox(width: 12.w),
//         Text(
//           title,
//           style: kTextStyleDMSans600.copyWith(
//             color: AppColors.kColorWhite100,
//             fontSize: FontSize.f24,
//           ),
//         ),
//       ],
//     );
//   }
// }
