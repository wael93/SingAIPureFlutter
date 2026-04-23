part of 'export_cubit.dart';

@freezed
class ExportState with _$ExportState {
  const factory ExportState.idle() = _Idle;
  const factory ExportState.loading() = _Loading;
  const factory ExportState.success({
    required String filePath,
    required int fileSize,
  }) = _Success;
  const factory ExportState.error(String message) = _Error;
}
