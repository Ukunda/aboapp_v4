import 'package:flutter/material.dart';

extension ColorWithValues on Color {
  /// Returns a new color with the provided ARGB component values.
  /// Components that are null retain their existing value.
  Color withValues({int? alpha, int? red, int? green, int? blue}) {
    return Color.fromARGB(
      alpha ?? (value >> 24) & 0xFF,
      red ?? (value >> 16) & 0xFF,
      green ?? (value >> 8) & 0xFF,
      blue ?? value & 0xFF,
    );
  }
}
