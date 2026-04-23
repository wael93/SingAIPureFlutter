import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singai/features/player/application/avatar_player_service.dart';
import 'package:singai/features/player/presentation/widgets/avatar_player_widget.dart';

void main() {
  late AvatarPlayerService service;

  setUp(() {
    service = AvatarPlayerService();
  });

  tearDown(() {
    service.dispose();
  });

  group('AvatarPlayerWidget', () {
    testWidgets('displays idle placeholder initially', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarPlayerWidget(playerService: service),
          ),
        ),
      );

      expect(find.text('جاهز للتشغيل'), findsOneWidget);
      expect(find.byIcon(Icons.sign_language), findsOneWidget);
    });

    testWidgets('displays loading indicator when loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarPlayerWidget(playerService: service),
          ),
        ),
      );

      // Trigger loading state
      service.playSignSequence(['test.mp4']);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('جاري التحميل...'), findsOneWidget);
    });

    testWidgets('displays error message on error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarPlayerWidget(playerService: service),
          ),
        ),
      );

      // FALLBACK TEST: Empty list triggers error
      service.playSignSequence([]);
      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
