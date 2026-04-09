import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../questionnaire/models/submission_model.dart';

class ProfileController extends GetxController {
  final submissions = <SubmissionModel>[].obs;
  final submissionCount = 0.obs;
  String userPhone = '';

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    final authCtrl = Get.find<AuthController>();
    userPhone = authCtrl.currentUser?.phone ?? '';
    final list = LocalStorageService.getSubmissionsForUser(userPhone);
    submissions.value = list.reversed.toList(); // newest first
    submissionCount.value = list.length;
  }

  void logout() {
    Get.find<AuthController>().logout();
  }
}
