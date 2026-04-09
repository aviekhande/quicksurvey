import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/questionnaire_controller.dart';

class QuestionnaireScreen extends GetView<QuestionnaireController> {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorPrimaryBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressBar(),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => controller.currentPage.value = i,
                itemCount: controller.totalQuestions,
                itemBuilder: (_, index) {
                  final question =
                      controller.questionnaire.questions[index];
                  return _QuestionPage(
                    questionIndex: index,
                    question: question.text,
                    options: question.options.map((o) => o.text).toList(),
                  );
                },
              ),
            ),
            _buildNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.questionnaire.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kColorPrimaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Obx(() => Text(
                      'Question ${controller.currentPage.value + 1} of ${controller.totalQuestions}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.kColorWhite50,
                      ),
                    )),
              ],
            ),
          ),
          Obx(() {
            final answered = controller.selectedAnswers.length;
            final total = controller.totalQuestions;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: answered == total
                    ? AppColors.kColorStatusSuccess.withOpacity(0.15)
                    : AppColors.kColorPrimary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: answered == total
                        ? AppColors.kColorStatusSuccess.withOpacity(0.3)
                        : AppColors.kColorPrimary.withOpacity(0.3)),
              ),
              child: Text(
                '$answered/$total',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: answered == total
                      ? AppColors.kColorStatusSuccess
                      : AppColors.kColorPrimary,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Obx(() {
        final progress =
            (controller.currentPage.value + 1) / controller.totalQuestions;
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.kColorWhite15,
            valueColor: const AlwaysStoppedAnimation(AppColors.kColorPrimary),
            minHeight: 4,
          ),
        );
      }),
    );
  }

  Widget _buildNavButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Obx(() {
        final isLast =
            controller.currentPage.value == controller.totalQuestions - 1;
        return Row(
          children: [
            if (controller.currentPage.value > 0) ...[
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: controller.prevPage,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.kColorWhite75,
                      side: const BorderSide(color: AppColors.kColorCrlBorder),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_rounded, size: 18),
                        SizedBox(width: 6),
                        Text('Back',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: 2,
              child: isLast
                  ? PrimaryButton(
                      label: 'Submit',
                      isLoading: controller.isSubmitting.value,
                      onTap: controller.submit,
                      icon: Icons.check_circle_outline,
                    )
                  : PrimaryButton(
                      label: 'Next',
                      onTap: controller.nextPage,
                      icon: Icons.arrow_forward_rounded,
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class _QuestionPage extends GetView<QuestionnaireController> {
  const _QuestionPage({
    required this.questionIndex,
    required this.question,
    required this.options,
  });

  final int questionIndex;
  final String question;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question number badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.kColorPrimary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.kColorPrimary.withOpacity(0.25)),
            ),
            child: Text(
              'Question ${questionIndex + 1}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.kColorPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.kColorPrimaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          ...options.asMap().entries.map(
                (entry) => _OptionTile(
                  questionIndex: questionIndex,
                  optionIndex: entry.key,
                  label: entry.value,
                  letter: String.fromCharCode(65 + entry.key), // A, B, C, D
                ),
              ),
        ],
      ),
    );
  }
}

class _OptionTile extends GetView<QuestionnaireController> {
  const _OptionTile({
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
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.kColorPrimary.withOpacity(0.12)
                : AppColors.kColorWhite5,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.kColorPrimary
                  : AppColors.kColorCrlBorder,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.kColorPrimary
                      : AppColors.kColorWhite15,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: selected
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 18)
                      : Text(
                          letter,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kColorWhite75,
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
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected
                        ? AppColors.kColorPrimaryText
                        : AppColors.kColorWhite75,
                  ),
                ),
              ),
              if (selected)
                const Icon(Icons.radio_button_checked_rounded,
                    color: AppColors.kColorPrimary, size: 20)
              else
                const Icon(Icons.radio_button_unchecked_rounded,
                    color: AppColors.kColorWhite25, size: 20),
            ],
          ),
        ),
      );
    });
  }
}
