// lib/core/di/injection.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
// Die Funktion muss async sein, da @preResolve die generierte
// init-Funktion asynchron macht.
Future<void> configureDependencies() async => await $initGetIt(getIt);

// Wir registrieren SharedPreferences jetzt hier im Modul,
// anstatt manuell in der configureDependencies-Funktion.
@module
abstract class RegisterExternalDependencies {
  @lazySingleton
  Uuid get uuid => const Uuid();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  // NEU: Asynchrone Factory für SharedPreferences.
  // @preResolve weist den Generator an, auf das Future zu warten.
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
