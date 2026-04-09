// import 'dart:io';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../services/network/bloc/network_bloc.dart';
// import '../../../theme/app_dimens.dart';
// import '../../../theme/colors.dart';
// import '../../../theme/font_size.dart';
// import '../../../theme/text_styles.dart';
// import '../../../utils/utils.dart';

// Future<File?> showModelBottomSheet({
//   required BuildContext context,
//   required Function(File) imageFile,
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
//             border: Border(top: BorderSide(color: AppColors.kColorPrimary)),
//           ),
//           height: 252.h,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: 48.h,
//                     width: 48.h,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColors.kColorWhite15),
//                       color: AppColors.kColorPrimaryBg,
//                     ),
//                     child: SizedBox(
//                       height: 24.h,
//                       width: 24.h,
//                       child: Center(
//                         child: SvgPicture.asset(
//                           "AppIcons.photoCameraBackIc",
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
//                     'Upload',
//                     style: kTextStyleDMSans600.copyWith(
//                       fontSize: FontSize.f20,
//                       color: AppColors.kColorWhite,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Expanded(
//                 // ignore: avoid_unnecessary_containers
//                 child: Container(
//                   // color: Colors.amberAccent,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           // Todo: call imagePicker
//                           File? pickedImage = await Utils.pickImage(false);
//                           if (pickedImage != null && context.mounted) {
//                             imageFile(File(pickedImage.path));
//                             Navigator.of(context).pop();
//                             // Navigator.of(context).pop(File(pickedImage.path));
//                           }
//                         },
//                         child: Container(
//                           color: AppColors.kColorTransparent,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 56.h,
//                                 width: 56.h,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: AppColors.kColorWhite50,
//                                   ),
//                                   color: AppColors.kColorPrimaryBg,
//                                 ),
//                                 child: SizedBox(
//                                   height: 24.h,
//                                   width: 24.h,
//                                   child: Center(
//                                     child: SvgPicture.asset(
//                                       "AppIcons.addPhotoIc",
//                                       // AppIcons.galleryIc,
//                                       fit: BoxFit.cover,
//                                       height: 24.h,
//                                       width: 24.w,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               SizedBox(height: 12.h),
//                               Text(
//                                 'Open camera',
//                                 style: kTextStyleDMSans600.copyWith(
//                                   fontSize: FontSize.f16,
//                                   color: AppColors.kColorWhite,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       VerticalDivider(
//                         color: AppColors.kColorWhite15, // Divider color
//                         thickness: 1.w, // Line thickness
//                         endIndent: 10.h,
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           // Todo: call imagePicker
//                           File? pickedImage = await Utils.pickImage(true);
//                           if (pickedImage != null && context.mounted) {
//                             imageFile(File(pickedImage.path));
//                             Navigator.of(context).pop();
//                             // Navigator.of(context).pop(File(pickedImage.path));
//                           }
//                         },
//                         child: Container(
//                           color: AppColors.kColorTransparent,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 56.h,
//                                 width: 56.h,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: AppColors.kColorWhite50,
//                                   ),
//                                   color: AppColors.kColorPrimaryBg,
//                                 ),
//                                 child: SizedBox(
//                                   height: 24.h,
//                                   width: 24.h,
//                                   child: Center(
//                                     child: SvgPicture.asset(
//                                       "AppIcons.addPhotoGalleryIc",
//                                       // AppIcons.cameraIc,
//                                       fit: BoxFit.cover,
//                                       height: 24.h,
//                                       width: 24.w,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               SizedBox(height: 12.h),
//                               Text(
//                                 'Open Gallery',
//                                 style: kTextStyleDMSans600.copyWith(
//                                   fontSize: FontSize.f16,
//                                   color: AppColors.kColorWhite,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24.h),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
