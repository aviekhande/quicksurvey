// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// // import '../../constants/app_icons.dart';
// import '../../constants/app_icons.dart';
// // import 'package:lottie/lottie.dart';

// class LoaderWidget extends StatefulWidget {
//   const LoaderWidget({super.key});

//   @override
//   State<LoaderWidget> createState() => _LoaderWidgetState();
// }

// class _LoaderWidgetState extends State<LoaderWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   final screenHeight = MediaQuery.of(context).size.height;
//   //   final screenWidth = MediaQuery.of(context).size.width;
//   //   return Container(
//   //     height: screenHeight,
//   //     width: screenWidth,
//   //     color: AppColors.kColorTransparent,
//   //     child: Center(
//   //       child: CircularProgressIndicator(color: AppColors.kColorPrimary),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withValues(alpha: 0.7),
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Center(
//         child: Lottie.asset(
//           AppIcons.appApiLoader,
//           fit: BoxFit.cover,
//           animate: true,
//         ),
//       ),
//     );
//   }
// }
