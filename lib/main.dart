import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/app.dart'; 
import 'package:aboapp/core/di/injection.dart'; 
// import 'package:flutter_bloc/flutter_bloc.dart'; // Unused import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.dark, 
      systemNavigationBarColor: Colors.transparent, 
      systemNavigationBarIconBrightness: Brightness.dark, 
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(const AboApp());
}