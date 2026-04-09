import 'package:get/get.dart';

import '../../../core/services/crashlytics_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../questionnaire/models/submission_model.dart';

/// Manages Profile screen data – loads submissions and handles logout.
class ProfileController extends GetxController {
  final submissions = <SubmissionModel>[].obs;
  final submissionCount = 0.obs;

  /// The phone number of the currently logged-in user.
  String userPhone = '';

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
    CrashlyticsService.log('ProfileScreen opened');
  }

  /// Fetches submission history from Hive for the current user.
  void _loadProfileData() {
    final authCtrl = Get.find<AuthController>();
    userPhone = authCtrl.currentUser?.phone ?? '';

    final list = LocalStorageService.getSubmissionsForUser(userPhone);

    // Show newest submissions at the top
    submissions.value = list.reversed.toList();
    submissionCount.value = list.length;
  }

  /// Delegates logout to AuthController which clears local session.
  void logout() => Get.find<AuthController>().logout();
}
