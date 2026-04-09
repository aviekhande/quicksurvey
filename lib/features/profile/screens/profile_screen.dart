import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../questionnaire/models/submission_model.dart';
import '../controllers/profile_controller.dart';

/// Profile screen showing user info, animated submission count, and history.
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: SafeArea(
        child: Column(
          children: [
            _ProfileAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProfileCard(),
                    const SizedBox(height: 16),
                    _AnimatedStatsCard(),
                    const SizedBox(height: 24),
                    _HistorySection(),
                    const SizedBox(height: 24),
                    _LogoutButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── App bar ────────────────────────────────────────────────────────────────────

class _ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.kColorBg,
        border: Border(
          bottom: BorderSide(
              color: AppColors.kColorBorder.withOpacity(0.5), width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.kColorCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kColorBorder),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.kColorText,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.kColorText,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile card ───────────────────────────────────────────────────────────────

class _ProfileCard extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kColorCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.kColorBorder),
      ),
      child: Row(
        children: [
          // Gradient avatar with initial
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppColors.gradientPrimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kColorPrimary.withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                controller.userPhone.isNotEmpty
                    ? controller.userPhone[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Phone number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Logged in as',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kColorTextMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userPhone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kColorText,
                  ),
                ),
              ],
            ),
          ),

          // Active badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.kColorSecondary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.kColorSecondary.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.kColorSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kColorSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Animated stats card ────────────────────────────────────────────────────────

class _AnimatedStatsCard extends GetView<ProfileController> {
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
            color: AppColors.kColorPrimary.withOpacity(0.25), width: 1.5),
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
              Icons.assignment_turned_in_rounded,
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
                Obx(() => _CounterText(target: controller.submissionCount.value)),
              ],
            ),
          ),

          // Trophy icon for motivation
          if (controller.submissionCount.value >= 3)
            const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.kColorWarning,
              size: 32,
            ),
        ],
      ),
    );
  }
}

/// Animates from 0 → target when first rendered.
class _CounterText extends StatefulWidget {
  const _CounterText({required this.target});
  final int target;

  @override
  State<_CounterText> createState() => _CounterTextState();
}

class _CounterTextState extends State<_CounterText>
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
    _countAnim = IntTween(begin: 0, end: widget.target).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
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

// ── Submission history ─────────────────────────────────────────────────────────

class _HistorySection extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Submission History',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.kColorText,
              ),
            ),
            const Spacer(),
            Obx(() => Text(
                  '${controller.submissions.length} total',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.kColorTextMuted,
                  ),
                )),
          ],
        ),
        const SizedBox(height: 14),
        Obx(() {
          if (controller.submissions.isEmpty) {
            return _EmptyHistory();
          }
          return Column(
            children: controller.submissions
                .asMap()
                .entries
                .map((e) => _SubmissionTile(
                      submission: e.value,
                      index: e.key,
                    ))
                .toList(),
          );
        }),
      ],
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kColorCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.kColorBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.kColorBorder.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inbox_rounded,
              color: AppColors.kColorTextMuted,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No submissions yet',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.kColorTextSecondary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Complete a survey to see it here',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.kColorTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmissionTile extends StatefulWidget {
  const _SubmissionTile({required this.submission, required this.index});
  final SubmissionModel submission;
  final int index;

  @override
  State<_SubmissionTile> createState() => _SubmissionTileState();
}

class _SubmissionTileState extends State<_SubmissionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    // Stagger per index
    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.submission;
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kColorCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kColorBorder),
          ),
          child: Row(
            children: [
              // Checkmark icon
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.kColorSecondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.kColorSecondary.withOpacity(0.2)),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.kColorSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),

              // Name + date + location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.questionnaireName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kColorText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 12,
                            color: AppColors.kColorTextMuted),
                        const SizedBox(width: 4),
                        Text(
                          s.formattedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.kColorTextMuted,
                          ),
                        ),
                      ],
                    ),
                    if (s.hasLocation) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 12,
                              color: AppColors.kColorPrimary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              s.locationString ?? '',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.kColorPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Answers count badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.kColorPrimary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${s.answers.length}Q',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kColorPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Logout button ──────────────────────────────────────────────────────────────

class _LogoutButton extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _confirmLogout,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.kColorError.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppColors.kColorError.withOpacity(0.3), width: 1.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded,
                color: AppColors.kColorError, size: 20),
            SizedBox(width: 10),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.kColorError,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a confirmation dialog before logging out.
  void _confirmLogout() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.kColorCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: AppColors.kColorBorder, width: 1),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            color: AppColors.kColorText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Are you sure you want to sign out? Your offline data will remain intact.',
          style: TextStyle(
            color: AppColors.kColorTextSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.kColorTextMuted),
            ),
          ),
          TextButton(
            onPressed: controller.logout,
            child: const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.kColorError,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
