import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/app.dart'; // The new root widget for your app
import 'package:aboapp/core/di/injection.dart'; // Dependency injection setup
import 'package:flutter_bloc/flutter_bloc.dart'; // If using BLoC observer
// import 'package:aboapp/core/bloc/app_bloc_observer.dart'; // Optional: For observing BLoC states/events

Future<void> main() async {
  // Ensure Flutter bindings are initialized before doing any Flutter-specific setup.
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependencies (GetIt setup)
  // This should be called once before the app runs.
  await configureDependencies();

  // Set preferred orientations (optional, can be configured per screen if needed)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft, // Uncomment if landscape is supported
    // DeviceOrientation.landscapeRight,
  ]);

  // Configure system UI overlay style (status bar, navigation bar)
  // This sets a default style. It can be overridden per screen.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // For light themes (adjust for dark)
      systemNavigationBarColor: Colors.transparent, // Transparent navigation bar
      systemNavigationBarIconBrightness: Brightness.dark, // For light themes
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // Optional: Initialize BLoC observer for debugging state changes
  // Bloc.observer = AppBlocObserver();

  // Run the app
  runApp(const AboApp());
}