import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../questionnaire/models/submission_model.dart';
import '../controllers/profile_controller.dart';

class HistorySection extends GetView<ProfileController> {
  const HistorySection();

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
            Obx(
              () => Text(
                '${controller.submissions.length} total',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.kColorTextMuted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Obx(() {
          if (controller.submissions.isEmpty) {
            return const EmptyHistory();
          }
          return Column(
            children: controller.submissions
                .asMap()
                .entries
                .map((e) => SubmissionTile(submission: e.value, index: e.key))
                .toList(),
          );
        }),
      ],
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory();

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
            style: TextStyle(fontSize: 13, color: AppColors.kColorTextMuted),
          ),
        ],
      ),
    );
  }
}

class SubmissionTile extends StatefulWidget {
  const SubmissionTile({required this.submission, required this.index});
  final SubmissionModel submission;
  final int index;

  @override
  State<SubmissionTile> createState() => _SubmissionTileState();
}

class _SubmissionTileState extends State<SubmissionTile>
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
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.kColorSecondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.kColorSecondary.withOpacity(0.2),
                  ),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.kColorSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
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
                        const Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: AppColors.kColorTextMuted,
                        ),
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
                          const Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: AppColors.kColorPrimary,
                          ),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
