/// Presentation widget for recorder feature
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recorder_cubit.dart';
import '../bloc/recorder_state.dart';
import '../../../domain/models/recorder_models.dart';

/// Widget for recording audio with manual fallback
/// Validates: Requirements 2.1 - UI with record button, waveform, stop button
/// Validates: Requirements 2.4 - Manual text input field
/// Validates: Requirements 2.5 - Clear fallback label
class RecorderWidget extends StatelessWidget {
  const RecorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecorderCubit(),
      child: const RecorderContent(),
    );
  }
}

/// Content widget for recorder
class RecorderContent extends StatelessWidget {
  const RecorderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderCubit, RecorderState>(
      builder: (context, state) {
        return Column(
          children: [
            // Waveform/level indicator
            _buildWaveformIndicator(context, state),

            const SizedBox(height: 16),

            // Status message
            _buildStatusMessage(context, state),

            const SizedBox(height: 16),

            // Recording controls
            _buildRecordingControls(context, state),

            const SizedBox(height: 24),

            // Manual fallback section
            _buildManualFallback(context, state),
          ],
        );
      },
    );
  }

  /// Build waveform indicator
  Widget _buildWaveformIndicator(BuildContext context, RecorderState state) {
    if (state.isRecording) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(20, (index) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 40 * (0.5 + 0.5 * (index % 5) / 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      );
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Ready to record',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  /// Build status message
  Widget _buildStatusMessage(BuildContext context, RecorderState state) {
    String message;
    Color color;

    switch (state.status) {
      case RecordingStatus.idle:
        message = 'Tap record to start';
        color = Colors.grey;
        break;
      case RecordingStatus.recording:
        message = 'Recording...';
        color = Colors.red;
        break;
      case RecordingStatus.stopped:
        message = 'Recording complete';
        color = Colors.green;
        break;
      case RecordingStatus.failed:
        message = state.errorMessage ?? 'Recording failed';
        color = Colors.red;
        break;
    }

    return Text(
      message,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Build recording controls
  Widget _buildRecordingControls(BuildContext context, RecorderState state) {
    if (state.isRecording) {
      return ElevatedButton.icon(
        onPressed: () => context.read<RecorderCubit>().stopRecording(),
        icon: const Icon(Icons.stop),
        label: const Text('Stop'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: state.isFailed ? null : () => context.read<RecorderCubit>().startRecording(),
          icon: const Icon(Icons.mic),
          label: const Text('Record'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        if (state.recordingResult != null)
          TextButton.icon(
            onPressed: () => context.read<RecorderCubit>().clearRecording(),
            icon: const Icon(Icons.clear),
            label: const Text('Clear'),
          ),
      ],
    );
  }

  /// Build manual fallback section
  Widget _buildManualFallback(BuildContext context, RecorderState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fallback label
        Text(
          'Manual Fallback',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),

        // Text input field
        TextField(
          controller: TextEditingController(text: state.manualText),
          onChanged: (text) => context.read<RecorderCubit>().setManualText(text),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter text manually...',
            border: const OutlineInputBorder(),
            errorText: state.manualTextError,
            helperText: 'If recording fails, enter text here',
          ),
        ),
      ],
    );
  }
}
