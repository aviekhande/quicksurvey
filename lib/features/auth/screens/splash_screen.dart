import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/theme/app_colors.dart';

/// Splash screen with animated logo, tagline, and floating particle effect.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Logo reveal animation
  late AnimationController _logoCtrl;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  // Tagline slide-up animation
  late AnimationController _textCtrl;
  late Animation<Offset> _textSlide;
  late Animation<double> _textFade;

  // Rotating glow ring
  late AnimationController _ringCtrl;

  // Floating particles
  late AnimationController _particleCtrl;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Logo pops in with elastic spring
    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Text slides up after logo
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic));
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut),
    );

    // Perpetually rotating outer ring
    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Particles float upward endlessly
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _textCtrl.forward();

    // Navigate after minimum display time
    await Future.delayed(const Duration(milliseconds: 1800));
    _navigate();
  }

  void _navigate() {
    // Auto-login if a valid session exists in Hive
    if (LocalStorageService.isLoggedIn()) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _ringCtrl.dispose();
    _particleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorBg,
      body: Stack(
        children: [
          // Floating particles layer
          AnimatedBuilder(
            animation: _particleCtrl,
            builder: (_, __) => CustomPaint(
              painter: _ParticlePainter(_particleCtrl.value),
              size: Size.infinite,
            ),
          ),

          // Central content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rotating ring + animated logo icon
                AnimatedBuilder(
                  animation: _ringCtrl,
                  builder: (_, child) => Transform.rotate(
                    angle: _ringCtrl.value * 2 * pi,
                    child: child,
                  ),
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.kColorPrimary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // Logo box overlapping the ring
                Transform.translate(
                  offset: const Offset(0, -75),
                  child: FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: _LogoBadge(),
                    ),
                  ),
                ),

                const SizedBox(height: 0),

                // App name + tagline slide up
                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.gradientPrimary.createShader(bounds),
                          child: const Text(
                            AppStrings.kAppTitle,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          AppStrings.kTagline,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.kColorTextMuted,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom loading indicator
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textFade,
              child: Column(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.kColorPrimary.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Initializing...',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kColorTextDisabled,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The square gradient logo badge.
class _LogoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.kColorPrimary.withOpacity(0.5),
            blurRadius: 32,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.poll_outlined,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

/// Custom painter that renders softly floating gradient dots.
class _ParticlePainter extends CustomPainter {
  final double progress;
  static final _rng = Random(42); // Fixed seed for deterministic particles

  // Generate 18 particles with stable positions
  static final _particles = List.generate(18, (i) => _Particle(_rng));

  _ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final dy = ((p.startY + progress * p.speed * size.height) % size.height);
      final opacity = (0.06 + 0.12 * sin(progress * 2 * pi + p.phase))
          .clamp(0.0, 0.18);

      final paint = Paint()
        ..color = AppColors.kColorPrimary.withOpacity(opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawCircle(
        Offset(p.x * size.width, dy),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

class _Particle {
  final double x;
  final double startY;
  final double radius;
  final double speed;
  final double phase;

  _Particle(Random rng)
      : x = rng.nextDouble(),
        startY = rng.nextDouble(),
        radius = 2 + rng.nextDouble() * 5,
        speed = 0.2 + rng.nextDouble() * 0.4,
        phase = rng.nextDouble() * 2 * pi;
}
