import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _buildHeader(),
                const SizedBox(height: 48),
                AppTextField(
                  controller: controller.loginPhoneCtrl,
                  hintText: '+91 9876543210',
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: controller.validatePhone,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
                  prefixIcon: const Icon(Icons.phone_outlined,
                      color: AppColors.kColorWhite50, size: 20),
                ),
                const SizedBox(height: 20),
                Obx(() => AppTextField(
                      controller: controller.loginPassCtrl,
                      hintText: 'Enter password',
                      labelText: 'Password',
                      obscureText: controller.obscureLoginPass.value,
                      validator: controller.validatePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.kColorWhite50, size: 20),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.obscureLoginPass.toggle(),
                        child: Icon(
                          controller.obscureLoginPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.kColorWhite50,
                          size: 20,
                        ),
                      ),
                    )),
                const SizedBox(height: 36),
                Obx(() => PrimaryButton(
                      label: 'Login',
                      isLoading: controller.isLoading.value,
                      onTap: controller.login,
                    )),
                const SizedBox(height: 24),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.kColorPrimary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.kColorPrimary.withOpacity(0.3)),
          ),
          child: const Icon(Icons.bolt_rounded,
              color: AppColors.kColorPrimary, size: 28),
        ),
        const SizedBox(height: 20),
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.kColorPrimaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sign in to your account to continue',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.kColorWhite50,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Center(
      child: GestureDetector(
        onTap: () => Get.offNamed(AppRoutes.register),
        child: RichText(
          text: const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: AppColors.kColorWhite50, fontSize: 14),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: AppColors.kColorPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
