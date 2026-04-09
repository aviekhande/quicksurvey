// import 'dart:io';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../services/network/bloc/network_bloc.dart';
// import '../../../theme/app_dimens.dart';
// import '../../../theme/colors.dart';
// import '../../../theme/font_size.dart';
// import '../../../theme/text_styles.dart';

// Future<File?> showModelBottomSheetDeleteAcc({
//   required BuildContext context,
//   required GestureTapCallback onDeleteTap,
// }) {
//   return showModalBottomSheet<File?>(
//     shape: BeveledRectangleBorder(),
//     backgroundColor: AppColors.kColorPrimaryBg,
//     context: context,
//     builder: (BuildContext context) {
//       return BlocListener<NetworkBloc, NetworkState>(
//         listener: (context, state) {
//           // Close bottom sheet when network failure is detected
//           if (state is NetworkFailure) {
//             context.router.maybePop();
//           }
//         },
//         child: Container(
//           padding: EdgeInsets.all(AppDimens.p22),
//           decoration: BoxDecoration(
//             border: Border(top: BorderSide(color: AppColors.kColorCrlBorder)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: 48.h,
//                     width: 48.h,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColors.kColorWhite15),
//                       color: AppColors.kColorError,
//                     ),
//                     child: SizedBox(
//                       height: 24.h,
//                       width: 24.h,
//                       child: Center(
//                         child: SvgPicture.asset(
//                           "AppIcons.personRemoveIc",
//                           // AppIcons.uploadIc,
//                           fit: BoxFit.cover,
//                           height: 24.h,
//                           width: 24.h,
//                         ),
//                       ),
//                     ),
//                   ),

//                   SizedBox(width: 16.w),
//                   Text(
//                     'Delete Account?',
//                     style: kTextStyleDMSans600.copyWith(
//                       fontSize: FontSize.f20,
//                       color: AppColors.kColorWhite,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 "This will permanently remove your account and all data. This action cannot be undone.",
//                 style: kTextStyleDMSans400.copyWith(
//                   color: AppColors.kColorWhite75,
//                   fontSize: FontSize.f16,
//                 ),
//               ),
//               SizedBox(height: 40.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: onDeleteTap,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: AppDimens.p16),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           color: AppColors.kColorError,
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Delete",
//                             style: kTextStyleDMSans600.copyWith(
//                               color: AppColors.kColorWhite,
//                               fontSize: FontSize.f16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         context.router.maybePop();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: AppDimens.p16),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           color: AppColors.kColorWhite,
//                         ),
//                         child: Center(
//                           child: Text(
//                             "No, go back",
//                             style: kTextStyleDMSans600.copyWith(
//                               color: AppColors.kColorWhite,
//                               fontSize: FontSize.f16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
