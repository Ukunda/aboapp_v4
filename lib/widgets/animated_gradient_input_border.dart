import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedGradientInputBorder extends OutlineInputBorder {
  final Animation<double> animation;
  final List<Color> gradientColors;

  const AnimatedGradientInputBorder({
    required this.animation,
    required this.gradientColors,
    super.borderSide = const BorderSide(width: 2.0),
    super.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    super.gapPadding = 4.0,
  });

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final Paint paint = borderSide.toPaint();

    paint.shader = SweepGradient(
      colors: gradientColors,
      startAngle: 0.0,
      endAngle: pi * 2,
      transform: GradientRotation(animation.value * 2 * pi),
    ).createShader(rect);

    final Path path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, paint);
  }

  @override
  AnimatedGradientInputBorder scale(double t) {
    return AnimatedGradientInputBorder(
      animation: animation,
      gradientColors: gradientColors,
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      gapPadding: gapPadding * t,
    );
  }
}
