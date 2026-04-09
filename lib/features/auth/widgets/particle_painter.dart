import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ParticlePainter extends CustomPainter {
  final double progress;
  static final _rng = Random(42);

  static final _particles = List.generate(18, (i) => Particle(_rng));

  ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final dy = ((p.startY + progress * p.speed * size.height) % size.height);
      final opacity = (0.06 + 0.12 * sin(progress * 2 * pi + p.phase)).clamp(
        0.0,
        0.18,
      );

      final paint = Paint()
        ..color = AppColors.kColorPrimary.withOpacity(opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawCircle(Offset(p.x * size.width, dy), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter old) => old.progress != progress;
}

class Particle {
  final double x;
  final double startY;
  final double radius;
  final double speed;
  final double phase;

  Particle(Random rng)
    : x = rng.nextDouble(),
      startY = rng.nextDouble(),
      radius = 2 + rng.nextDouble() * 5,
      speed = 0.2 + rng.nextDouble() * 0.4,
      phase = rng.nextDouble() * 2 * pi;
}
