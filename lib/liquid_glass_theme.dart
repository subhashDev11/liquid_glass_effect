import 'dart:ui';

import 'package:flutter/material.dart';
import 'models/liquid_glass_config.dart';

class LiquidGlassTheme extends ThemeExtension<LiquidGlassTheme> {
  final double blurAmount;
  final double noiseOpacity;
  final double highlightIntensity;
  final Color highlightColor;
  final Color noiseColor;
  final ButtonStyle? elevatedButtonStyle;
  final ButtonStyle? outlinedButtonStyle;

  const LiquidGlassTheme({
    this.blurAmount = 20.0,
    this.noiseOpacity = 0.03,
    this.highlightIntensity = 0.2,
    this.highlightColor = Colors.white,
    this.noiseColor = Colors.white,
    this.elevatedButtonStyle,
    this.outlinedButtonStyle,
  });

  factory LiquidGlassTheme.fromConfig(LiquidGlassConfig config) {
    return LiquidGlassTheme(
      blurAmount: config.blurAmount,
      noiseOpacity: config.noiseOpacity,
      highlightIntensity: config.highlightIntensity,
      highlightColor: config.highlightColor,
      noiseColor: config.noiseColor,
    );
  }

  // Add this method to convert theme to config
  LiquidGlassConfig toConfig() {
    return LiquidGlassConfig(
      blurAmount: blurAmount,
      noiseOpacity: noiseOpacity,
      highlightIntensity: highlightIntensity,
      highlightColor: highlightColor,
      noiseColor: noiseColor,
    );
  }

  @override
  ThemeExtension<LiquidGlassTheme> copyWith({
    double? blurAmount,
    double? noiseOpacity,
    double? highlightIntensity,
    Color? highlightColor,
    Color? noiseColor,
    ButtonStyle? elevatedButtonStyle,
    ButtonStyle? outlinedButtonStyle,
  }) {
    return LiquidGlassTheme(
      blurAmount: blurAmount ?? this.blurAmount,
      noiseOpacity: noiseOpacity ?? this.noiseOpacity,
      highlightIntensity: highlightIntensity ?? this.highlightIntensity,
      highlightColor: highlightColor ?? this.highlightColor,
      noiseColor: noiseColor ?? this.noiseColor,
      elevatedButtonStyle: elevatedButtonStyle ?? this.elevatedButtonStyle,
      outlinedButtonStyle: outlinedButtonStyle ?? this.outlinedButtonStyle,
    );
  }

  @override
  ThemeExtension<LiquidGlassTheme> lerp(
    ThemeExtension<LiquidGlassTheme>? other,
    double t,
  ) {
    if (other is! LiquidGlassTheme) {
      return this;
    }
    return LiquidGlassTheme(
      blurAmount: lerpDouble(blurAmount, other.blurAmount, t)!,
      noiseOpacity: lerpDouble(noiseOpacity, other.noiseOpacity, t)!,
      highlightIntensity:
          lerpDouble(highlightIntensity, other.highlightIntensity, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      noiseColor: Color.lerp(noiseColor, other.noiseColor, t)!,
      elevatedButtonStyle: ButtonStyle.lerp(
        elevatedButtonStyle,
        other.elevatedButtonStyle,
        t,
      ),
      outlinedButtonStyle: ButtonStyle.lerp(
        outlinedButtonStyle,
        other.outlinedButtonStyle,
        t,
      ),
    );
  }
}

ThemeData createLiquidGlassTheme({
  LiquidGlassConfig config = const LiquidGlassConfig(),
  ColorScheme? colorScheme,
}) {
  final defaultColorScheme = const ColorScheme.light(
    primary: Color(0xFF007AFF), // iOS system blue
    secondary: Color(0xFF34C759), // iOS system green
    surface: Color(0xFFF2F2F7), // iOS system background
    onSurface: Color(0xFFF2F2F7),
  );

  final effectiveColorScheme = colorScheme ?? defaultColorScheme;

  final elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: effectiveColorScheme.onPrimary,
    backgroundColor: effectiveColorScheme.primary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    shadowColor: Colors.transparent,
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return effectiveColorScheme.primary.withOpacity(0.2);
      }
      return Colors.transparent;
    }),
  );

  final outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: effectiveColorScheme.primary,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    side: BorderSide(color: effectiveColorScheme.primary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return effectiveColorScheme.primary.withOpacity(0.1);
      }
      return Colors.transparent;
    }),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme ?? defaultColorScheme,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFF2F2F7),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    extensions: <ThemeExtension<dynamic>>[
      LiquidGlassTheme.fromConfig(config).copyWith(
        elevatedButtonStyle: elevatedButtonStyle,
        outlinedButtonStyle: outlinedButtonStyle,
      ),
    ],
  );
}
