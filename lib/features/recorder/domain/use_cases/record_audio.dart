/// Domain use case for recording audio
import '../../data/services/audio_recorder_service.dart';
import '../models/recorder_models.dart';

/// Use case for starting and stopping audio recording
class RecordAudio {
  final AudioRecorderService _service;

  const RecordAudio(this._service);

  /// Start recording audio
  /// Returns: Future<void>
  Future<void> start() async {
    await _service.startRecording();
  }

  /// Stop recording audio
  /// Returns: RecordingResult with audio path and duration
  Future<RecordingResult> stop() async {
    final result = await _service.stopRecording();
    return result;
  }

  /// Cancel the current recording
  /// Returns: Future<void>
  Future<void> cancel() async {
    await _service.cancelRecording();
  }

  /// Check if recording is in progress
  /// Returns: bool
  bool isRecording() {
    return _service.isRecording();
  }

  /// Get the current recording duration
  /// Returns: Duration
  Duration getDuration() {
    return _service.getRecordingDuration();
  }
}
