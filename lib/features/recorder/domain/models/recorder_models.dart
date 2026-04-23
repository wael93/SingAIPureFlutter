/// Domain models for the Recorder feature

/// Status of the recording process
enum RecordingStatus {
  idle,
  recording,
  stopped,
  failed,
}

/// Result of a recording operation
class RecordingResult {
  final String? audioPath;
  final String? text;
  final Duration duration;
  final RecordingStatus status;
  final String? errorMessage;

  const RecordingResult({
    this.audioPath,
    this.text,
    required this.duration,
    required this.status,
    this.errorMessage,
  });

  bool get isSuccess => status == RecordingStatus.stopped && audioPath != null;
  bool get isFailed => status == RecordingStatus.failed;
  bool get isRecording => status == RecordingStatus.recording;

  RecordingResult copyWith({
    String? audioPath,
    String? text,
    Duration? duration,
    RecordingStatus? status,
    String? errorMessage,
  }) {
    return RecordingResult(
      audioPath: audioPath ?? this.audioPath,
      text: text ?? this.text,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Configuration for audio recording
class RecordingConfig {
  final int minDurationSeconds;
  final int maxDurationSeconds;
  final String audioFormat;
  final int sampleRate;
  final int channels;

  const RecordingConfig({
    this.minDurationSeconds = 2,
    this.maxDurationSeconds = 15,
    this.audioFormat = 'wav',
    this.sampleRate = 44100,
    this.channels = 1,
  });

  bool isValidDuration(Duration duration) {
    final durationSeconds = duration.inSeconds;
    return durationSeconds >= minDurationSeconds &&
        durationSeconds <= maxDurationSeconds;
  }
}

/// Manual fallback input
class ManualFallbackInput {
  final String text;
  final DateTime timestamp;

  const ManualFallbackInput({
    required this.text,
    required this.timestamp,
  });
}
