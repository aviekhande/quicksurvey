import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.kColorPrimary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(AppIcons.boltRounded, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 24),
        const Text(
          'Welcome Back! 👋',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.kColorText,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sign in to continue your survey journey',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.kColorTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
