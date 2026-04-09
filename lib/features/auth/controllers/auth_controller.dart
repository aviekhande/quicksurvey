import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/crashlytics_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/user_model.dart';

/// Manages registration, login, logout, and form validation.
/// Marked permanent so it persists across all routes.
class AuthController extends GetxController {
  // ── Register form controllers ─────────────────────────────────────────────
  late TextEditingController registerPhoneCtrl;
  late TextEditingController registerPassCtrl;
  late TextEditingController registerConfirmPassCtrl;
  final registerFormKey = GlobalKey<FormState>();

  // ── Login form controllers ────────────────────────────────────────────────
  late TextEditingController loginPhoneCtrl;
  late TextEditingController loginPassCtrl;
  final loginFormKey = GlobalKey<FormState>();

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading = false.obs;
  final obscureRegisterPass = true.obs;
  final obscureRegisterConfirm = true.obs;
  final obscureLoginPass = true.obs;

  /// The currently authenticated user; null when logged out.
  UserModel? currentUser;

  @override
  void onInit() {
    super.onInit();
    _initTextControllers();
    _restoreSession(); // Reload user from Hive on app start
    CrashlyticsService.log('AuthController initialised');
  }

  void _initTextControllers() {
    registerPhoneCtrl = TextEditingController();
    registerPassCtrl = TextEditingController();
    registerConfirmPassCtrl = TextEditingController();
    loginPhoneCtrl = TextEditingController();
    loginPassCtrl = TextEditingController();
  }

  /// Restores session from local storage on app boot.
  void _restoreSession() {
    currentUser = LocalStorageService.getCurrentUser();
    if (currentUser != null) {
      CrashlyticsService.setUser(currentUser!.phone);
    }
  }

  // ── Register ──────────────────────────────────────────────────────────────

  /// Validates register form, checks for duplicate phone, persists new user.
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    isLoading.value = true;
    CrashlyticsService.log('register() called');

    try {
      // Simulate network delay for realistic UX
      await Future.delayed(const Duration(milliseconds: 600));

      final phone = registerPhoneCtrl.text.trim();

      // Guard: phone must be unique across all registered users
      if (LocalStorageService.phoneExists(phone)) {
        _showError('Phone number already registered.');
        return;
      }

      final user = UserModel(
        phone: phone,
        password: registerPassCtrl.text,
      );
      await LocalStorageService.registerUser(user);

      _showSuccess('Account created! Please login.');
      _clearRegisterFields();
      Get.offNamed(AppRoutes.login);
    } catch (e, s) {
      CrashlyticsService.recordError(e, s, reason: 'register failed');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Login ─────────────────────────────────────────────────────────────────

  /// Validates login credentials against locally stored users.
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    CrashlyticsService.log('login() called');

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final phone = loginPhoneCtrl.text.trim();
      final password = loginPassCtrl.text;

      final user = LocalStorageService.getUserByPhone(phone);

      // Guard: user must exist and password must match
      if (user == null || user.password != password) {
        _showError('Invalid phone number or password.');
        return;
      }

      await LocalStorageService.saveCurrentUser(user);
      currentUser = user;

      // Tag the user in Crashlytics for better crash attribution
      await CrashlyticsService.setUser(user.phone);

      _clearLoginFields();
      Get.offAllNamed(AppRoutes.home);
    } catch (e, s) {
      CrashlyticsService.recordError(e, s, reason: 'login failed');
      _showError('Login failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  /// Clears session data and returns the user to the login screen.
  Future<void> logout() async {
    CrashlyticsService.log('logout() called for ${currentUser?.phone}');
    await LocalStorageService.clearCurrentUser();
    await CrashlyticsService.clearUser();
    currentUser = null;
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Validators ────────────────────────────────────────────────────────────

  /// Validates international phone number format.
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Enforces minimum password length of 6 characters.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters required';
    return null;
  }

  /// Ensures confirm-password matches the password field.
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != registerPassCtrl.text) return 'Passwords do not match';
    return null;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _clearRegisterFields() {
    registerPhoneCtrl.clear();
    registerPassCtrl.clear();
    registerConfirmPassCtrl.clear();
  }

  void _clearLoginFields() {
    loginPhoneCtrl.clear();
    loginPassCtrl.clear();
  }

  void _showError(String msg) {
    Get.snackbar(
      'Error', msg,
      backgroundColor: const Color(0xFFFF4E6A),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
    );
  }

  void _showSuccess(String msg) {
    Get.snackbar(
      'Success', msg,
      backgroundColor: const Color(0xFF00D4AA),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
    );
  }

  @override
  void onClose() {
    // Dispose all text controllers to prevent memory leaks
    try {
      registerPhoneCtrl.dispose();
      registerPassCtrl.dispose();
      registerConfirmPassCtrl.dispose();
      loginPhoneCtrl.dispose();
      loginPassCtrl.dispose();
    } catch (_) {}
    super.onClose();
  }
}
