import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/home_header.dart';
import '../widgets/shimmer_list.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(onProfileTap: controller.goToProfile),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const ShimmerList();
                }
                return RefreshIndicator(
                  color: AppColors.kColorPrimary,
                  backgroundColor: AppColors.kColorCard,
                  onRefresh: controller.refresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                    itemCount: controller.questionnaires.length,
                    itemBuilder: (_, i) {
                      final q = controller.questionnaires[i];
                      return AnimatedCard(
                        index: i,
                        questionnaire: q,
                        onTap: () => controller.openQuestionnaire(q),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
