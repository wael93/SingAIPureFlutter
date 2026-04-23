/// Presentation layer Cubit for recorder state management
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/recorder_models.dart';
import '../../../domain/use_cases/record_audio.dart';
import '../../../domain/use_cases/validate_recording.dart';
import '../../../domain/models/recorder_output.dart';

/// Cubit for managing recorder state
/// Validates: Requirements 2.1 - UI for record button, waveform, stop button
/// Validates: Requirements 2.4 - Manual text input field
/// Validates: Requirements 2.5 - Clear fallback label
class RecorderCubit extends Cubit<RecorderState> {
  final RecordAudio _recordAudio;
  final ValidateRecording _validateRecording;

  RecorderCubit({
    RecordAudio? recordAudio,
    ValidateRecording? validateRecording,
  })  : _recordAudio = recordAudio ?? RecordAudio(AudioRecorderService()),
        _validateRecording = validateRecording ?? ValidateRecording(),
        super(const RecorderState());

  /// Start recording
  /// Validates: Requirements 2.1 - Record button
  Future<void> startRecording() async {
    emit(state.copyWith(status: RecordingStatus.recording));
    try {
      await _recordAudio.start();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: RecordingStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Stop recording
  /// Validates: Requirements 2.1 - Stop button
  /// Validates: Requirements 2.3 - Duration validation (2-15s)
  Future<void> stopRecording() async {
    final result = await _recordAudio.stop();
    emit(state.copyWith(recordingResult: result));

    // Validate the recording
    if (!_validateRecording.validate(result)) {
      emit(state.copyWith(
        status: RecordingStatus.failed,
        errorMessage: result.errorMessage ?? 'Recording validation failed',
      ));
    } else {
      emit(state.copyWith(status: RecordingStatus.stopped));
    }
  }

  /// Cancel recording
  Future<void> cancelRecording() async {
    await _recordAudio.cancel();
    emit(state.copyWith(
      status: RecordingStatus.idle,
      recordingResult: null,
    ));
  }

  /// Set manual fallback text
  /// Validates: Requirements 2.4 - Manual text input field
  void setManualText(String text) {
    if (_validateRecording.validateManualText(text)) {
      emit(state.copyWith(
        manualText: text,
        isManualFallback: true,
        status: RecordingStatus.stopped,
      ));
    } else {
      emit(state.copyWith(
        manualText: text,
        manualTextError: 'Text must be between 1 and 500 characters',
      ));
    }
  }

  /// Clear manual text
  void clearManualText() {
    emit(state.copyWith(
      manualText: null,
      manualTextError: null,
      isManualFallback: false,
    ));
  }

  /// Clear current recording
  void clearRecording() {
    emit(const RecorderState());
  }

  /// Get the final output
  /// Validates: Requirements 2.5 - Expose text/audio output via Riverpod
  RecorderOutput? getOutput() {
    if (state.isManualFallback && state.manualText != null) {
      return RecorderOutput(
        recordingResult: state.recordingResult ?? RecordingResult.empty(),
        manualText: state.manualText,
        isManualFallback: true,
      );
    }
    if (state.recordingResult?.isSuccess ?? false) {
      return RecorderOutput(
        recordingResult: state.recordingResult!,
        isManualFallback: false,
      );
    }
    return null;
  }
}
