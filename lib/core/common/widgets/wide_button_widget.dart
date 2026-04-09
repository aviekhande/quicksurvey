// import 'package:caesar_cipher/core/theme/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../../core/theme/colors.dart';
// import '../../../../../core/theme/font_size.dart' show FontSize;

// class WideButtonWidget extends StatelessWidget {
//   const WideButtonWidget({
//     super.key,
//     required this.title,
//     required this.onTap,
//     required this.backgroundColor,
//     required this.textColor,
//     this.borderColor = AppColors.kColorWhite75,
//   });

//   final String title;
//   final VoidCallback onTap;
//   final Color backgroundColor;
//   final Color textColor;
//   final Color borderColor;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 16.h),
//         width: double.infinity,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: borderColor)),
//           // border: Border.all(color: borderColor, width: 1.h),
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Text(
//           title,
//           style: kTextStyleDMSans600.copyWith(
//             fontSize: FontSize.f18,
//             color: textColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
