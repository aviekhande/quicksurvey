import 'package:flutter/material.dart';
import 'package:questionnaire/features/home/widgets/chip.dart';

import '../../../core/theme/app_colors.dart';
import '../../questionnaire/models/questionnaire_model.dart';

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({
    required this.index,
    required this.questionnaire,
    required this.onTap,
  });
  final int index;
  final QuestionnaireModel questionnaire;
  final VoidCallback onTap;

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
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
        child: QuestionnaireCardContent(
          questionnaire: widget.questionnaire,
          color: color,
          icon: icon,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

class QuestionnaireCardContent extends StatefulWidget {
  const QuestionnaireCardContent({
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
  State<QuestionnaireCardContent> createState() =>
      _QuestionnaireCardContentState();
}

class _QuestionnaireCardContentState extends State<QuestionnaireCardContent> {
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
                        CustomChip(
                          label: '${widget.questionnaire.questions.length} Qs',
                          icon: Icons.help_outline_rounded,
                          color: widget.color,
                        ),
                        const SizedBox(width: 8),
                        CustomChip(
                          label: widget.questionnaire.category,
                          icon: Icons.label_outline_rounded,
                          color: AppColors.kColorTextMuted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
