/// Domain use case for validating recordings
import '../models/recorder_models.dart';
import '../../validators/recorder_validator.dart';

/// Use case for validating recording results
class ValidateRecording {
  final RecordingConfig _config;

  const ValidateRecording([this._config = const RecordingConfig()]);

  /// Validates the recording result against configuration
  /// Validates: Requirements 2.3 - Duration validation (2-15s)
  /// Returns: bool indicating if the recording is valid
  bool validate(RecordingResult result) {
    if (result.isFailed) {
      return false;
    }

    if (result.audioPath == null) {
      return false;
    }

    return RecorderValidator.validateDuration(result.duration, _config);
  }

  /// Validates manual fallback text
  /// Returns: bool indicating if the text is valid
  bool validateManualText(String text) {
    return RecorderValidator.validateManualText(text, 500);
  }
}
