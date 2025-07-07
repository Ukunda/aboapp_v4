// lib/features/settings/domain/usecases/save_salary_settings_usecase.dart

import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveSalarySettingsUseCase {
  final SettingsRepository repository;

  SaveSalarySettingsUseCase(this.repository);

  Future<void> call({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  }) async {
    return await repository.saveSalarySettings(
      salary: salary,
      salaryCycle: salaryCycle,
      hasThirteenthSalary: hasThirteenthSalary,
    );
  }
}
