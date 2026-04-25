import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../application/avatar_player_service.dart';

part 'avatar_player_state.dart';
part 'avatar_player_cubit.freezed.dart';

class AvatarPlayerCubit extends Cubit<AvatarPlayerState> {
  final AvatarPlayerService _playerService;

  AvatarPlayerCubit(this._playerService) : super(const AvatarPlayerState.idle()) {
    // FALLBACK: Check if stream is closed before listening
    if (!_playerService.stateStream.isClosed) {
      _playerService.stateStream.listen((serviceState) {
        if (!isClosed) {
          _mapServiceStateToBloc(serviceState);
        }
      });
    }
  }

  void _mapServiceStateToBloc(serviceState) {
    switch (serviceState.status) {
      case 'idle':
        emit(const AvatarPlayerState.idle());
        break;
      case 'loading':
        emit(const AvatarPlayerState.loading());
        break;
      case 'playing':
        emit(AvatarPlayerState.playing(
          currentIndex: serviceState.currentIndex!,
          totalCount: serviceState.totalCount!,
          progress: serviceState.progress!,
        ));
        break;
      case 'paused':
        emit(const AvatarPlayerState.paused());
        break;
      case 'completed':
        emit(const AvatarPlayerState.completed());
        break;
      case 'error':
        emit(AvatarPlayerState.error(serviceState.error!));
        break;
    }
  }

  Future<void> playSignSequence(List<String> signUrls) async {
    await _playerService.playSignSequence(signUrls);
  }

  void pause() => _playerService.pause();
  void resume() => _playerService.resume();
  void stop() => _playerService.stop();

  @override
  Future<void> close() {
    _playerService.dispose();
    return super.close();
  }
}
