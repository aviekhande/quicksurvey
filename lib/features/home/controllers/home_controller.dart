import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/crashlytics_service.dart';
import '../../questionnaire/models/mock_questionnaire_service.dart';
import '../../questionnaire/models/questionnaire_model.dart';

/// Controls the Home screen – fetches questionnaire list and handles navigation.
class HomeController extends GetxController {
  final questionnaires = <QuestionnaireModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuestionnaires();
    CrashlyticsService.log('HomeScreen opened');
  }

  /// Loads questionnaires from the mock service, simulating a network fetch.
  Future<void> _loadQuestionnaires() async {
    isLoading.value = true;
    try {
      // Simulated API latency
      await Future.delayed(const Duration(milliseconds: 700));
      questionnaires.value = MockQuestionnaireService.getQuestionnaires();
    } catch (e, s) {
      CrashlyticsService.recordError(e, s, reason: 'loadQuestionnaires failed');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refreshes the questionnaire list (used by pull-to-refresh).
  Future<void> refresh() => _loadQuestionnaires();

  /// Navigates to the Questionnaire screen, passing the model as argument.
  void openQuestionnaire(QuestionnaireModel q) {
    CrashlyticsService.log('Opening questionnaire: ${q.id}');
    Get.toNamed(AppRoutes.questionnaire, arguments: q);
  }

  /// Navigates to the Profile screen.
  void goToProfile() => Get.toNamed(AppRoutes.profile);
}
