import 'package:flutter/material.dart';
import 'app_colors.dart';

const kTextStyleBase = TextStyle(
  fontFamily: 'Roboto',
  color: AppColors.kColorPrimaryText,
);

TextStyle kText300(double size) =>
    kTextStyleBase.copyWith(fontSize: size, fontWeight: FontWeight.w300);

TextStyle kText400(double size) =>
    kTextStyleBase.copyWith(fontSize: size, fontWeight: FontWeight.w400);

TextStyle kText500(double size) =>
    kTextStyleBase.copyWith(fontSize: size, fontWeight: FontWeight.w500);

TextStyle kText600(double size) =>
    kTextStyleBase.copyWith(fontSize: size, fontWeight: FontWeight.w600);

TextStyle kText700(double size) =>
    kTextStyleBase.copyWith(fontSize: size, fontWeight: FontWeight.w700);
