import 'package:flutter/material.dart';
import 'liquid_glass_painter.dart';
import 'liquid_glass_theme.dart';
import 'models/liquid_glass_config.dart';

class LiquidGlassBackground extends StatefulWidget {
  final Widget child;
  final double? blurAmount;
  final double? noiseOpacity;
  final double? highlightIntensity;
  final Color? highlightColor;
  final Color? noiseColor;
  final ImageProvider? backgroundImageProvider;
  final Gradient? backgroundGradient;
  final BoxFit backgroundFit;
  final Alignment backgroundAlignment;

  const LiquidGlassBackground({
    super.key,
    required this.child,
    this.blurAmount,
    this.noiseOpacity,
    this.highlightIntensity,
    this.highlightColor,
    this.noiseColor,
    this.backgroundImageProvider,
    this.backgroundGradient,
    this.backgroundFit = BoxFit.cover,
    this.backgroundAlignment = Alignment.center,
  });

  @override
  State<LiquidGlassBackground> createState() => _LiquidGlassBackgroundState();
}

class _LiquidGlassBackgroundState extends State<LiquidGlassBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<LiquidGlassTheme>();

    final effectiveConfig = LiquidGlassConfig(
      blurAmount: widget.blurAmount ?? theme?.blurAmount ?? 20.0,
      noiseOpacity: widget.noiseOpacity ?? theme?.noiseOpacity ?? 0.03,
      highlightIntensity:
          widget.highlightIntensity ?? theme?.highlightIntensity ?? 0.2,
      highlightColor:
          widget.highlightColor ?? theme?.highlightColor ?? Colors.white,
      noiseColor: widget.noiseColor ?? theme?.noiseColor ?? Colors.white,
    );

    return Stack(
      children: [
        // Background with subtle gradient
        Container(decoration: getBgDecoration),

        // Liquid glass effect layer
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: LiquidGlassPainter(
                animationValue: _animation.value,
                config: effectiveConfig,
              ),
              child: child,
            );
            //return child!;
          },
          child: widget.child,
        ),
      ],
    );
  }

  BoxDecoration? get getBgDecoration {
    if (widget.backgroundImageProvider == null) {
      // return BoxDecoration(gradient: getBgGradient(true));
      return null;
    } else {
      return BoxDecoration(
        image: DecorationImage(
          image: widget.backgroundImageProvider!,
          fit: widget.backgroundFit,
          alignment: widget.backgroundAlignment,
        ),
        gradient: getBgGradient(false),
      );
    }
  }

  Gradient? getBgGradient(bool applyDefault) {
    if (widget.backgroundGradient == null) {
      return applyDefault
          ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF2F2F7), Color(0xFFE5E5EA)],
          )
          : null;
    } else {
      return widget.backgroundGradient!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
