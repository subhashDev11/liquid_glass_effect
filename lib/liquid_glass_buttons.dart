import 'package:flutter/material.dart';
import 'liquid_glass_theme.dart';

/// A custom [ElevatedButton] that applies a glass-like visual theme
/// from [LiquidGlassTheme].
///
/// This button inherits default styles from [LiquidGlassTheme.elevatedButtonStyle],
/// and provides custom overlay colors on hover and press.
///
/// Example:
/// ```dart
/// LiquidGlassElevatedButton(
///   onPressed: () => print('Pressed'),
///   child: Text('Submit'),
/// )
/// ```
class LiquidGlassElevatedButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Custom style to override default button style.
  final ButtonStyle? style;

  /// Whether this button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// {@macro flutter.material.RawMaterialButton.clipBehavior}
  final Clip clipBehavior;

  /// Creates a LiquidGlass-styled [ElevatedButton].
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
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.primary.withAlpha(50);
          }
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context).colorScheme.primary.withAlpha(25);
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

/// A custom [OutlinedButton] that applies a glass-like visual theme
/// from [LiquidGlassTheme].
///
/// This button inherits default styles from [LiquidGlassTheme.outlinedButtonStyle],
/// and provides custom overlay colors on hover and press.
///
/// Example:
/// ```dart
/// LiquidGlassOutlinedButton(
///   onPressed: () => print('Pressed'),
///   child: Text('Cancel'),
/// )
/// ```
class LiquidGlassOutlinedButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Custom style to override default button style.
  final ButtonStyle? style;

  /// Whether this button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// {@macro flutter.material.RawMaterialButton.clipBehavior}
  final Clip clipBehavior;

  /// Creates a LiquidGlass-styled [OutlinedButton].
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
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.primary.withAlpha(25);
          }
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context).colorScheme.primary.withAlpha(12);
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