import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../application/export_service.dart';

part 'export_state.dart';
part 'export_cubit.freezed.dart';

class ExportCubit extends Cubit<ExportState> {
  final ExportService _exportService;

  ExportCubit(this._exportService) : super(const ExportState.idle());

  Future<void> exportAndShare({
    required List<String> videoUrls,
    required String inputText,
  }) async {
    emit(const ExportState.loading());

    try {
      final result = await _exportService.exportAndShare(
        videoUrls: videoUrls,
        inputText: inputText,
      );

      if (result.success) {
        emit(ExportState.success(
          filePath: result.filePath!,
          fileSize: result.fileSize!,
        ));
      } else {
        emit(ExportState.error(result.error ?? 'Unknown error'));
      }
    } catch (e) {
      emit(ExportState.error(e.toString()));
    }
  }

  void reset() => emit(const ExportState.idle());
}
