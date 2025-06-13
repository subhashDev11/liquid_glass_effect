import 'package:flutter/material.dart';

class LiquidGlassConfig {
  final double blurAmount;
  final double noiseOpacity;
  final double highlightIntensity;
  final Color highlightColor;
  final Color noiseColor;

  const LiquidGlassConfig({
    this.blurAmount = 20.0,
    this.noiseOpacity = 0.03,
    this.highlightIntensity = 0.2,
    this.highlightColor = Colors.white,
    this.noiseColor = Colors.white,
  });

  LiquidGlassConfig copyWith({
    double? blurAmount,
    double? noiseOpacity,
    double? highlightIntensity,
    Color? highlightColor,
    Color? noiseColor,
  }) {
    return LiquidGlassConfig(
      blurAmount: blurAmount ?? this.blurAmount,
      noiseOpacity: noiseOpacity ?? this.noiseOpacity,
      highlightIntensity: highlightIntensity ?? this.highlightIntensity,
      highlightColor: highlightColor ?? this.highlightColor,
      noiseColor: noiseColor ?? this.noiseColor,
    );
  }
}