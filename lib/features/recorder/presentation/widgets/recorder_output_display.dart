/// Widget for displaying recorder output
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recorder_cubit.dart';
import '../bloc/recorder_state.dart';

/// Widget for displaying the final recorder output
/// Validates: Requirements 2.5 - Expose text/audio output via Riverpod
class RecorderOutputDisplay extends StatelessWidget {
  const RecorderOutputDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderCubit, RecorderState>(
      builder: (context, state) {
        final output = context.read<RecorderCubit>().getOutput();

        if (output == null) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text('No output available'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Output type indicator
            Row(
              children: [
                Icon(
                  output.isManualFallback ? Icons.text_fields : Icons.audiotrack,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  output.isManualFallback ? 'Manual Input' : 'Audio Recording',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Text output
            Text(
              'Text: ${output.text}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            if (output.audioPath != null) ...[
              const SizedBox(height: 8),
              Text(
                'Audio Path: ${output.audioPath!}',
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 16),

            // Fallback indicator
            if (output.isManualFallback)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Using manual fallback due to recording issues',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
