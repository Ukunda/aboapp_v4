#!/usr/bin/env dart

// Script to analyze localization files and detect issues
// Run with: dart run scripts/analyze_l10n.dart

import 'dart:io';
import '../lib/core/localization/localization_analyzer.dart';

void main() async {
  print('🔍 Analyzing localization files...\n');
  
  // Check if we're in the right directory
  final l10nDir = Directory('assets/l10n');
  if (!await l10nDir.exists()) {
    print('❌ Error: assets/l10n directory not found.');
    print('Make sure to run this script from the project root directory.');
    exit(1);
  }
  
  // Run analysis
  final report = await LocalizationAnalyzer.analyze();
  
  // Print results
  LocalizationAnalyzer.printReport(report);
  
  // Exit with appropriate code
  if (!report.isValid) {
    print('\n❌ Localization issues found. Please fix them before continuing.');
    exit(1);
  } else if (report.hasWarnings) {
    print('\n⚠️  Localization warnings found. Consider reviewing them.');
    exit(0);
  } else {
    print('\n🎉 All good! No localization issues found.');
    exit(0);
  }
}