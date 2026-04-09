// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';

// class ShimmerPlaceholder extends StatelessWidget {
//   final double width;
//   final double height;
//   final ShapeBorder shapeBorder;

//   const ShimmerPlaceholder({
//     super.key,
//     required this.width,
//     required this.height,
//     this.shapeBorder = const RoundedRectangleBorder(),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade800,
//       highlightColor: Colors.grey.shade700,
//       child: Container(
//         width: width,
//         height: height,

//         decoration: BoxDecoration(
//           color: Colors.grey.shade800,
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//       ),
//     );
//   }
// }
