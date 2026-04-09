import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  // ── Register form ────────────────────────────────────────────────────────
  late TextEditingController registerPhoneCtrl;
  late TextEditingController registerPassCtrl;
  late TextEditingController registerConfirmPassCtrl;
  final registerFormKey = GlobalKey<FormState>();

  // ── Login form ───────────────────────────────────────────────────────────
  late TextEditingController loginPhoneCtrl;
  late TextEditingController loginPassCtrl;
  final loginFormKey = GlobalKey<FormState>();

  // ── Observables ──────────────────────────────────────────────────────────
  final isLoading = false.obs;
  final obscureRegisterPass = true.obs;
  final obscureRegisterConfirm = true.obs;
  final obscureLoginPass = true.obs;

  UserModel? currentUser;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _loadCurrentUser();
  }

  void _initializeControllers() {
    registerPhoneCtrl = TextEditingController();
    registerPassCtrl = TextEditingController();
    registerConfirmPassCtrl = TextEditingController();
    loginPhoneCtrl = TextEditingController();
    loginPassCtrl = TextEditingController();
  }

  void _loadCurrentUser() {
    currentUser = LocalStorageService.getCurrentUser();
  }

  // ── Register ─────────────────────────────────────────────────────────────

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 500)); // simulate network

    final phone = registerPhoneCtrl.text.trim();
    if (LocalStorageService.phoneExists(phone)) {
      _showError('Phone number already registered.');
      isLoading.value = false;
      return;
    }

    final user = UserModel(phone: phone, password: registerPassCtrl.text);
    await LocalStorageService.registerUser(user);

    isLoading.value = false;
    _showSuccess('Account created! Please login.');
    Get.offNamed(AppRoutes.login);
    _clearRegisterFields();
  }

  // ── Login ────────────────────────────────────────────────────────────────

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 500));

    final phone = loginPhoneCtrl.text.trim();
    final password = loginPassCtrl.text;

    final user = LocalStorageService.getUserByPhone(phone);
    if (user == null || user.password != password) {
      _showError('Invalid phone number or password.');
      isLoading.value = false;
      return;
    }

    await LocalStorageService.saveCurrentUser(user);
    currentUser = user;

    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
    _clearLoginFields();
  }

  // ── Logout ───────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await LocalStorageService.clearCurrentUser();
    currentUser = null;
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Validators ───────────────────────────────────────────────────────────

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != registerPassCtrl.text) return 'Passwords do not match';
    return null;
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

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
      'Error',
      msg,
      backgroundColor: const Color(0xFFE74C3C),
      colorText: const Color(0xFFEAEAEA),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showSuccess(String msg) {
    Get.snackbar(
      'Success',
      msg,
      backgroundColor: const Color(0xFF59C38E),
      colorText: const Color(0xFFEAEAEA),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    try {
      registerPhoneCtrl.dispose();
      registerPassCtrl.dispose();
      registerConfirmPassCtrl.dispose();
      loginPhoneCtrl.dispose();
      loginPassCtrl.dispose();
    } catch (e) {
      // Handle case where controller was already disposed
    }
    super.onClose();
  }
}
