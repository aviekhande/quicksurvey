import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

/// Login screen with staggered field animations and gradient background accent.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _enterCtrl;
  late List<Animation<Offset>> _slideAnims;
  late List<Animation<double>> _fadeAnims;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Stagger 4 elements: header, phone, password, button
    _slideAnims = List.generate(4, (i) {
      final start = i * 0.15;
      final end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.4),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _enterCtrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ));
    });

    _fadeAnims = List.generate(4, (i) {
      final start = i * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
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

  Widget _animated(int index, Widget child) {
    return SlideTransition(
      position: _slideAnims[index],
      child: FadeTransition(opacity: _fadeAnims[index], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: Stack(
        children: [
          // Background accent glow
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.kColorPrimary.withOpacity(0.15),
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
                key: ctrl.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    // Header
                    _animated(0, _Header()),
                    const SizedBox(height: 48),

                    // Phone field
                    _animated(
                      1,
                      AppTextField(
                        controller: ctrl.loginPhoneCtrl,
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

                    // Password field with visibility toggle
                    _animated(
                      2,
                      Obx(() => AppTextField(
                            controller: ctrl.loginPassCtrl,
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            obscureText: ctrl.obscureLoginPass.value,
                            validator: ctrl.validatePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => ctrl.login(),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.kColorTextMuted,
                              size: 20,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => ctrl.obscureLoginPass.toggle(),
                              child: Icon(
                                ctrl.obscureLoginPass.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.kColorTextMuted,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 36),

                    // Login button
                    _animated(
                      3,
                      Obx(() => PrimaryButton(
                            label: 'Login',
                            isLoading: ctrl.isLoading.value,
                            onTap: ctrl.login,
                            icon: Icons.login_rounded,
                          )),
                    ),
                    const SizedBox(height: 28),

                    // Register link
                    _animated(
                      3,
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.offNamed(AppRoutes.register),
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.kColorTextMuted,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
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

/// The login page header with icon badge, title and subtitle.
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.kColorPrimary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 24),
        const Text(
          'Welcome Back! 👋',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.kColorText,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sign in to continue your survey journey',
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
