import 'dart:math';
import 'package:flutter/material.dart';
import 'models/liquid_glass_config.dart';

class LiquidGlassPainter extends CustomPainter {
  final double animationValue;
  final LiquidGlassConfig config;

  LiquidGlassPainter({
    required this.animationValue,
    required this.config,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw subtle liquid-like highlights
    final highlightPaint = Paint()
      ..color = config.highlightColor.withAlpha(config.highlightIntensity.toInt())
      ..style = PaintingStyle.fill;

    // Create wavy highlight paths based on animation
    final wavePath = Path();
    wavePath.moveTo(0, size.height * 0.3);
    wavePath.quadraticBezierTo(
      size.width * 0.25,
      size.height * (0.3 + animationValue * 0.1),
      size.width * 0.5,
      size.height * 0.3,
    );
    wavePath.quadraticBezierTo(
      size.width * 0.75,
      size.height * (0.3 - animationValue * 0.1),
      size.width,
      size.height * 0.3,
    );
    wavePath.lineTo(size.width, size.height * 0.4);
    wavePath.quadraticBezierTo(
      size.width * 0.75,
      size.height * (0.4 + animationValue * 0.1),
      size.width * 0.5,
      size.height * 0.4,
    );
    wavePath.quadraticBezierTo(
      size.width * 0.25,
      size.height * (0.4 - animationValue * 0.1),
      0,
      size.height * 0.4,
    );
    wavePath.close();

    canvas.drawPath(wavePath, highlightPaint);

    // Draw noise texture for frosted glass effect
    _drawNoise(canvas, size);
  }

  void _drawNoise(Canvas canvas, Size size) {
    //final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..color = config.noiseColor.withValues(alpha:config.noiseOpacity);

    // Create a simple noise texture
    final rng = Random(12345); // Fixed seed for consistent noise
    for (int i = 0; i < 1000; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final radius = rng.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}