// import 'dart:io';

// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Future<void> curvedBottomSheet({
//   required BuildContext context,
//   // required double height,
//   required List<Widget> children,
// }) async {
//   await showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: ClipPath(
//         clipper: WaveClipper(),
//         child: Container(
//           // height: height,
//           width: MediaQuery.of(context).size.width,
//           color: AppColors.kColorWhite0,
//           padding: EdgeInsets.only(
//             left: 20.w,
//             right: 20.w,
//             top: 40, // Increased top padding to account for wave
//             // bottom: 10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 68.h,
//                   height: 5.h,
//                   decoration: BoxDecoration(
//                     color: AppColors.kTextWhite25,
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 56.h),
//               for (int i = 0; i < children.length; i++) children[i],
//               Platform.isIOS ? SizedBox(height: 28.h) : SizedBox.shrink(),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     const radius = 10.0;
//     const waveHeight = 25.0;
//     final path = Path();

//     path.moveTo(0, radius + waveHeight);

//     // Top-left rounded corner
//     path.quadraticBezierTo(0, waveHeight, radius, waveHeight);

//     // Smooth entry into the wave (instead of sharp line)
//     path.quadraticBezierTo(
//       size.width * 0.20,
//       waveHeight, // control point
//       size.width * 0.25,
//       waveHeight, // end point
//     );

//     // Central upward wave
//     path.quadraticBezierTo(
//       size.width * 0.5,
//       0, // peak of the wave
//       size.width * 0.75,
//       waveHeight, // end of wave
//     );

//     // Smooth exit from the wave
//     path.quadraticBezierTo(
//       size.width * 0.80,
//       waveHeight,
//       size.width - radius,
//       waveHeight,
//     );

//     // Top-right rounded corner
//     path.quadraticBezierTo(
//       size.width,
//       waveHeight,
//       size.width,
//       radius + waveHeight,
//     );

//     // Down the sides and across the bottom
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
