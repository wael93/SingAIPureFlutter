/// Data layer repository implementation for recorder
import '../../../domain/models/recorder_models.dart';
import '../../../domain/validators/recorder_validator.dart';
import '../../services/audio_recorder_service.dart';

/// Repository implementation for recorder operations
/// Fallback: All methods handle errors gracefully
class RecorderRepositoryImpl {
  final AudioRecorderService _service;
  final RecorderValidator _validator;

  RecorderRepositoryImpl({
    AudioRecorderService? service,
    RecorderValidator? validator,
  })  : _service = service ?? AudioRecorderService(),
        _validator = validator ?? RecorderValidator();

  /// Start recording
  /// Validates: Requirements 2.2 - Microphone permission
  /// Fallback: Returns failure result if permission denied
  Future<RecordingResult> startRecording() async {
    try {
      await _service.startRecording();
      return RecordingResult(
        audioPath: null,
        duration: Duration.zero,
        status: RecordingStatus.recording,
      );
    } on Exception catch (e) {
      return RecordingResult(
        audioPath: null,
        duration: Duration.zero,
        status: RecordingStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  /// Stop recording
  /// Validates: Requirements 2.3 - Duration validation (2-15s)
  /// Fallback: Returns failure result if validation fails
  Future<RecordingResult> stopRecording() async {
    try {
      final result = await _service.stopRecording();

      // Validate duration
      if (result.audioPath != null) {
        final config = RecordingConfig();
        if (!_validator.validateDuration(result.duration, config)) {
          return result.copyWith(
            status: RecordingStatus.failed,
            errorMessage: 'Duration must be between 2 and 15 seconds',
          );
        }
      }

      return result;
    } on Exception catch (e) {
      return RecordingResult(
        audioPath: null,
        duration: Duration.zero,
        status: RecordingStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  /// Cancel recording
  Future<void> cancelRecording() async {
    await _service.cancelRecording();
  }

  /// Check if recording is in progress
  bool isRecording() {
    return _service.isRecording();
  }

  /// Get current recording duration
  Duration getDuration() {
    return _service.getRecordingDuration();
  }

  /// Validate manual fallback text
  /// Validates: Requirements 2.4 - Manual fallback text input
  bool validateManualText(String text) {
    return _validator.validateManualText(text, 500);
  }
}
