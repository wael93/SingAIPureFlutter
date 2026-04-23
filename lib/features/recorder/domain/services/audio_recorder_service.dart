/// Domain service interface for audio recording
import '../models/recorder_models.dart';

/// Interface for audio recording service
abstract class AudioRecorderService {
  /// Start recording audio
  Future<void> startRecording();

  /// Stop recording and return result
  Future<RecordingResult> stopRecording();

  /// Cancel the current recording
  Future<void> cancelRecording();

  /// Check if recording is in progress
  bool isRecording();

  /// Get the current recording duration
  Duration getRecordingDuration();
}
