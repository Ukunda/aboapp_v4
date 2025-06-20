import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart'; // <-- Make sure Uuid is imported
// This import will be generated by build_runner
import 'injection.config.dart'; // Ensure this line exists

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // Default name for the generated function
  preferRelativeImports: true, // Prefer relative imports in generated file
  asExtension: false, // Generate as a function, not an extension
)
Future<void> configureDependencies() async {
  // Register modules and external dependencies manually if they cannot be annotated.
  // SharedPreferences is a common example.
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Initialize all modules and injectable dependencies
  $initGetIt(getIt);
}

// Example of a module if you need to provide dependencies that
// are not classes or come from third-party libraries without annotations.
@module
abstract class RegisterExternalDependencies {
  // ADD THIS LINE TO REGISTER UUID
  @lazySingleton
  Uuid get uuid => const Uuid();
}
