import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

/// Registration screen with staggered entrance animations.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _enterCtrl;
  late List<Animation<Offset>> _slides;
  late List<Animation<double>> _fades;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Stagger 5 elements: header, phone, pass, confirm, button
    _slides = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.45).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _enterCtrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ));
    });

    _fades = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.35).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _enterCtrl,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    super.dispose();
  }

  Widget _animated(int i, Widget child) => SlideTransition(
        position: _slides[i],
        child: FadeTransition(opacity: _fades[i], child: child),
      );

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: Stack(
        children: [
          // Decorative gradient accent (bottom-left)
          Positioned(
            bottom: -120,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.kColorSecondary.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: ctrl.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    _animated(0, _RegisterHeader()),
                    const SizedBox(height: 40),

                    _animated(
                      1,
                      AppTextField(
                        controller: ctrl.registerPhoneCtrl,
                        hintText: '+91 9876543210',
                        labelText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: ctrl.validatePhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                        ],
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                          color: AppColors.kColorTextMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _animated(
                      2,
                      Obx(() => AppTextField(
                            controller: ctrl.registerPassCtrl,
                            hintText: 'Minimum 6 characters',
                            labelText: 'Password',
                            obscureText: ctrl.obscureRegisterPass.value,
                            validator: ctrl.validatePassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.kColorTextMuted,
                              size: 20,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => ctrl.obscureRegisterPass.toggle(),
                              child: Icon(
                                ctrl.obscureRegisterPass.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.kColorTextMuted,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),

                    _animated(
                      3,
                      Obx(() => AppTextField(
                            controller: ctrl.registerConfirmPassCtrl,
                            hintText: 'Re-enter your password',
                            labelText: 'Confirm Password',
                            obscureText: ctrl.obscureRegisterConfirm.value,
                            validator: ctrl.validateConfirmPassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => ctrl.register(),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.kColorTextMuted,
                              size: 20,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  ctrl.obscureRegisterConfirm.toggle(),
                              child: Icon(
                                ctrl.obscureRegisterConfirm.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.kColorTextMuted,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 32),

                    _animated(
                      4,
                      Obx(() => PrimaryButton(
                            label: 'Create Account',
                            isLoading: ctrl.isLoading.value,
                            onTap: ctrl.register,
                            icon: Icons.person_add_outlined,
                          )),
                    ),
                    const SizedBox(height: 28),

                    _animated(
                      4,
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.offNamed(AppRoutes.login),
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: AppColors.kColorTextMuted,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color: AppColors.kColorPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Header block for the register screen.
class _RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.gradientSuccess,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.kColorSecondary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Create Account ✨',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.kColorText,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Register to start filling surveys and tracking insights',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.kColorTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
