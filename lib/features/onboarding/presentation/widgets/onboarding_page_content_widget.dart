import 'package:flutter/material.dart';

class OnboardingPageContentWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData; // Using IconData for simplicity
  final Color iconColor;   // Color for the icon and its background accent

  const OnboardingPageContentWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenSize.width * 0.4, // Responsive icon container
            height: screenSize.width * 0.4,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 38), // Subtle background
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              size: screenSize.width * 0.2, // Responsive icon size
              color: iconColor,
            ),
          ),
          const SizedBox(height: 48.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5, // Improved line spacing
            ),
          ),
        ],
      ),
    );
  }
}