import 'package:flutter/material.dart';

extension ColorWithValues on Color {
  /// Returns a new color with the provided ARGB component values.
  /// Components that are null retain their existing value.
  Color withValues({int? alpha, int? red, int? green, int? blue}) {
    return Color.fromARGB(
      alpha ?? this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }
}
