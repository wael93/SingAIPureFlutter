/// Unit test for recorder validator
/// Validates: Requirements 2.3 - Duration validation (2-15s)
import 'package:test/test.dart';

import 'recorder_validator.dart';
import '../models/recorder_models.dart';

void main() {
  group('RecorderValidator', () {
    late RecorderValidator validator;
    late RecordingConfig config;

    setUp(() {
      validator = RecorderValidator();
      config = RecordingConfig();
    });

    group('validateDuration', () {
      test('returns true for valid duration (2 seconds)', () {
        final duration = Duration(seconds: 2);
        expect(validator.validateDuration(duration, config), true);
      });

      test('returns true for valid duration (15 seconds)', () {
        final duration = Duration(seconds: 15);
        expect(validator.validateDuration(duration, config), true);
      });

      test('returns true for valid duration (8 seconds)', () {
        final duration = Duration(seconds: 8);
        expect(validator.validateDuration(duration, config), true);
      });

      test('returns false for duration less than 2 seconds', () {
        final duration = Duration(seconds: 1);
        expect(validator.validateDuration(duration, config), false);
      });

      test('returns false for duration greater than 15 seconds', () {
        final duration = Duration(seconds: 16);
        expect(validator.validateDuration(duration, config), false);
      });

      test('returns false for zero duration', () {
        final duration = Duration.zero;
        expect(validator.validateDuration(duration, config), false);
      });
    });

    group('validateManualText', () {
      test('returns true for valid text', () {
        expect(validator.validateManualText('Hello world', 500), true);
      });

      test('returns true for text with spaces', () {
        expect(validator.validateManualText('  Hello world  ', 500), true);
      });

      test('returns false for empty text', () {
        expect(validator.validateManualText('', 500), false);
      });

      test('returns false for whitespace-only text', () {
        expect(validator.validateManualText('   ', 500), false);
      });

      test('returns true for text at max length', () {
        final text = 'x' * 500;
        expect(validator.validateManualText(text, 500), true);
      });

      test('returns false for text exceeding max length', () {
        final text = 'x' * 501;
        expect(validator.validateManualText(text, 500), false);
      });
    });
  });
}
