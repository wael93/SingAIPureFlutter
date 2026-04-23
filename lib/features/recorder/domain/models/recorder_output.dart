/// Output model for recorder feature
import '../models/recorder_models.dart';

/// Combined output from recorder including audio and text
class RecorderOutput {
  final RecordingResult recordingResult;
  final String? manualText;
  final bool isManualFallback;

  const RecorderOutput({
    required this.recordingResult,
    this.manualText,
    this.isManualFallback = false,
  });

  /// Get the final text output (from audio or manual)
  String get text {
    if (isManualFallback && manualText != null) {
      return manualText!;
    }
    if (recordingResult.text != null) {
      return recordingResult.text!;
    }
    return '';
  }

  /// Get the audio path if available
  String? get audioPath {
    if (isManualFallback) {
      return null;
    }
    return recordingResult.audioPath;
  }

  /// Check if output is valid
  bool get isValid {
    if (isManualFallback) {
      return manualText != null && manualText!.isNotEmpty;
    }
    return recordingResult.isSuccess;
  }

  RecorderOutput copyWith({
    RecordingResult? recordingResult,
    String? manualText,
    bool? isManualFallback,
  }) {
    return RecorderOutput(
      recordingResult: recordingResult ?? this.recordingResult,
      manualText: manualText ?? this.manualText,
      isManualFallback: isManualFallback ?? this.isManualFallback,
    );
  }
}
