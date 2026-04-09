// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../theme/colors.dart';
// import '../../theme/text_styles.dart';

// class CustomTextfield extends StatelessWidget {
//   const CustomTextfield({
//     super.key,
//     this.controller,
//     this.onChanged,
//     this.validator,
//     this.onSaved,
//     this.labelText,
//     this.hintText,
//     this.style,
//     this.labelStyle,
//     this.hintStyle,
//     this.errorStyle,
//     this.errorMaxLines,
//     this.isPassword = false,
//     this.prefixAsset,
//     this.suffixIcon,
//     this.onEditingComplete,
//     this.onFieldSubmitted,
//     this.textInputType = TextInputType.text,
//     this.prefixIconConstraints,
//     this.contentPadding,
//     this.maxLines = 1,
//     this.initialValue,
//     this.textAlignVertical,
//     this.prefixIcon,
//     this.isReadyOnly = false,
//     this.inputFormatters,
//     this.focusNode,
//     this.enabled,
//     this.isDisabled = false,
//   });

//   final TextEditingController? controller;
//   final void Function(String)? onChanged;
//   final String? Function(String?)? validator;
//   final void Function(String?)? onSaved;
//   final VoidCallback? onEditingComplete;
//   final void Function(String)? onFieldSubmitted;
//   final String? labelText;
//   final String? hintText;
//   final TextStyle? style;
//   final TextStyle? labelStyle;
//   final TextStyle? hintStyle;
//   final TextStyle? errorStyle;
//   final int? errorMaxLines;
//   final bool? isPassword;
//   final String? prefixAsset;
//   final Widget? suffixIcon;
//   final TextInputType textInputType;
//   final BoxConstraints? prefixIconConstraints;
//   final EdgeInsets? contentPadding;
//   final int? maxLines;
//   final String? initialValue;
//   final TextAlignVertical? textAlignVertical;
//   final Widget? prefixIcon;
//   final bool? isReadyOnly;
//   final List<TextInputFormatter>? inputFormatters;
//   final FocusNode? focusNode;
//   final bool? enabled;
//   final bool? isDisabled;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         prefixAsset != null
//             ? Container(
//                 margin: EdgeInsets.only(right: 16.w),
//                 height: 24.h,
//                 width: 24.h,
//                 child: Center(
//                   child: SvgPicture.asset(prefixAsset!, fit: BoxFit.fill),
//                 ),
//               )
//             : const SizedBox(),
//         Expanded(
//           child: SizedBox(
//             child: TextFormField(
//               enabled: enabled,
//               focusNode: focusNode,
//               autocorrect: false,
//               enableSuggestions: false,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               controller: controller,
//               initialValue: initialValue,
//               readOnly: isReadyOnly!,
//               keyboardType: textInputType,
//               validator: validator,
//               maxLines: maxLines,
//               cursorColor: AppColors.kColorPrimaryText,
//               obscureText: isPassword!,
//               inputFormatters: inputFormatters,
//               style: kTextStyleDMSans500.copyWith(
//                 fontSize: 16.sp,
//                 color: isDisabled == true
//                     ? AppColors.kColorWhite50
//                     : AppColors.kColorPrimaryText,
//               ),
//               decoration: InputDecoration(
//                 disabledBorder: InputBorder.none,
//                 border: InputBorder.none,
//                 suffixIcon: suffixIcon,
//                 prefixIcon: prefixIcon,
//                 prefixIconConstraints: const BoxConstraints(),
//                 suffixIconConstraints: const BoxConstraints(),
//                 hintText: hintText,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                   borderSide: BorderSide(color: AppColors.kColorWhite50),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                   borderSide: const BorderSide(
//                     color: AppColors.kColorPrimaryText,
//                   ),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                   borderSide: const BorderSide(color: AppColors.kColorError),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.r)),
//                   borderSide: const BorderSide(color: AppColors.kColorError),
//                 ),
//                 isDense: true,
//                 errorStyle: kTextStyleDMSans500.copyWith(
//                   fontSize: 14.sp,
//                   color: AppColors.kColorError,
//                 ),
//                 labelStyle: kTextStyleDMSans400.copyWith(
//                   fontSize: 14.sp,
//                   color: AppColors.kColorWhite50,
//                 ),
//                 hintStyle:
//                     hintStyle ??
//                     kTextStyleDMSans400.copyWith(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.kColorWhite50,
//                     ),
//                 contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 16.h, 16.h),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
