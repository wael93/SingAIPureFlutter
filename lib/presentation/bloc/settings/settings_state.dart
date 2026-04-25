part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.idle() = _Idle;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.success() = _Success;
  const factory SettingsState.error(String message) = _Error;
}
