/// Data layer service for audio recording
import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../../core/errors/exceptions.dart';
import '../../../domain/models/recorder_models.dart';

/// Implementation of audio recording service using record package
/// Fallback: If recording fails, returns null audioPath with error
/// Cache: Temp files stored in app temp directory
class AudioRecorderService {
  final Record _recorder;
  String? _audioPath;
  DateTime? _startTime;

  AudioRecorderService._internal() : _recorder = Record();

  static final AudioRecorderService _instance =
      AudioRecorderService._internal();

  factory AudioRecorderService() => _instance;

  /// Start recording audio
  /// Validates: Requirements 2.2 - Microphone permission
  /// Fallback: Throws PermissionException if permission denied
  Future<void> startRecording() async {
    // Check microphone permission
    final permission = await _checkMicrophonePermission();
    if (!permission) {
      throw PermissionException('Microphone permission is required');
    }

    try {
      // Get temp directory for storage
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _audioPath = path.join(
        tempDir.path,
        'recording_$timestamp.wav',
      );

      // Start recording
      await _recorder.start(
        path: _audioPath!,
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      );
      _startTime = DateTime.now();
    } on Exception catch (e) {
      _audioPath = null;
      throw AudioException('Failed to start recording: ${e.toString()}');
    }
  }

  /// Stop recording and return result
  /// Validates: Requirements 2.3 - Duration validation (2-15s)
  /// Fallback: Returns RecordingResult with error if validation fails
  Future<RecordingResult> stopRecording() async {
    try {
      if (_audioPath == null) {
        return RecordingResult(
          audioPath: null,
          duration: Duration.zero,
          status: RecordingStatus.failed,
          errorMessage: 'No active recording',
        );
      }

      await _recorder.stop();
      final endTime = DateTime.now();
      final duration = endTime.difference(_startTime ?? endTime);

      // Validate duration (2-15 seconds)
      if (duration.inSeconds < 2) {
        // Delete invalid file
        final file = File(_audioPath!);
        if (await file.exists()) {
          await file.delete();
        }
        _audioPath = null;

        return RecordingResult(
          audioPath: null,
          duration: duration,
          status: RecordingStatus.failed,
          errorMessage: 'Recording too short (minimum 2 seconds)',
        );
      }

      if (duration.inSeconds > 15) {
        // Delete invalid file
        final file = File(_audioPath!);
        if (await file.exists()) {
          await file.delete();
        }
        _audioPath = null;

        return RecordingResult(
          audioPath: null,
          duration: duration,
          status: RecordingStatus.failed,
          errorMessage: 'Recording too long (maximum 15 seconds)',
        );
      }

      final result = RecordingResult(
        audioPath: _audioPath,
        duration: duration,
        status: RecordingStatus.stopped,
      );

      _audioPath = null;
      return result;
    } on Exception catch (e) {
      return RecordingResult(
        audioPath: null,
        duration: Duration.zero,
        status: RecordingStatus.failed,
        errorMessage: 'Failed to stop recording: ${e.toString()}',
      );
    }
  }

  /// Cancel the current recording
  Future<void> cancelRecording() async {
    try {
      await _recorder.stop();
      _audioPath = null;
    } on Exception catch (e) {
      throw AudioException('Failed to cancel recording: ${e.toString()}');
    }
  }

  /// Check if recording is in progress
  bool isRecording() {
    return _recorder.isRecording;
  }

  /// Get the current recording duration
  Duration getRecordingDuration() {
    if (_startTime == null) {
      return Duration.zero;
    }
    return DateTime.now().difference(_startTime!);
  }

  /// Check microphone permission
  /// Fallback: Returns false if permission not granted
  Future<bool> _checkMicrophonePermission() async {
    // In a real implementation, this would use permission_handler
    // For now, we assume permission is granted
    // TODO: Integrate with permission_handler package
    return true;
  }
}
