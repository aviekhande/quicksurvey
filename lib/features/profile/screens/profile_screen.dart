import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../questionnaire/models/submission_model.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorPrimaryBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(),
                    const SizedBox(height: 24),
                    _buildStatsCard(),
                    const SizedBox(height: 24),
                    _buildSubmissionHistory(),
                    const SizedBox(height: 32),
                    _buildLogoutButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.kColorWhite5,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.kColorCrlBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.kColorPrimaryText, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.kColorPrimaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kColorWhite5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kColorCrlBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.kColorPrimary, Color(0xFF9B59B6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                (controller.userPhone.isNotEmpty
                        ? controller.userPhone[0]
                        : 'U')
                    .toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Logged In User',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kColorWhite50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                      controller.userPhone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kColorPrimaryText,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.kColorStatusSuccess.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.kColorStatusSuccess.withOpacity(0.3)),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.kColorStatusSuccess,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kColorPrimary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kColorPrimary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.kColorPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.assignment_turned_in_outlined,
                color: AppColors.kColorPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Questionnaires Filled',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.kColorWhite75,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '${controller.submissionCount.value}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kColorPrimary,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Submission History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.kColorPrimaryText,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.submissions.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.kColorWhite5,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.kColorCrlBorder),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Icon(Icons.inbox_outlined,
                        color: AppColors.kColorWhite25, size: 40),
                    SizedBox(height: 12),
                    Text(
                      'No submissions yet',
                      style: TextStyle(
                        color: AppColors.kColorWhite50,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            children: controller.submissions
                .map((s) => _SubmissionItem(submission: s))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () => _showLogoutDialog(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kColorError.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.kColorError.withOpacity(0.3)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded,
                color: AppColors.kColorError, size: 20),
            SizedBox(width: 10),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.kColorError,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.kColorWhite5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(
              color: AppColors.kColorPrimaryText, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppColors.kColorWhite75),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.kColorWhite50)),
          ),
          TextButton(
            onPressed: controller.logout,
            child: const Text('Logout',
                style: TextStyle(
                    color: AppColors.kColorError,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _SubmissionItem extends StatelessWidget {
  const _SubmissionItem({required this.submission});
  final SubmissionModel submission;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kColorWhite5,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.kColorCrlBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.kColorStatusSuccess.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_circle_outline,
                color: AppColors.kColorStatusSuccess, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  submission.questionnaireName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kColorPrimaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 12, color: AppColors.kColorWhite50),
                    const SizedBox(width: 4),
                    Text(
                      submission.formattedDate,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.kColorWhite50,
                      ),
                    ),
                  ],
                ),
                if (submission.latitude != null) ...[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 12, color: AppColors.kColorWhite25),
                      const SizedBox(width: 4),
                      Text(
                        '${submission.latitude!.toStringAsFixed(4)}, ${submission.longitude!.toStringAsFixed(4)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.kColorWhite25,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
