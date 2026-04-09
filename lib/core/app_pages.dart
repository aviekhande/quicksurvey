import 'package:get/get.dart';

import '../features/auth/controllers/auth_controller.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/home/controllers/home_controller.dart';
import '../features/home/screens/home_screen.dart';
import '../features/profile/controllers/profile_controller.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/questionnaire/controllers/questionnaire_controller.dart';
import '../features/questionnaire/screens/questionnaire_screen.dart';
import 'constants/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),
    ),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.questionnaire,
      page: () => const QuestionnaireScreen(),
      binding: BindingsBuilder(() {
        Get.put(QuestionnaireController());
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),
  ];
}
