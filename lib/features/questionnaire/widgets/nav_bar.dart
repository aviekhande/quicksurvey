import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/questionnaire_controller.dart';

class NavBar extends GetView<QuestionnaireController> {
  const NavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.kColorBg,
        border: Border(
          top: BorderSide(
            color: AppColors.kColorBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Obx(() {
        final isLast =
            controller.currentPage.value == controller.totalQuestions - 1;
        final canGoBack = controller.currentPage.value > 0;

        return Row(
          children: [
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
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.kColorTextSecondary,
                      side: const BorderSide(color: AppColors.kColorBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
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
