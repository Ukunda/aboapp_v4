// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:uuid/uuid.dart' as _i706;

import '../../features/settings/data/datasources/settings_local_datasource.dart'
    as _i723;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i955;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i674;
import '../../features/settings/domain/usecases/get_settings_usecase.dart'
    as _i1029;
import '../../features/settings/domain/usecases/save_currency_setting_usecase.dart'
    as _i851;
import '../../features/settings/domain/usecases/save_locale_setting_usecase.dart'
    as _i682;
import '../../features/settings/domain/usecases/save_theme_setting_usecase.dart'
    as _i150;
import '../../features/settings/domain/usecases/save_ui_style_setting_usecase.dart'
    as _i421;
import '../../features/settings/presentation/cubit/settings_cubit.dart'
    as _i792;
import '../../features/statistics/presentation/cubit/statistics_cubit.dart'
    as _i1049;
import '../../features/subscriptions/data/datasources/subscription_local_datasource.dart'
    as _i327;
import '../../features/subscriptions/data/repositories/subscription_repository_impl.dart'
    as _i944;
import '../../features/subscriptions/domain/repositories/subscription_repository.dart'
    as _i384;
import '../../features/subscriptions/domain/usecases/add_subscription_usecase.dart'
    as _i734;
import '../../features/subscriptions/domain/usecases/delete_subscription_usecase.dart'
    as _i170;
import '../../features/subscriptions/domain/usecases/get_all_subscriptions_usecase.dart'
    as _i899;
import '../../features/subscriptions/domain/usecases/update_subscription_usecase.dart'
    as _i684;
import '../../features/subscriptions/presentation/cubit/subscription_cubit.dart'
    as _i854;
import '../routing/app_router.dart' as _i282;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerExternalDependencies = _$RegisterExternalDependencies();
  gh.factory<_i1049.StatisticsCubit>(() => _i1049.StatisticsCubit());
  gh.lazySingleton<_i706.Uuid>(() => registerExternalDependencies.uuid);
  gh.singleton<_i282.AppRouter>(
      () => _i282.AppRouter(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i723.SettingsLocalDataSource>(
      () => _i723.SettingsLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i674.SettingsRepository>(
      () => _i955.SettingsRepositoryImpl(gh<_i723.SettingsLocalDataSource>()));
  gh.lazySingleton<_i327.SubscriptionLocalDataSource>(() =>
      _i327.SubscriptionLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
  gh.lazySingleton<_i384.SubscriptionRepository>(() =>
      _i944.SubscriptionRepositoryImpl(
          localDataSource: gh<_i327.SubscriptionLocalDataSource>()));
  gh.lazySingleton<_i1029.GetSettingsUseCase>(
      () => _i1029.GetSettingsUseCase(gh<_i674.SettingsRepository>()));
  gh.lazySingleton<_i851.SaveCurrencySettingUseCase>(
      () => _i851.SaveCurrencySettingUseCase(gh<_i674.SettingsRepository>()));
  gh.lazySingleton<_i682.SaveLocaleSettingUseCase>(
      () => _i682.SaveLocaleSettingUseCase(gh<_i674.SettingsRepository>()));
  gh.lazySingleton<_i150.SaveThemeSettingUseCase>(
      () => _i150.SaveThemeSettingUseCase(gh<_i674.SettingsRepository>()));
  gh.lazySingleton<_i421.SaveUIStyleSettingUseCase>(
      () => _i421.SaveUIStyleSettingUseCase(gh<_i674.SettingsRepository>()));
  gh.factory<_i792.SettingsCubit>(() => _i792.SettingsCubit(
        gh<_i1029.GetSettingsUseCase>(),
        gh<_i150.SaveThemeSettingUseCase>(),
        gh<_i682.SaveLocaleSettingUseCase>(),
        gh<_i851.SaveCurrencySettingUseCase>(),
      ));
  gh.lazySingleton<_i734.AddSubscriptionUseCase>(
      () => _i734.AddSubscriptionUseCase(gh<_i384.SubscriptionRepository>()));
  gh.lazySingleton<_i170.DeleteSubscriptionUseCase>(() =>
      _i170.DeleteSubscriptionUseCase(gh<_i384.SubscriptionRepository>()));
  gh.lazySingleton<_i899.GetAllSubscriptionsUseCase>(() =>
      _i899.GetAllSubscriptionsUseCase(gh<_i384.SubscriptionRepository>()));
  gh.lazySingleton<_i684.UpdateSubscriptionUseCase>(() =>
      _i684.UpdateSubscriptionUseCase(gh<_i384.SubscriptionRepository>()));
  gh.factory<_i854.SubscriptionCubit>(() => _i854.SubscriptionCubit(
        gh<_i899.GetAllSubscriptionsUseCase>(),
        gh<_i734.AddSubscriptionUseCase>(),
        gh<_i684.UpdateSubscriptionUseCase>(),
        gh<_i170.DeleteSubscriptionUseCase>(),
        gh<_i706.Uuid>(),
      ));
  return getIt;
}

class _$RegisterExternalDependencies
    extends _i464.RegisterExternalDependencies {}
