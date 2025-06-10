import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedGradientOutline extends StatefulWidget {
  final Widget child;
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final double strokeWidth;
  final double radius;
  final List<Color>? gradientColors;
  final double? height; // Hinzugefügt: Optionale feste Höhe

  const AnimatedGradientOutline({
    super.key,
    required this.child,
    this.controller,
    this.labelText,
    this.errorText,
    this.strokeWidth = 2.0,
    this.radius = 12.0,
    this.gradientColors,
    this.height,
  });

  @override
  State<AnimatedGradientOutline> createState() =>
      _AnimatedGradientOutlineState();
}

class _AnimatedGradientOutlineState extends State<AnimatedGradientOutline>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  late final AnimationController _animationController;

  bool get _isFloating =>
      _focusNode.hasFocus || (widget.controller?.text.isNotEmpty ?? false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _focusNode.addListener(() => setState(() {}));
    widget.controller?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    widget.controller?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasError = widget.errorText != null;
    final bool isFocused = _focusNode.hasFocus;

    final defaultGradient = [
      Colors.pink.shade200,
      Colors.purple.shade200,
      Colors.blue.shade200,
      Colors.pink.shade200,
    ];

    // KORREKTUR: Veraltete 'withOpacity' entfernt
    final errorGradient = [
      theme.colorScheme.error.withAlpha(180),
      Colors.orange.shade400.withAlpha(180),
      theme.colorScheme.error.withAlpha(180),
    ];

    double labelWidth = 0;
    if ((isFocused || hasError) && widget.labelText != null) {
      final textStyle =
          theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary);
      final textPainter = TextPainter(
        text: TextSpan(text: widget.labelText!, style: textStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      labelWidth = textPainter.width;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height:
                  widget.height ?? 60.0, // KORREKTUR: Feste Höhe oder Standard
              child: CustomPaint(
                painter: GradientOutlinePainter(
                  isFocused: isFocused || hasError,
                  labelWidth: labelWidth,
                  animation: _animationController,
                  strokeWidth: widget.strokeWidth,
                  radius: widget.radius,
                  gradientColors: hasError
                      ? errorGradient
                      : (widget.gradientColors ?? defaultGradient),
                  backgroundColor: theme.colorScheme.surface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Focus(
                focusNode: _focusNode,
                child: widget.child,
              ),
            ),
            if (widget.labelText != null)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                top: _isFloating ? 6.0 : 18.0,
                left: 16.0,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: _isFloating
                      ? theme.textTheme.bodySmall!.copyWith(
                          color: hasError
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary)
                      : theme.textTheme.bodyLarge!
                          .copyWith(color: theme.colorScheme.onSurfaceVariant),
                  child: Text(widget.labelText!),
                ),
              ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                  sizeFactor: animation, axis: Axis.vertical, child: child),
            );
          },
          child: hasError
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: theme.colorScheme.error, size: 16),
                      const SizedBox(width: 8.0),
                      Text(
                        widget.errorText!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.error),
                      ),
                    ],
                  ),
                )
              : const SizedBox(height: 12.0),
        ),
      ],
    );
  }
}

class GradientOutlinePainter extends CustomPainter {
  final bool isFocused;
  final double labelWidth;
  final Animation<double> animation;
  final double strokeWidth;
  final double radius;
  final List<Color> gradientColors;
  final Color backgroundColor;

  GradientOutlinePainter({
    required this.isFocused,
    this.labelWidth = 0.0,
    required this.animation,
    required this.strokeWidth,
    required this.radius,
    required this.gradientColors,
    required this.backgroundColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRRect(rrect, backgroundPaint);

    if (isFocused) {
      final borderPaint = Paint()
        ..shader = SweepGradient(
          colors: gradientColors,
          startAngle: 0.0,
          endAngle: pi * 2,
          transform: GradientRotation(animation.value * 2 * pi),
        ).createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      final Path path = Path()..addRRect(rrect);

      if (labelWidth > 0) {
        const double gapPadding = 4.0;
        final double gapStart = 12.0;
        final double gapExtent = labelWidth + gapPadding * 2;
        final Path gapPath = Path();
        gapPath.addRect(
            Rect.fromLTWH(gapStart - gapPadding, 0, gapExtent, strokeWidth));
        canvas.clipPath(Path.combine(PathOperation.difference, path, gapPath));
      }

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GradientOutlinePainter oldDelegate) {
    return oldDelegate.isFocused != isFocused ||
        oldDelegate.labelWidth != labelWidth ||
        oldDelegate.animation.value != animation.value;
  }
}
