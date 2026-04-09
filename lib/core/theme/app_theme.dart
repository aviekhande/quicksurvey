import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.kColorPrimaryBg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.kColorPrimary,
          secondary: AppColors.kColorSecondary,
          surface: AppColors.kColorWhite5,
          error: AppColors.kColorError,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.kColorPrimaryBg,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kColorPrimaryText),
          titleTextStyle: TextStyle(
            color: AppColors.kColorPrimaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.kColorWhite5,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorCrlBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorCrlBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorPrimary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorError),
          ),
          hintStyle: const TextStyle(
            color: AppColors.kColorWhite50,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
          labelStyle: const TextStyle(
            color: AppColors.kColorWhite75,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
          errorStyle: const TextStyle(
            color: AppColors.kColorError,
            fontSize: 12,
            fontFamily: 'Roboto',
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kColorPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.kColorWhite5,
          contentTextStyle: const TextStyle(
            color: AppColors.kColorPrimaryText,
            fontFamily: 'Roboto',
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
