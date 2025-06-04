import 'package:flutter/material.dart';
// import 'dart:math' as math; // Unused import

class AnimatedCounterWidget extends StatelessWidget {
  final double value;
  final String Function(double) formatter;
  final TextStyle style;
  final Duration duration;
  final Curve curve;
  final bool useFlipAnimation; 

  const AnimatedCounterWidget({
    super.key,
    required this.value,
    required this.formatter,
    required this.style,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
    this.useFlipAnimation = false, 
  });

  @override
  Widget build(BuildContext context) {
    if (useFlipAnimation) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value), 
        duration: duration,
        curve: curve,
        builder: (context, animatedValue, child) {
          return Text(formatter(animatedValue), style: style);
        },
      );
    } else {
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

  double _getBeginValue() {
    return 0.0; 
  }
}