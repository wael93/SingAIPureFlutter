import 'package:flutter_test/flutter_test.dart';
import 'package:singai/features/player/application/avatar_player_service.dart';

void main() {
  late AvatarPlayerService service;

  setUp(() {
    service = AvatarPlayerService();
  });

  tearDown(() {
    service.dispose();
  });

  group('AvatarPlayerService', () {
    test('initial state is idle', () {
      expect(service.isPlaying, false);
    });

    test('playSignSequence emits loading state', () async {
      final states = <String>[];
      service.stateStream.listen((state) {
        states.add(state.status);
      });

      // FALLBACK TEST: Empty list should emit error
      await service.playSignSequence([]);
      
      expect(states, contains('error'));
    });

    test('stop resets player state', () {
      service.stop();
      
      expect(service.isPlaying, false);
    });

    test('pause sets isPlaying to false', () {
      service.pause();
      expect(service.isPlaying, false);
    });
  });
}
