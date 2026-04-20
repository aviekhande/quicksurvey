import 'package:questionnaire/core/constants/app_icons.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';

class AnimatedStatsCard extends GetView<ProfileController> {
  const AnimatedStatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kColorPrimary.withOpacity(0.15),
            AppColors.kColorPrimary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.kColorPrimary.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: AppColors.gradientPrimary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kColorPrimary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              AppIcons.assignmentTurnedInRounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Surveys Completed',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.kColorTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => CounterText(target: controller.submissionCount.value),
                ),
              ],
            ),
          ),
          if (controller.submissionCount.value >= 3)
            const Icon(
              AppIcons.emojiEventsRounded,
              color: AppColors.kColorWarning,
              size: 32,
            ),
        ],
      ),
    );
  }
}

class CounterText extends StatefulWidget {
  const CounterText({required this.target});
  final int target;

  @override
  State<CounterText> createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<int> _countAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _countAnim = IntTween(
      begin: 0,
      end: widget.target,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnim,
      builder: (_, __) => Text(
        '${_countAnim.value}',
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: AppColors.kColorPrimary,
          height: 1,
        ),
      ),
    );
  }
}
