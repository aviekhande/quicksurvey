import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';

class LogoutButton extends GetView<ProfileController> {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _confirmLogout,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.kColorError.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.kColorError.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppColors.kColorError, size: 20),
            SizedBox(width: 10),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.kColorError,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.kColorCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.kColorBorder, width: 1),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            color: AppColors.kColorText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Are you sure you want to sign out? Your offline data will remain intact.',
          style: TextStyle(
            color: AppColors.kColorTextSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.kColorTextMuted),
            ),
          ),
          TextButton(
            onPressed: controller.logout,
            child: const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.kColorError,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
