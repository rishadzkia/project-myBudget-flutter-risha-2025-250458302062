import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_budget/auth/pages/on_boarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulse = Tween<double>(
      begin: 0.97,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041B34),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              return Stack(
                fit: StackFit.expand,
                children: [
                  const CustomPaint(painter: SplashBackgroundPainter()),

                  // Lingkaran kiri atas
                  Positioned(
                    top: height * 0.22,
                    left: width * 0.10,
                    child: const _SoftCircle(size: 70),
                  ),

                  // Lingkaran kanan bawah
                  Positioned(
                    top: height * 0.63,
                    right: width * 0.05,
                    child: const _SoftCircle(size: 100),
                  ),

                  // Glow belakang logo
                  Center(
                    child: Container(
                      width: width * 0.42,
                      height: width * 0.42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF62B6F6).withOpacity(0.55),
                            blurRadius: 50,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Logo tengah
                  Center(
                    child: ScaleTransition(
                      scale: _pulse,
                      child: Image.asset(
                        'assets/splash/Group 43.png',
                        width: width * 0.36,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class SplashBackgroundPainter extends CustomPainter {
  const SplashBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF061D39), Color(0xFF03172D)],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final bluePaint = Paint()
      ..color = const Color(0xFF0C4677)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = const Color(0xFF6EC6FF).withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    // Bentuk biru kanan atas
    final topPath = Path()
      ..moveTo(width * 0.42, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height * 0.34)
      ..cubicTo(
        width * 0.96,
        height * 0.36,
        width * 0.88,
        height * 0.34,
        width * 0.84,
        height * 0.27,
      )
      ..cubicTo(
        width * 0.77,
        height * 0.15,
        width * 0.55,
        height * 0.15,
        width * 0.40,
        height * 0.10,
      )
      ..cubicTo(
        width * 0.27,
        height * 0.06,
        width * 0.30,
        height * 0.01,
        width * 0.42,
        0,
      )
      ..close();

    canvas.drawPath(topPath, glowPaint);
    canvas.drawPath(topPath, bluePaint);

    // Bentuk biru kiri bawah
    final bottomPath = Path()
      ..moveTo(0, height * 0.62)
      ..cubicTo(
        width * 0.30,
        height * 0.60,
        width * 0.58,
        height * 0.73,
        width * 0.62,
        height,
      )
      ..lineTo(0, height)
      ..close();

    canvas.drawPath(bottomPath, glowPaint);
    canvas.drawPath(bottomPath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _SoftCircle extends StatelessWidget {
  final double size;

  const _SoftCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF344C5F).withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.08),
            blurRadius: 2,
            offset: const Offset(-1, -1),
          ),
        ],
      ),
    );
  }
}
