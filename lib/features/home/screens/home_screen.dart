import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../questionnaire/models/questionnaire_model.dart';
import '../controllers/home_controller.dart';

/// Home screen that lists questionnaires with staggered card animations.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: SafeArea(
        child: Column(
          children: [
            _HomeHeader(onProfileTap: controller.goToProfile),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _ShimmerList();
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
                      return _AnimatedCard(
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

// ── Header ────────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.onProfileTap});
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final phone = auth.currentUser?.phone ?? '';
    // Count submissions for the header stats pill
    final count = LocalStorageService.getSubmissionCountForUser(phone);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.kColorBg,
        border: Border(
          bottom: BorderSide(
            color: AppColors.kColorBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Greeting + phone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.gradientPrimary.createShader(b),
                  child: const Text(
                    'Surveys',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.kColorTextMuted,
                  ),
                ),
              ],
            ),
          ),

          // Submission count pill
          if (count > 0)
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.kColorSecondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.kColorSecondary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 14,
                    color: AppColors.kColorSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$count done',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kColorSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // Profile avatar button
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kColorPrimary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  phone.isNotEmpty ? phone[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Animated Card ─────────────────────────────────────────────────────────────

class _AnimatedCard extends StatefulWidget {
  const _AnimatedCard({
    required this.index,
    required this.questionnaire,
    required this.onTap,
  });
  final int index;
  final QuestionnaireModel questionnaire;
  final VoidCallback onTap;

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  static const _icons = [
    Icons.star_rounded,
    Icons.people_alt_rounded,
    Icons.tune_rounded,
    Icons.favorite_rounded,
    Icons.devices_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    // Stagger card entrance based on index
    Future.delayed(Duration(milliseconds: widget.index * 80), () {
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
    final color =
        AppColors.cardAccents[widget.index % AppColors.cardAccents.length];
    final icon = _icons[widget.index % _icons.length];

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: _QuestionnaireCardContent(
          questionnaire: widget.questionnaire,
          color: color,
          icon: icon,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

class _QuestionnaireCardContent extends StatefulWidget {
  const _QuestionnaireCardContent({
    required this.questionnaire,
    required this.color,
    required this.icon,
    required this.onTap,
  });
  final QuestionnaireModel questionnaire;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_QuestionnaireCardContent> createState() =>
      _QuestionnaireCardContentState();
}

class _QuestionnaireCardContentState extends State<_QuestionnaireCardContent> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _pressed
                ? AppColors.kColorCardElevated
                : AppColors.kColorCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _pressed
                  ? widget.color.withOpacity(0.5)
                  : AppColors.kColorBorder,
              width: _pressed ? 1.5 : 1,
            ),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              // Category icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: widget.color.withOpacity(0.25)),
                ),
                child: Icon(widget.icon, color: widget.color, size: 26),
              ),
              const SizedBox(width: 14),

              // Title, description, chips
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.questionnaire.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kColorText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.questionnaire.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.kColorTextSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _Chip(
                          label: '${widget.questionnaire.questions.length} Qs',
                          icon: Icons.help_outline_rounded,
                          color: widget.color,
                        ),
                        const SizedBox(width: 8),
                        _Chip(
                          label: widget.questionnaire.category,
                          icon: Icons.label_outline_rounded,
                          color: AppColors.kColorTextMuted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: widget.color,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small label chip shown beneath each card's description.
class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.icon, required this.color});
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shimmer loading skeleton ───────────────────────────────────────────────────

class _ShimmerList extends StatefulWidget {
  @override
  State<_ShimmerList> createState() => _ShimmerListState();
}

class _ShimmerListState extends State<_ShimmerList>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      itemCount: 8,
      itemBuilder: (_, i) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => _ShimmerCard(shimmerOffset: _anim.value),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({required this.shimmerOffset});
  final double shimmerOffset;

  @override
  Widget build(BuildContext context) {
    const baseColor = AppColors.kColorCard;
    const highlightColor = AppColors.kColorCardElevated;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.kColorBorder),
      ),
      child: Row(
        children: [
          _shimmerBox(52, 52, radius: 14, base: baseColor, hi: highlightColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(120, 14, base: baseColor, hi: highlightColor),
                const SizedBox(height: 8),
                _shimmerBox(
                  double.infinity,
                  12,
                  base: baseColor,
                  hi: highlightColor,
                ),
                const SizedBox(height: 4),
                _shimmerBox(180, 12, base: baseColor, hi: highlightColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(
    double w,
    double h, {
    double radius = 8,
    required Color base,
    required Color hi,
  }) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(shimmerOffset - 1, 0),
          end: Alignment(shimmerOffset + 1, 0),
          colors: [base, hi, base],
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
