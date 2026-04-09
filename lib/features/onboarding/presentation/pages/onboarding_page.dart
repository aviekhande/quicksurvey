import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

// @RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorPrimary,
      body: Column(children: [Expanded(child: Text("Onboarding"))]),
    );
  }
}
