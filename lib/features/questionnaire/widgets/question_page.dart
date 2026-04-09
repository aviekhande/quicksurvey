import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/questionnaire_controller.dart';

class QuestionPage extends GetView<QuestionnaireController> {
  const QuestionPage({required this.questionIndex});
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final q = controller.questionnaire.questions[questionIndex];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.kColorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.kColorPrimary.withOpacity(0.25),
              ),
            ),
            child: Text(
              'Q${questionIndex + 1} of ${controller.totalQuestions}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.kColorPrimary,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            q.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.kColorText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          ...q.options.asMap().entries.map(
            (entry) => OptionTile(
              questionIndex: questionIndex,
              optionIndex: entry.key,
              label: entry.value.text,
              letter: String.fromCharCode(65 + entry.key),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends GetView<QuestionnaireController> {
  const OptionTile({
    required this.questionIndex,
    required this.optionIndex,
    required this.label,
    required this.letter,
  });
  final int questionIndex;
  final int optionIndex;
  final String label;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.isSelected(questionIndex, optionIndex);
      return GestureDetector(
        onTap: () => controller.selectAnswer(questionIndex, optionIndex),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.kColorPrimary.withOpacity(0.1)
                : AppColors.kColorCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? AppColors.kColorPrimary
                  : AppColors.kColorBorder,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.kColorPrimary.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: selected ? AppColors.gradientPrimary : null,
                  color: selected ? null : AppColors.kColorBorder,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: selected
                      ? const Icon(
                          AppIcons.checkRounded,
                          color: Colors.white,
                          size: 19,
                        )
                      : Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.kColorTextSecondary,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected
                        ? AppColors.kColorText
                        : AppColors.kColorTextSecondary,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: selected
                    ? const Icon(
                        AppIcons.radioButtonCheckedRounded,
                        key: ValueKey('on'),
                        color: AppColors.kColorPrimary,
                        size: 22,
                      )
                    : const Icon(
                        AppIcons.radioButtonUncheckedRounded,
                        key: ValueKey('off'),
                        color: AppColors.kColorBorder,
                        size: 22,
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
