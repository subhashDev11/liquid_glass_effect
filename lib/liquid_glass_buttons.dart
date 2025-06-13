import 'package:flutter/material.dart';
import 'liquid_glass_theme.dart';

class LiquidGlassElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;

  const LiquidGlassElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<LiquidGlassTheme>();
    final defaultStyle = theme?.elevatedButtonStyle;

    return ElevatedButton(
      onPressed: onPressed,
      style: (style ?? defaultStyle)?.copyWith(
        // Add glass effect overlay
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.primary.withValues(alpha: 0.2);
          }
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);
          }
          return Colors.transparent;
        }),
      ),
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

class LiquidGlassOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;

  const LiquidGlassOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<LiquidGlassTheme>();
    final defaultStyle = theme?.outlinedButtonStyle;

    return OutlinedButton(
      onPressed: onPressed,
      style: (style ?? defaultStyle)?.copyWith(
        // Add glass effect overlay
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.05);
          }
          return Colors.transparent;
        }),
      ),
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
