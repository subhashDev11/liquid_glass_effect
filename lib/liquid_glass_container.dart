import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that applies a frosted glass effect to its child.
///
/// This widget uses `BackdropFilter` to apply a blur effect and an overlay
/// with a specified opacity to create the liquid glass appearance.
class LiquidGlassContainer extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The amount of blur to apply to the background.
  ///
  /// A higher value means a more blurred background.
  final double blur;

  /// The opacity of the overlay color.
  ///
  /// A value of 0.0 means completely transparent, and 1.0 means completely opaque.
  final double opacity;

  /// The padding to apply to the child.
  final EdgeInsetsGeometry? padding;

  /// The radius of the corners of the glass container.
  ///
  /// If null, a default of `BorderRadius.circular(16)` is used.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [LiquidGlassContainer].
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.2,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((255 * opacity).round()),
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}