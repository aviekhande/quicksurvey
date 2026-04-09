// import 'package:caesar_cipher/core/theme/text_styles.dart'
//     show kTextStyleDMSans600;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../theme/colors.dart';

// class EmptyListWidget extends StatelessWidget {
//   final String image;
//   final String title;
//   final double? height;
//   final double? width;
//   const EmptyListWidget(
//     BuildContext context, {
//     required this.image,
//     required this.title,
//     super.key,
//     this.height,
//     this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // final screenHeight = MediaQuery.of(context).size.height;
//     // final screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       height: height! * 2,
//       width: width,
//       color: AppColors.kColorPrimaryBg,
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(height: height, width: width, image, fit: BoxFit.fill),
//           SizedBox(height: 24.h),
//           Text(
//             textAlign: TextAlign.center,
//             title,
//             style: kTextStyleDMSans600.copyWith(
//               fontSize: 18.sp,
//               color: AppColors.kColorWhite,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //---------- > Use For Chat
// //  EmptyListWidget(
// //           image: AppImages.mailCrossImg,
// //           height: 114.h,
// //           width: 248.w,
// //           title: "No chats.\nAdd people from contacts to chat",
// //         ),
// //---------- > Use For No Internet
// // EmptyListWidget(
// //           image: AppImages.noConnectionImg,
// //           height: 164.h,
// //           width: 267.w,
// //           title: "Oops... Please check your connection",
// //         ),
