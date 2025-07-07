import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedGradientChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final List<Color>? gradientColors;
  final Color? selectedColor;

  const AnimatedGradientChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
    this.gradientColors,
    this.selectedColor,
  });

  @override
  State<AnimatedGradientChip> createState() => _AnimatedGradientChipState();
}

class _AnimatedGradientChipState extends State<AnimatedGradientChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultGradient = [
      Colors.pink.shade200,
      Colors.purple.shade200,
      Colors.blue.shade200,
      Colors.pink.shade200,
    ];
    final gradient = widget.gradientColors ?? defaultGradient;
    final Color contentColor = widget.isSelected
        ? (ThemeData.estimateBrightnessForColor(
                    widget.selectedColor ?? theme.colorScheme.primary) ==
                Brightness.dark
            ? Colors.white
            : Colors.black)
        : theme.colorScheme.onSurfaceVariant;
    final Color backgroundColor = widget.isSelected
        ? (widget.selectedColor ?? theme.colorScheme.primary)
        : theme.colorScheme.surface;

    return CustomPaint(
      foregroundPainter: widget.isSelected
          ? GradientOutlinePainter(
              animation: _animationController,
              strokeWidth: 2.0,
              radius: 50.0,
              gradientColors: gradient,
            )
          : null,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onSelected(!widget.isSelected),
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 18, color: contentColor),
                const SizedBox(width: 8.0),
                Text(
                  widget.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: contentColor,
                    fontWeight: widget.isSelected ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientOutlinePainter extends CustomPainter {
  final Animation<double> animation;
  final double strokeWidth;
  final double radius;
  final List<Color> gradientColors;

  GradientOutlinePainter({
    required this.animation,
    required this.strokeWidth,
    required this.radius,
    required this.gradientColors,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius))
        .deflate(strokeWidth / 2);

    final paint = Paint()
      ..shader = SweepGradient(
        colors: gradientColors,
        startAngle: 0.0,
        endAngle: pi * 2,
        transform: GradientRotation(animation.value * 2 * pi),
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
