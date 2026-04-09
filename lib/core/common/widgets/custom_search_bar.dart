// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:caesar_cipher/core/theme/font_size.dart';
// import 'package:caesar_cipher/core/theme/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class CustomSearchBar extends StatelessWidget {
//   const CustomSearchBar({
//     super.key,
//     required this.hintText,
//     required this.iconUrl,
//     this.searchController,
//     this.focusNode,
//     this.onchange,
//   });
//   final String hintText;
//   final String iconUrl;
//   final FocusNode? focusNode;
//   final TextEditingController? searchController;
//   final void Function(String?)? onchange;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.kColorPrimaryBg,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.kColorWhite15, width: 1.w),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 8.w),
//       child: TextField(
//         focusNode: focusNode,
//         controller: searchController,
//         cursorColor: AppColors.kColorWhite100,
//         style: kTextStyleDMSans500.copyWith(
//           color: AppColors.kColorWhite100,
//           fontSize: FontSize.f14,
//         ),

//         onChanged: onchange,
//         decoration: InputDecoration(
//           suffixStyle: kTextStyleDMSans500.copyWith(
//             // Added text style for input text
//             color: AppColors.kColorWhite100,
//             fontSize: FontSize.f14,
//           ),
//           isDense: true,
//           fillColor: AppColors.kColorPrimaryBg,
//           hintText: hintText,
//           hintStyle: kTextStyleDMSans500.copyWith(
//             color: AppColors.kColorWhite50,
//             fontSize: FontSize.f14,
//           ),
//           prefixIcon: Padding(
//             padding: EdgeInsets.all(6.w),
//             child: SizedBox(
//               height: 24.w,
//               width: 24.w,
//               child: Center(
//                 child: SvgPicture.asset(iconUrl, height: 24.w, width: 24.w),
//               ),
//             ),
//           ),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 16.h),
//         ),
//       ),
//     );
//   }
// }
