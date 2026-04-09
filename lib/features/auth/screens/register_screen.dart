import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 40),
                AppTextField(
                  controller: controller.registerPhoneCtrl,
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
                      controller: controller.registerPassCtrl,
                      hintText: 'Enter password',
                      labelText: 'Password',
                      obscureText: controller.obscureRegisterPass.value,
                      validator: controller.validatePassword,
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.kColorWhite50, size: 20),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.obscureRegisterPass.toggle(),
                        child: Icon(
                          controller.obscureRegisterPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.kColorWhite50,
                          size: 20,
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                Obx(() => AppTextField(
                      controller: controller.registerConfirmPassCtrl,
                      hintText: 'Re-enter password',
                      labelText: 'Confirm Password',
                      obscureText: controller.obscureRegisterConfirm.value,
                      validator: controller.validateConfirmPassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.kColorWhite50, size: 20),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.obscureRegisterConfirm.toggle(),
                        child: Icon(
                          controller.obscureRegisterConfirm.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.kColorWhite50,
                          size: 20,
                        ),
                      ),
                    )),
                const SizedBox(height: 32),
                Obx(() => PrimaryButton(
                      label: 'Create Account',
                      isLoading: controller.isLoading.value,
                      onTap: controller.register,
                    )),
                const SizedBox(height: 24),
                _buildLoginLink(),
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
            border: Border.all(
                color: AppColors.kColorPrimary.withOpacity(0.3)),
          ),
          child: const Icon(Icons.assignment_ind_outlined,
              color: AppColors.kColorPrimary, size: 28),
        ),
        const SizedBox(height: 20),
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.kColorPrimaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Register to start filling questionnaires',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.kColorWhite50,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: GestureDetector(
        onTap: () => Get.offNamed(AppRoutes.login),
        child: RichText(
          text: const TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
                color: AppColors.kColorWhite50, fontSize: 14),
            children: [
              TextSpan(
                text: 'Login',
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
