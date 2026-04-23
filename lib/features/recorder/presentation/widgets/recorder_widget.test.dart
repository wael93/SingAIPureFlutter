/// Widget test for recorder feature
/// Validates: Requirements 2.1 - UI with record button, waveform, stop button
/// Validates: Requirements 2.4 - Manual text input field
/// Validates: Requirements 2.5 - Clear fallback label
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recorder_cubit.dart';
import '../bloc/recorder_state.dart';
import 'recorder_widget.dart';
import 'recorder_test_widget.dart';

void main() {
  group('RecorderWidget', () {
    testWidgets('displays idle state initially', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      // Assert
      expect(find.text('Ready to record'), findsOneWidget);
      expect(find.text('Tap record to start'), findsOneWidget);
      expect(find.text('Record'), findsOneWidget);
    });

    testWidgets('shows recording state when recording starts', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      await cubit.startRecording();

      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      // Assert
      expect(find.text('Recording...'), findsOneWidget);
      expect(find.text('Stop'), findsOneWidget);
      expect(find.byType(Container), findsNWidgets(2)); // waveform + status
    });

    testWidgets('shows stopped state when recording stops', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      await cubit.startRecording();
      await cubit.stopRecording();

      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      // Assert
      expect(find.text('Recording complete'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('shows manual fallback section', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      // Assert
      expect(find.text('Manual Fallback'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('If recording fails, enter text here'), findsOneWidget);
    });

    testWidgets('allows manual text input', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Hello world');

      // Assert
      expect(cubit.state.manualText, 'Hello world');
    });

    testWidgets('shows error for invalid manual text', (tester) async {
      // Arrange
      final cubit = RecorderCubit();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RecorderTestWidget(cubit: cubit),
        ),
      );

      final textField = find.byType(TextField);
      await tester.enterText(textField, ''); // Empty text

      // Assert
      expect(cubit.state.manualTextError, isNotNull);
    });
  });
}
