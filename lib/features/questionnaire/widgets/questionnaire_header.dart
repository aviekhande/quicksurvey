import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/questionnaire_controller.dart';

class QHeader extends GetView<QuestionnaireController> {
  const QHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.kColorCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kColorBorder),
              ),
              child: const Icon(
                AppIcons.arrowBackIosNewRounded,
                color: AppColors.kColorText,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.questionnaire.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kColorText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Obx(
                  () => Text(
                    'Question ${controller.currentPage.value + 1} of ${controller.totalQuestions}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kColorTextMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            final answered = controller.selectedAnswers.length;
            final total = controller.totalQuestions;
            final done = answered == total;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: done
                    ? AppColors.kColorSecondary.withOpacity(0.15)
                    : AppColors.kColorPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: done
                      ? AppColors.kColorSecondary.withOpacity(0.4)
                      : AppColors.kColorPrimary.withOpacity(0.3),
                ),
              ),
              child: Text(
                '$answered/$total',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: done
                      ? AppColors.kColorSecondary
                      : AppColors.kColorPrimary,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ProgressBar extends GetView<QuestionnaireController> {
  const ProgressBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Obx(() {
        final progress = controller.pageProgress;
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                builder: (_, val, __) => LinearProgressIndicator(
                  value: val,
                  backgroundColor: AppColors.kColorBorder,
                  valueColor: const AlwaysStoppedAnimation(
                    AppColors.kColorPrimary,
                  ),
                  minHeight: 5,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class DotIndicator extends GetView<QuestionnaireController> {
  const DotIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Obx(() {
        final current = controller.currentPage.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(controller.totalQuestions, (i) {
            final answered = controller.selectedAnswers.containsKey(i);
            final isCurrent = i == current;
            return GestureDetector(
              onTap: () => controller.jumpToPage(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isCurrent ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isCurrent
                      ? AppColors.kColorPrimary
                      : answered
                      ? AppColors.kColorSecondary.withOpacity(0.7)
                      : AppColors.kColorBorder,
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
