import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentPageIndex;
  final int pageCount;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicatorWidget({
    super.key,
    required this.currentPageIndex,
    required this.pageCount,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentPageIndex == index ? 24.0 : 8.0, // Active indicator is wider
          height: 8.0,
          decoration: BoxDecoration(
            color: currentPageIndex == index ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}