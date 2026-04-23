/// Domain repository interface for recorder
import '../../domain/models/recorder_models.dart';

/// Repository interface for recorder operations
abstract class RecorderRepository {
  /// Start recording
  Future<RecordingResult> startRecording();

  /// Stop recording
  Future<RecordingResult> stopRecording();

  /// Cancel recording
  Future<void> cancelRecording();

  /// Check if recording is in progress
  bool isRecording();

  /// Get current recording duration
  Duration getDuration();

  /// Validate manual fallback text
  bool validateManualText(String text);
}
