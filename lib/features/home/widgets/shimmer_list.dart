import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ShimmerList extends StatefulWidget {
  const ShimmerList();

  @override
  State<ShimmerList> createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList>
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
        builder: (_, __) => ShimmerCard(shimmerOffset: _anim.value),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({required this.shimmerOffset});
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
