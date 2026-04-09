import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.gradientSuccess,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.kColorSecondary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            AppIcons.personAddAlt1Rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.kColorText,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Register to start filling surveys and tracking insights',
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
