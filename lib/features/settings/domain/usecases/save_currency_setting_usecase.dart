import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveCurrencySettingUseCase {
  final SettingsRepository repository;

  SaveCurrencySettingUseCase(this.repository);

  Future<void> call(String currencyCode) async {
    return await repository.saveCurrencyCode(currencyCode);
  }
}