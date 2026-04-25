part of 'asset_manager_cubit.dart';

@freezed
class AssetManagerState with _$AssetManagerState {
  const factory AssetManagerState.idle() = _Idle;
  const factory AssetManagerState.loading() = _Loading;
  const factory AssetManagerState.success() = _Success;
  const factory AssetManagerState.error(String message) = _Error;
}
