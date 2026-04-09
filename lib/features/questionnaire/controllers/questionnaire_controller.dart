import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/services/location_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../models/questionnaire_model.dart';
import '../models/submission_model.dart';

class QuestionnaireController extends GetxController {
  late QuestionnaireModel questionnaire;

  // questionIndex -> selectedOptionIndex
  final selectedAnswers = <int, int>{}.obs;
  final isSubmitting = false.obs;
  final currentPage = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments as QuestionnaireModel;
    pageController = PageController();
  }

  bool get allAnswered =>
      selectedAnswers.length == questionnaire.questions.length;

  int get totalQuestions => questionnaire.questions.length;

  void selectAnswer(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
  }

  bool isSelected(int questionIndex, int optionIndex) {
    return selectedAnswers[questionIndex] == optionIndex;
  }

  void nextPage() {
    if (currentPage.value < totalQuestions - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> submit() async {
    if (!allAnswered) {
      _showError('Please answer all questions before submitting.');
      return;
    }

    isSubmitting.value = true;

    // Get location
    final position = await LocationService.getCurrentPosition();

    final authCtrl = Get.find<AuthController>();
    final phone = authCtrl.currentUser?.phone ?? 'unknown';

    final submission = SubmissionModel(
      questionnaireId: questionnaire.id,
      questionnaireName: questionnaire.title,
      answers: Map.from(selectedAnswers),
      submittedAt: DateTime.now(),
      latitude: position?.latitude,
      longitude: position?.longitude,
    );

    await LocalStorageService.saveSubmission(phone, submission);

    isSubmitting.value = false;

    _showSuccess('Response submitted successfully!');
    await Future.delayed(const Duration(milliseconds: 300));
    Get.offNamed(AppRoutes.home);
  }

  void _showError(String msg) {
    Get.snackbar('Incomplete', msg,
        backgroundColor: const Color(0xFFE74C3C),
        colorText: const Color(0xFFEAEAEA),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3));
  }

  void _showSuccess(String msg) {
    Get.snackbar('Submitted!', msg,
        backgroundColor: const Color(0xFF59C38E),
        colorText: const Color(0xFFEAEAEA),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
