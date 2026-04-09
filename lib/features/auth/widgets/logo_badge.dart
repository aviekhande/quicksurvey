import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LogoBadge extends StatelessWidget {
  const LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.kColorPrimary.withOpacity(0.5),
            blurRadius: 32,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(AppIcons.pollOutlined, color: Colors.white, size: 40),
    );
  }
}
