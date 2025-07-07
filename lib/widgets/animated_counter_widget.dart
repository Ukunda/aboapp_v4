import 'package:flutter/material.dart';

class AnimatedCounterWidget extends StatefulWidget {
  final double value;
  final String Function(double) formatter;
  final TextStyle style;
  final Duration duration;
  final Curve curve;

  const AnimatedCounterWidget({
    super.key,
    required this.value,
    required this.formatter,
    required this.style,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedCounterWidget> createState() => _AnimatedCounterWidgetState();
}

class _AnimatedCounterWidgetState extends State<AnimatedCounterWidget> {
  late double _oldValue;

  @override
  void initState() {
    super.initState();
    // Startwert ist 0 für die erste Animation
    _oldValue = 0.0;
  }

  @override
  void didUpdateWidget(covariant AnimatedCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Bei Updates merken wir uns den vorherigen Wert für einen flüssigen Übergang
    if (widget.value != oldWidget.value) {
      _oldValue = oldWidget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: _oldValue, end: widget.value),
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, animatedValue, child) {
        return Text(widget.formatter(animatedValue), style: widget.style);
      },
    );
  }
}