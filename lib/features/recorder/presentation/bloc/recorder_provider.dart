/// Riverpod provider for recorder state
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/recorder_cubit.dart';
import '../../data/services/audio_recorder_service.dart';
import '../../domain/use_cases/record_audio.dart';
import '../../domain/use_cases/validate_recording.dart';

/// Provider for RecorderCubit
/// Validates: Requirements 2.5 - Expose text/audio output via Riverpod
final recorderCubitProvider = Provider<RecorderCubit>((ref) {
  final service = ref.watch(audioRecorderServiceProvider);
  final recordAudio = RecordAudio(service);
  final validateRecording = ValidateRecording();

  return RecorderCubit(
    recordAudio: recordAudio,
    validateRecording: validateRecording,
  );
});

/// Provider for AudioRecorderService
final audioRecorderServiceProvider = Provider<AudioRecorderService>((ref) {
  return AudioRecorderService();
});

/// Provider for RecordingResult
final recordingResultProvider = Provider<RecordingResult?>((ref) {
  final cubit = ref.watch(recorderCubitProvider);
  return cubit.state.recordingResult;
});

/// Provider for manual text
final manualTextProvider = Provider<String?>((ref) {
  final cubit = ref.watch(recorderCubitProvider);
  return cubit.state.manualText;
});

/// Provider for recorder output
final recorderOutputProvider = Provider<RecorderOutput?>((ref) {
  final cubit = ref.watch(recorderCubitProvider);
  return cubit.getOutput();
});

/// Provider for recording status
final recordingStatusProvider = Provider<RecordingStatus>((ref) {
  final cubit = ref.watch(recorderCubitProvider);
  return cubit.state.status;
});
