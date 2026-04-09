import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_pages.dart';
import 'core/services/crashlytics_service.dart';
import 'core/services/local_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

/// Entry point – initialises Firebase, Crashlytics, and Hive, then launches the app.
/// All async errors within the zone are automatically reported to Crashlytics.
void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Lock orientation to portrait for mobile-first UX
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Transparent status bar with light icons
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );

      // Initialise Firebase before any other Firebase service
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Hook Flutter & async errors into Crashlytics
      await CrashlyticsService.init();

      // Open Hive boxes for offline storage
      await LocalStorageService.init();

      // Run the app
      runApp(const SurveyApp());
    },
    (error, stack) {
      CrashlyticsService.recordError(error, stack, fatal: true);
    },
  );
}

/// Root application widget.
class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.kAppTitle,
      debugShowCheckedModeBanner: false,

      // Global dark theme
      theme: AppTheme.darkTheme,

      // Named routes with GetX bindings
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

      // Default page transition
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 280),

      // Prevent system back from exiting mid-survey without warning
      builder: (context, child) => child!,
    );
  }
}
