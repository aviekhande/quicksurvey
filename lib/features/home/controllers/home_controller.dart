import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../questionnaire/models/mock_questionnaire_service.dart';
import '../../questionnaire/models/questionnaire_model.dart';

class HomeController extends GetxController {
  final questionnaires = <QuestionnaireModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuestionnaires();
  }

  Future<void> _loadQuestionnaires() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600)); // simulate fetch
    questionnaires.value = MockQuestionnaireService.getQuestionnaires();
    isLoading.value = false;
  }

  void openQuestionnaire(QuestionnaireModel q) {
    Get.toNamed(AppRoutes.questionnaire, arguments: q);
  }

  void goToProfile() {
    Get.toNamed(AppRoutes.profile);
  }
}
