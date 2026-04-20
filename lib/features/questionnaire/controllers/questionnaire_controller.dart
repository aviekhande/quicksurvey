import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/crashlytics_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/services/location_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../models/questionnaire_model.dart';
import '../models/submission_model.dart';

/// Controls questionnaire navigation, answer selection, and submission.
class QuestionnaireController extends GetxController {
  late QuestionnaireModel questionnaire;

  /// Maps questionIndex → selectedOptionIndex. Observable for reactive UI.
  final selectedAnswers = <int, int>{}.obs;

  final isSubmitting = false.obs;

  /// Tracks which page the PageView is currently showing.
  final currentPage = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    // Get the questionnaire model passed from HomeController
    questionnaire = Get.arguments as QuestionnaireModel;
    pageController = PageController();
    CrashlyticsService.log('QuestionnaireScreen: ${questionnaire.id}');
  }

  // ── Computed getters ──────────────────────────────────────────────────────

  /// Returns true when every question has a selected answer.
  bool get allAnswered => selectedAnswers.length == questionnaire.questions.length;

  int get totalQuestions => questionnaire.questions.length;

  /// Returns progress as a 0.0–1.0 fraction based on answered count.
  double get answerProgress => selectedAnswers.length / totalQuestions;

  /// Returns progress as a 0.0–1.0 fraction based on current page position.
  double get pageProgress => (currentPage.value + 1) / totalQuestions;

  // ── Answer selection ──────────────────────────────────────────────────────

  /// Records the user's selected option for a given question.
  void selectAnswer(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    HapticFeedback.lightImpact(); // Tactile feedback on selection
  }

  /// Returns true if [optionIndex] is currently selected for [questionIndex].
  bool isSelected(int questionIndex, int optionIndex) =>
      selectedAnswers[questionIndex] == optionIndex;

  // ── Page navigation ───────────────────────────────────────────────────────

  /// Advances to the next question page with smooth animation.
  void nextPage() {
    if (currentPage.value < totalQuestions - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  /// Returns to the previous question page.
  void prevPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  /// Jumps directly to a specific question (used by dot indicators).
  void jumpToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  // ── Submission ────────────────────────────────────────────────────────────

  /// Validates all answers, captures GPS, saves to Hive, shows success.
  Future<void> submit() async {
    if (!allAnswered) {
      _showError('Please answer all ${totalQuestions} questions to submit.');
      HapticFeedback.heavyImpact();
      return;
    }

    isSubmitting.value = true;
    CrashlyticsService.log('Submitting: ${questionnaire.id}');

    try {
      // Attempt to get GPS coordinates (non-blocking if denied)
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

      // Persist submission to Hive – survives app restarts and logout
      await LocalStorageService.saveSubmission(phone, submission);

      CrashlyticsService.setKey(
        'last_submission',
        '${questionnaire.id} at ${submission.submittedAt.toIso8601String()}',
      );

      HapticFeedback.mediumImpact();
      _showSuccess('Survey submitted successfully! 🎉');

      await Future.delayed(const Duration(milliseconds: 500));
      Get.offNamed(AppRoutes.home);
    } catch (e, s) {
      CrashlyticsService.recordError(e, s, reason: 'submission failed');
      _showError('Submission failed. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ── Snackbar helpers ──────────────────────────────────────────────────────

  void _showError(String msg) {
    Get.snackbar(
      'Incomplete', msg,
      backgroundColor: const Color(0xFFFF4E6A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      icon: const Icon(AppIcons.warningAmberRounded, color: Colors.white),
    );
  }

  void _showSuccess(String msg) {
    Get.snackbar(
      'Submitted!', msg,
      backgroundColor: const Color(0xFF00D4AA),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      icon: const Icon(AppIcons.checkCircleOutlineRounded, color: Colors.white),
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
