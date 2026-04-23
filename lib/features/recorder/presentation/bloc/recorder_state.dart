/// State classes for recorder Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/recorder_models.dart';

/// State for recorder feature
class RecorderState {
  /// Current recording status
  final RecordingStatus status;

  /// Result of the recording
  final RecordingResult? recordingResult;

  /// Manual fallback text input
  final String? manualText;

  /// Error message for manual text validation
  final String? manualTextError;

  /// Whether manual fallback is active
  final bool isManualFallback;

  /// Error message for recording
  final String? errorMessage;

  /// Creates an empty recorder state
  const RecorderState({
    this.status = RecordingStatus.idle,
    this.recordingResult,
    this.manualText,
    this.manualTextError,
    this.isManualFallback = false,
    this.errorMessage,
  });

  /// Check if the state is valid for output
  bool get isValid {
    if (isManualFallback && manualText != null) {
      return true;
    }
    return recordingResult?.isSuccess ?? false;
  }

  /// Check if recording is in progress
  bool get isRecording => status == RecordingStatus.recording;

  /// Check if recording has failed
  bool get isFailed => status == RecordingStatus.failed;

  /// Get the current duration
  Duration get duration => recordingResult?.duration ?? Duration.zero;

  /// Copy with method
  RecorderState copyWith({
    RecordingStatus? status,
    RecordingResult? recordingResult,
    String? manualText,
    String? manualTextError,
    bool? isManualFallback,
    String? errorMessage,
  }) {
    return RecorderState(
      status: status ?? this.status,
      recordingResult: recordingResult ?? this.recordingResult,
      manualText: manualText ?? this.manualText,
      manualTextError: manualTextError ?? this.manualTextError,
      isManualFallback: isManualFallback ?? this.isManualFallback,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
