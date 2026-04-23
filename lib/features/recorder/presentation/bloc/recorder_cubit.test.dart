/// Unit test for recorder cubit
/// Validates: Requirements 2.1 - UI for record button, waveform, stop button
/// Validates: Requirements 2.4 - Manual text input field
/// Validates: Requirements 2.5 - Expose text/audio output via Riverpod
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recorder_cubit.dart';
import '../services/audio_recorder_service.dart';
import '../models/recorder_models.dart';
import '../validators/recorder_validator.dart';
import '../use_cases/record_audio.dart';
import '../use_cases/validate_recording.dart';

@GenerateMocks([
  AudioRecorderService,
  RecordAudio,
  ValidateRecording,
  RecorderValidator,
])
void main() {
  group('RecorderCubit', () {
    late MockRecordAudio mockRecordAudio;
    late MockValidateRecording mockValidateRecording;
    late RecorderCubit cubit;

    setUp(() {
      mockRecordAudio = MockRecordAudio();
      mockValidateRecording = MockValidateRecording();
      cubit = RecorderCubit(
        recordAudio: mockRecordAudio,
        validateRecording: mockValidateRecording,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is idle', () {
      expect(cubit.state.status, RecordingStatus.idle);
      expect(cubit.state.recordingResult, isNull);
      expect(cubit.state.manualText, isNull);
    });

    test('startRecording sets status to recording', () async {
      when(mockRecordAudio.start()).thenAnswer((_) async {});

      await cubit.startRecording();

      expect(cubit.state.status, RecordingStatus.recording);
    });

    test('stopRecording sets status to stopped on success', () async {
      final result = RecordingResult(
        audioPath: '/path/to/audio.wav',
        duration: Duration(seconds: 5),
        status: RecordingStatus.stopped,
      );

      when(mockRecordAudio.stop()).thenAnswer((_) async => result);
      when(mockValidateRecording.validate(result)).thenReturn(true);

      await cubit.stopRecording();

      expect(cubit.state.status, RecordingStatus.stopped);
      expect(cubit.state.recordingResult, isNotNull);
    });

    test('stopRecording sets status to failed on validation failure', () async {
      final result = RecordingResult(
        audioPath: '/path/to/audio.wav',
        duration: Duration(seconds: 1),
        status: RecordingStatus.stopped,
        errorMessage: 'Recording too short',
      );

      when(mockRecordAudio.stop()).thenAnswer((_) async => result);
      when(mockValidateRecording.validate(result)).thenReturn(false);

      await cubit.stopRecording();

      expect(cubit.state.status, RecordingStatus.failed);
      expect(cubit.state.errorMessage, 'Recording too short');
    });

    test('setManualText sets manual text and fallback flag', () {
      when(mockValidateRecording.validateManualText(any)).thenReturn(true);

      cubit.setManualText('Hello world');

      expect(cubit.state.manualText, 'Hello world');
      expect(cubit.state.isManualFallback, true);
    });

    test('setManualText sets error for invalid text', () {
      when(mockValidateRecording.validateManualText(any)).thenReturn(false);

      cubit.setManualText('');

      expect(cubit.state.manualTextError, isNotNull);
    });

    test('clearManualText clears manual text', () {
      cubit.setManualText('Hello world');
      cubit.clearManualText();

      expect(cubit.state.manualText, isNull);
      expect(cubit.state.isManualFallback, false);
    });

    test('getOutput returns output for successful recording', () {
      final result = RecordingResult(
        audioPath: '/path/to/audio.wav',
        duration: Duration(seconds: 5),
        status: RecordingStatus.stopped,
      );

      cubit = RecorderCubit(
        recordAudio: mockRecordAudio,
        validateRecording: mockValidateRecording,
      );

      when(mockRecordAudio.stop()).thenAnswer((_) async => result);
      when(mockValidateRecording.validate(result)).thenReturn(true);

      cubit.stopRecording();

      final output = cubit.getOutput();

      expect(output, isNotNull);
      expect(output!.isManualFallback, false);
      expect(output.text, '');
    });

    test('getOutput returns output for manual fallback', () {
      when(mockValidateRecording.validateManualText(any)).thenReturn(true);

      cubit.setManualText('Hello world');

      final output = cubit.getOutput();

      expect(output, isNotNull);
      expect(output!.isManualFallback, true);
      expect(output.text, 'Hello world');
    });
  });
}
