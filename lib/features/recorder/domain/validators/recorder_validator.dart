/// Domain validator for recorder functionality
import '../models/recorder_models.dart';

class RecorderValidator {
  /// Validates that the recording duration is within acceptable range
  /// Validates: Requirements 2.1 - Duration validation (2-15s)
  static bool validateDuration(Duration duration, RecordingConfig config) {
    return config.isValidDuration(duration);
  }

  /// Validates that the audio file exists and is accessible
  static bool validateAudioFile(String audioPath) {
    // In a real implementation, this would check file existence
    // For now, we assume the path is valid if not empty
    return audioPath.isNotEmpty;
  }

  /// Validates manual fallback text input
  static bool validateManualText(String text, int maxLength) {
    return text.trim().isNotEmpty && text.length <= maxLength;
  }
}
