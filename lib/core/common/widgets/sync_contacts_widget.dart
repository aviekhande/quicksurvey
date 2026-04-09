// // sync_contacts_widget.dart
// import 'dart:developer';

// import 'package:caesar_cipher/core/common/cubits/contacts_permission/contacts_permission_cubit.dart';
// import 'package:caesar_cipher/core/common/cubits/contacts_permission/contacts_permission_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:caesar_cipher/core/constants/app_icons.dart';
// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:caesar_cipher/core/theme/font_size.dart';
// import 'package:caesar_cipher/core/theme/text_styles.dart';

// class SyncContactsWidget extends StatelessWidget {
//   final VoidCallback? onContactsSynced;

//   const SyncContactsWidget({super.key, this.onContactsSynced});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ContactsPermissionCubit, ContactsPermissionState>(
//       listener: (context, state) {
//         if (state.status == ContactsPermissionStatus.granted) {
//           // Contacts permission granted, trigger callback
//           onContactsSynced?.call();
//         }

//         if (state.errorMessage != null) {
//           // Clear error after showing
//           context.read<ContactsPermissionCubit>().clearError();
//         }
//       },
//       builder: (context, state) {
//         // Only show sync button if permission is denied or permanently denied
//         if (state.status == ContactsPermissionStatus.denied ||
//             state.status == ContactsPermissionStatus.permanentlyDenied) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 18.w),
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: AppColors.kColorPrimaryBg,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: AppColors.kColorWhite15, width: 1.w),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8.w),
//                       decoration: BoxDecoration(
//                         color: AppColors.kColorPurple100.withAlpha(
//                           (0.1 * 255).toInt(),
//                         ),
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: SvgPicture.asset(
//                         AppIcons.forwardIc, // You can use a contacts icon here
//                         height: 20.w,
//                         width: 20.w,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.kColorPurple100,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Sync Contacts',
//                             style: kTextStyleDMSans600.copyWith(
//                               fontSize: FontSize.f16,
//                               color: AppColors.kColorWhite100,
//                             ),
//                           ),
//                           SizedBox(height: 4.h),
//                           Text(
//                             state.status ==
//                                     ContactsPermissionStatus.permanentlyDenied
//                                 ? 'Please enable contacts permission in settings to sync your contacts'
//                                 : 'Please enable contacts permission in settings to sync your contacts',
//                             style: kTextStyleDMSans500.copyWith(
//                               fontSize: FontSize.f14,
//                               color: AppColors.kColorWhite75,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 GestureDetector(
//                   onTap: state.isLoading
//                       ? null
//                       : () async {
//                           // if (state.status ==
//                           //     ContactsPermissionStatus.permanentlyDenied) {
//                           //   // Open app settings for permanently denied
//                           // await context
//                           //     .read<ContactsPermissionCubit>()
//                           //     .openAppSettings();
//                           // } else {
//                           // Request permission for denied
//                           await context
//                               .read<ContactsPermissionCubit>()
//                               .openAppSettings();
//                           log(" Permossion press message");
//                           print("HERER");
//                           // }
//                         },
//                   child: Container(
//                     width: double.infinity,
//                     height: 48.h,
//                     decoration: BoxDecoration(
//                       color: state.isLoading
//                           ? AppColors.kColorPurple100.withAlpha(
//                               (0.5 * 255).toInt(),
//                             )
//                           : AppColors.kColorPurple100,
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                     child: Center(
//                       child: Text(
//                         state.status ==
//                                 ContactsPermissionStatus.permanentlyDenied
//                             ? 'Open Settings'
//                             : 'Sync Contacts',
//                         style: kTextStyleDMSans600.copyWith(
//                           fontSize: FontSize.f16,
//                           color: AppColors.kColorWhite100,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         // Don't show anything if permission is granted or initial
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
