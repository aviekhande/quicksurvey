import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../questionnaire/models/questionnaire_model.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorPrimaryBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kColorPrimary,
                      strokeWidth: 2.5,
                    ),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.kColorPrimary,
                  backgroundColor: AppColors.kColorWhite5,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 600));
                    controller.questionnaires.refresh();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: controller.questionnaires.length,
                    itemBuilder: (context, index) {
                      final q = controller.questionnaires[index];
                      return _QuestionnaireCard(
                        questionnaire: q,
                        index: index,
                        onTap: () => controller.openQuestionnaire(q),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final authCtrl = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Questionnaires',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kColorPrimaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                authCtrl.currentUser?.phone ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.kColorWhite50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: controller.goToProfile,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.kColorPrimary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.kColorPrimary.withOpacity(0.3)),
              ),
              child: const Icon(Icons.person_outline,
                  color: AppColors.kColorPrimary, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionnaireCard extends StatelessWidget {
  const _QuestionnaireCard({
    required this.questionnaire,
    required this.index,
    required this.onTap,
  });

  final QuestionnaireModel questionnaire;
  final int index;
  final VoidCallback onTap;

  static const _icons = [
    Icons.star_outline_rounded,
    Icons.group_outlined,
    Icons.tune_outlined,
    Icons.favorite_outline,
    Icons.devices_outlined,
  ];

  static const _colors = [
    AppColors.kColorPrimary,
    AppColors.kColorSecondary,
    Color(0xFFF39C12),
    Color(0xFFE74C3C),
    Color(0xFF9B59B6),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[index % _colors.length];
    final icon = _icons[index % _icons.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.kColorWhite5,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kColorCrlBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questionnaire.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kColorPrimaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    questionnaire.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kColorWhite50,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _Chip(
                        label:
                            '${questionnaire.questions.length} questions',
                        icon: Icons.help_outline_rounded,
                        color: color,
                      ),
                      const SizedBox(width: 8),
                      _Chip(
                        label: 'MCQ',
                        icon: Icons.check_circle_outline,
                        color: AppColors.kColorWhite25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.kColorWhite25, size: 22),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
