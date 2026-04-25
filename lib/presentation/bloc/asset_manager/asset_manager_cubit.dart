// TODO: Implement asset manager cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_manager_state.dart';

class AssetManagerCubit extends Cubit<AssetManagerState> {
  AssetManagerCubit() : super(const AssetManagerState.idle());
  
  // Placeholder for asset manager cubit methods
}

@freezed
class AssetManagerState with _$AssetManagerState {
  const factory AssetManagerState.idle() = _Idle;
  const factory AssetManagerState.loading() = _Loading;
  const factory AssetManagerState.success() = _Success;
  const factory AssetManagerState.error(String message) = _Error;
}
