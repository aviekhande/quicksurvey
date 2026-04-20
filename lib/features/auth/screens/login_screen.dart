import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login_header.dart';

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

    _slideAnims = List.generate(4, (i) {
      final start = i * 0.15;
      final end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.4),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _enterCtrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
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
                    _animated(0, const LoginHeader()),
                    const SizedBox(height: 48),
                    _animated(
                      1,
                      AppTextField(
                        controller: ctrl.loginPhoneCtrl,
                        hintText: '+91 9876543210',
                        labelText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: ctrl.validatePhone,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, 
                          LengthLimitingTextInputFormatter(10), 
                        ],
                        prefixIcon: const Icon(
                          AppIcons.phoneOutlined,
                          color: AppColors.kColorTextMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _animated(
                      2,
                      Obx(
                        () => AppTextField(
                          controller: ctrl.loginPassCtrl,
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          obscureText: ctrl.obscureLoginPass.value,
                          validator: ctrl.validatePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => ctrl.login(),
                          prefixIcon: const Icon(
                            AppIcons.lockOutlineRounded,
                            color: AppColors.kColorTextMuted,
                            size: 20,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () => ctrl.obscureLoginPass.toggle(),
                            child: Icon(
                              ctrl.obscureLoginPass.value
                                  ? AppIcons.visibilityOffOutlined
                                  : AppIcons.visibilityOutlined,
                              color: AppColors.kColorTextMuted,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    _animated(
                      3,
                      Obx(
                        () => PrimaryButton(
                          label: 'Login',
                          isLoading: ctrl.isLoading.value,
                          onTap: ctrl.login,
                          icon: AppIcons.loginRounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
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
