import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'liquid_glass_theme.dart';

class LiquidGlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color? baseColor;
  final double? blurAmount;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final Color? shadowColor;
  final Duration animationDuration;
  final double scaleFactor;
  final bool enableHoverEffect;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 14.0,
    this.baseColor,
    this.blurAmount,
    this.padding,
    this.onTap,
    this.borderColor,
    this.borderWidth = 1.0,
    this.elevation = 0,
    this.shadowColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.scaleFactor = 1.03,
    this.enableHoverEffect = true,
  });

  @override
  State<LiquidGlassCard> createState() => _LiquidGlassCardState();
}

class _LiquidGlassCardState extends State<LiquidGlassCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final glassTheme = theme.extension<LiquidGlassTheme>();

    final effectiveBlurAmount =
        widget.blurAmount ?? glassTheme?.blurAmount ?? 20.0;
    final effectiveBaseColor =
        widget.baseColor ?? Colors.white.withValues(alpha: 0.3);
    final effectiveBorderColor =
        widget.borderColor ?? Colors.white.withValues(alpha: 0.2);
    final effectiveShadowColor =
        widget.shadowColor ?? Colors.black.withValues(alpha: 0.1);

    return MouseRegion(
      onEnter:
          widget.enableHoverEffect
              ? (_) => setState(() => _isHovered = true)
              : null,
      onExit:
          widget.enableHoverEffect
              ? (_) => setState(() {
                _isHovered = false;
                _isPressed = false;
              })
              : null,
      cursor:
          widget.onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        transform:
            Matrix4.identity()..scale(_isHovered ? widget.scaleFactor : 1.0),
        transformAlignment: Alignment.center,
        child: GestureDetector(
          onTapDown:
              widget.onTap != null
                  ? (_) => setState(() => _isPressed = true)
                  : null,
          onTapUp:
              widget.onTap != null
                  ? (_) => setState(() => _isPressed = false)
                  : null,
          onTapCancel:
              widget.onTap != null
                  ? () => setState(() => _isPressed = false)
                  : null,
          onTap: widget.onTap,
          child: AnimatedOpacity(
            duration: widget.animationDuration,
            opacity: _isPressed ? 0.8 : 1.0,
            child: PhysicalModel(
              elevation: widget.elevation,
              color: Colors.transparent,
              shadowColor: effectiveShadowColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: effectiveBlurAmount / 2,
                    sigmaY: effectiveBlurAmount / 2,
                  ),
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    padding: widget.padding ?? const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: effectiveBaseColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color:
                            _isHovered
                                ? effectiveBorderColor.withValues(alpha:0.4)
                                : effectiveBorderColor,
                        width: widget.borderWidth,
                      ),
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
