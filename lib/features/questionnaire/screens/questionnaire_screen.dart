import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/questionnaire_controller.dart';
import '../widgets/questionnaire_header.dart';
import '../widgets/question_page.dart';
import '../widgets/nav_bar.dart';

class QuestionnaireScreen extends GetView<QuestionnaireController> {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: SafeArea(
        child: Column(
          children: [
            const QHeader(),
            const ProgressBar(),
            const DotIndicator(),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => controller.currentPage.value = i,
                itemCount: controller.totalQuestions,
                itemBuilder: (_, i) => QuestionPage(questionIndex: i),
              ),
            ),
            const NavBar(),
          ],
        ),
      ),
    );
  }
}
