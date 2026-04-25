part of 'voice_recording_cubit.dart';

@freezed
class VoiceRecordingState with _$VoiceRecordingState {
  const factory VoiceRecordingState.idle() = _Idle;
  const factory VoiceRecordingState.recording() = _Recording;
  const factory VoiceRecordingState.completed({required String audioPath}) = _Completed;
  const factory VoiceRecordingState.error(String message) = _Error;
}
