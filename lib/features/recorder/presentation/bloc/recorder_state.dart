/// State classes for recorder Cubit
part of 'recorder_cubit.dart';

/// State for recorder feature
@freezed
class RecorderState with _$RecorderState {
  /// Creates an empty recorder state
  const factory RecorderState({
    /// Current recording status
    @Default(RecordingStatus.idle) RecordingStatus status,

    /// Result of the recording
    RecordingResult? recordingResult,

    /// Manual fallback text input
    String? manualText,

    /// Error message for manual text validation
    String? manualTextError,

    /// Whether manual fallback is active
    @Default(false) bool isManualFallback,

    /// Error message for recording
    String? errorMessage,
  }) = _RecorderState;

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
}
