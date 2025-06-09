// lib/features/settings/domain/usecases/save_ui_style_setting_usecase.dart

import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveUIStyleSettingUseCase {
  final SettingsRepository repository;

  SaveUIStyleSettingUseCase(this.repository);

  Future<void> call(AppUIStyle uiStyle) async {
    return await repository.saveUIStyle(uiStyle);
  }
}
