import 'package:flutter/material.dart';
import 'dart:math' as math; // For the flip animation if you choose to use it

class AnimatedCounterWidget extends StatelessWidget {
  final double value;
  final String Function(double) formatter;
  final TextStyle style;
  final Duration duration;
  final Curve curve;
  final bool useFlipAnimation; // Optional: if you want a digit-flipping effect

  const AnimatedCounterWidget({
    super.key,
    required this.value,
    required this.formatter,
    required this.style,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
    this.useFlipAnimation = false, // Default to simple tween animation
  });

  @override
  Widget build(BuildContext context) {
    if (useFlipAnimation) {
      // For a true digit-by-digit flip, a more complex widget is needed.
      // This is a simplified version that animates the whole number.
      // A package like `flutter_animate` or custom painting would be better for per-digit flips.
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value), // Or previous value if available
        duration: duration,
        curve: curve,
        builder: (context, animatedValue, child) {
          // Simple text animation, not per-digit flip
          return Text(formatter(animatedValue), style: style);
        },
      );
    } else {
      // Standard TweenAnimationBuilder for the whole text
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: _getBeginValue(), end: value),
        duration: duration,
        curve: curve,
        builder: (context, animatedValue, child) {
          return Text(formatter(animatedValue), style: style);
        },
      );
    }
  }

  // Helper to determine a reasonable start for the animation
  // (e.g., 0 or a fraction of the target value)
  double _getBeginValue() {
    // You could store a previous value if the widget is stateful
    // For a stateless widget, starting from 0 or a fraction is common.
    return 0.0; // Or perhaps value * 0.5 for a less drastic jump from nothing
  }
}