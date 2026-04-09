import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Wraps Firebase Crashlytics for structured error logging across the app.
/// Usage: CrashlyticsService.log('event'); CrashlyticsService.recordError(e, s);
class CrashlyticsService {
  static final _crashlytics = FirebaseCrashlytics.instance;

  /// Initialises Crashlytics and routes all Flutter errors to it.
  static Future<void> init() async {
    // Forward uncaught Flutter framework errors
    FlutterError.onError = (details) {
      _crashlytics.recordFlutterFatalError(details);
    };

    // Forward errors from the Dart async zone (PlatformDispatcher)
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    // Enable/disable based on build mode
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  /// Logs a breadcrumb string for tracing user flows in crash reports.
  static void log(String message) {
    _crashlytics.log(message);
  }

  /// Records a non-fatal error with optional stack trace and context.
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Tags the current user for better crash attribution in the dashboard.
  static Future<void> setUser(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }

  /// Clears the user identifier on logout.
  static Future<void> clearUser() async {
    await _crashlytics.setUserIdentifier('');
  }

  /// Sends a custom key-value pair for extra context in crash reports.
  static Future<void> setKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value.toString());
  }
}
