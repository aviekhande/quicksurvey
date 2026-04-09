import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/questionnaire_controller.dart';

/// Paginated MCQ questionnaire screen with progress indicator and dot navigation.
class QuestionnaireScreen extends GetView<QuestionnaireController> {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: SafeArea(
        child: Column(
          children: [
            _QHeader(),
            _ProgressBar(),
            _DotIndicator(),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => controller.currentPage.value = i,
                itemCount: controller.totalQuestions,
                itemBuilder: (_, i) => _QuestionPage(questionIndex: i),
              ),
            ),
            _NavBar(),
          ],
        ),
      ),
    );
  }
}

// ── Header ─────────────────────────────────────────────────────────────────────

class _QHeader extends GetView<QuestionnaireController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          // Back button
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
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.kColorText,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title + question counter
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
                Obx(() => Text(
                      'Question ${controller.currentPage.value + 1} of ${controller.totalQuestions}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.kColorTextMuted,
                      ),
                    )),
              ],
            ),
          ),

          // Answered count badge
          Obx(() {
            final answered = controller.selectedAnswers.length;
            final total = controller.totalQuestions;
            final done = answered == total;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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

// ── Progress bar ───────────────────────────────────────────────────────────────

class _ProgressBar extends GetView<QuestionnaireController> {
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
                  valueColor: const AlwaysStoppedAnimation(AppColors.kColorPrimary),
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

// ── Dot navigator ──────────────────────────────────────────────────────────────

class _DotIndicator extends GetView<QuestionnaireController> {
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

// ── Question page ──────────────────────────────────────────────────────────────

class _QuestionPage extends GetView<QuestionnaireController> {
  const _QuestionPage({required this.questionIndex});
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final q = controller.questionnaire.questions[questionIndex];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.kColorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.kColorPrimary.withOpacity(0.25)),
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

          // Question text
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

          // Options
          ...q.options.asMap().entries.map((entry) => _OptionTile(
                questionIndex: questionIndex,
                optionIndex: entry.key,
                label: entry.value.text,
                letter: String.fromCharCode(65 + entry.key),
              )),
        ],
      ),
    );
  }
}

// ── Option tile ────────────────────────────────────────────────────────────────

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
              // Letter badge / checkmark
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
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 19)
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

              // Option label
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected
                        ? AppColors.kColorText
                        : AppColors.kColorTextSecondary,
                  ),
                ),
              ),

              // Radio icon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: selected
                    ? const Icon(Icons.radio_button_checked_rounded,
                        key: ValueKey('on'),
                        color: AppColors.kColorPrimary,
                        size: 22)
                    : const Icon(Icons.radio_button_unchecked_rounded,
                        key: ValueKey('off'),
                        color: AppColors.kColorBorder,
                        size: 22),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ── Bottom navigation bar ──────────────────────────────────────────────────────

class _NavBar extends GetView<QuestionnaireController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.kColorBg,
        border: Border(
          top: BorderSide(
              color: AppColors.kColorBorder.withOpacity(0.5), width: 1),
        ),
      ),
      child: Obx(() {
        final isLast =
            controller.currentPage.value == controller.totalQuestions - 1;
        final canGoBack = controller.currentPage.value > 0;

        return Row(
          children: [
            // Back button (hidden on first question)
            if (canGoBack) ...[
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: OutlinedButton.icon(
                    onPressed: controller.prevPage,
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text(
                      'Back',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.kColorTextSecondary,
                      side: const BorderSide(color: AppColors.kColorBorder),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],

            // Next / Submit button
            Expanded(
              flex: 2,
              child: isLast
                  ? PrimaryButton(
                      label: 'Submit Survey',
                      isLoading: controller.isSubmitting.value,
                      onTap: controller.submit,
                      icon: Icons.check_circle_outline_rounded,
                      gradient: controller.allAnswered
                          ? AppColors.gradientSuccess
                          : AppColors.gradientPrimary,
                    )
                  : PrimaryButton(
                      label: 'Next Question',
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
