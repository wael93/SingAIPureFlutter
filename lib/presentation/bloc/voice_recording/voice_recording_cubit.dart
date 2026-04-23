// TODO: Implement voice recording cubit
import 'package:flutter_bloc/flutter_bloc.dart';

class VoiceRecordingCubit extends Cubit<VoiceRecordingState> {
  VoiceRecordingCubit() : super(VoiceRecordingInitial());
  
  // Placeholder for voice recording cubit methods
}

class VoiceRecordingState {}

class VoiceRecordingInitial extends VoiceRecordingState {}

class VoiceRecordingInProgress extends VoiceRecordingState {}

class VoiceRecordingComplete extends VoiceRecordingState {
  final String audioPath;
  
  VoiceRecordingComplete(this.audioPath);
}

class VoiceRecordingFailure extends VoiceRecordingState {
  final String message;
  
  VoiceRecordingFailure(this.message);
}
