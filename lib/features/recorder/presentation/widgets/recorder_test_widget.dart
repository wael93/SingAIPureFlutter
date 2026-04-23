/// Test widget for recorder feature
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recorder_cubit.dart';
import '../bloc/recorder_state.dart';
import 'recorder_widget.dart';

/// Test widget wrapper for recorder
class RecorderTestWidget extends StatelessWidget {
  final RecorderCubit cubit;

  const RecorderTestWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const RecorderContent(),
    );
  }
}

/// Test helper to verify recorder state
void verifyRecorderState(
  WidgetTester tester,
  RecordingStatus expectedStatus,
  String? expectedErrorMessage,
) async {
  final state = tester.widget<RecorderState>(
    find.byType(RecorderContent),
  );

  expect(state.status, expectedStatus);
  if (expectedErrorMessage != null) {
    expect(state.errorMessage, expectedErrorMessage);
  }
}
