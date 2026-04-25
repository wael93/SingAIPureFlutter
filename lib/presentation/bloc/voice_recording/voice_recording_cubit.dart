// TODO: Implement voice recording cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_recording_state.dart';

class VoiceRecordingCubit extends Cubit<VoiceRecordingState> {
  VoiceRecordingCubit() : super(const VoiceRecordingState.idle());
  
  // Placeholder for voice recording cubit methods
}

@freezed
class VoiceRecordingState with _$VoiceRecordingState {
  const factory VoiceRecordingState.idle() = _Idle;
  const factory VoiceRecordingState.recording() = _Recording;
  const factory VoiceRecordingState.completed({required String audioPath}) = _Completed;
  const factory VoiceRecordingState.error(String message) = _Error;
}
