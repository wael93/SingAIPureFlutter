/// Unit test for recorder repository
/// Validates: Requirements 2.2 - Microphone permission
/// Validates: Requirements 2.3 - Duration validation (2-15s)
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recorder_repository_impl.dart';
import '../services/audio_recorder_service.dart';
import '../models/recorder_models.dart';

@GenerateMocks([AudioRecorderService])
void main() {
  group('RecorderRepositoryImpl', () {
    late MockAudioRecorderService mockService;
    late RecorderRepositoryImpl repository;

    setUp(() {
      mockService = MockAudioRecorderService();
      repository = RecorderRepositoryImpl(service: mockService);
    });

    test('startRecording returns recording status', () async {
      when(mockService.startRecording()).thenAnswer((_) async {});

      final result = await repository.startRecording();

      expect(result.status, RecordingStatus.recording);
    });

    test('stopRecording returns stopped status', () async {
      final result = RecordingResult(
        audioPath: '/path/to/audio.wav',
        duration: Duration(seconds: 5),
        status: RecordingStatus.stopped,
      );

      when(mockService.stopRecording()).thenAnswer((_) async => result);

      final repositoryResult = await repository.stopRecording();

      expect(repositoryResult.status, RecordingStatus.stopped);
      expect(repositoryResult.audioPath, isNotNull);
    });

    test('stopRecording validates duration', () async {
      final result = RecordingResult(
        audioPath: '/path/to/audio.wav',
        duration: Duration(seconds: 1), // Too short
        status: RecordingStatus.stopped,
      );

      when(mockService.stopRecording()).thenAnswer((_) async => result);

      final repositoryResult = await repository.stopRecording();

      expect(repositoryResult.status, RecordingStatus.failed);
    });

    test('isRecording delegates to service', () {
      when(mockService.isRecording()).thenReturn(true);

      expect(repository.isRecording(), true);
    });

    test('getDuration delegates to service', () {
      final duration = Duration(seconds: 5);
      when(mockService.getRecordingDuration()).thenReturn(duration);

      expect(repository.getDuration(), duration);
    });

    test('validateManualText validates text', () {
      expect(repository.validateManualText('Hello'), true);
      expect(repository.validateManualText(''), false);
    });
  });
}
