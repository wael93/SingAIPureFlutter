part of 'avatar_player_cubit.dart';

@freezed
class AvatarPlayerState with _$AvatarPlayerState {
  const factory AvatarPlayerState.idle() = _Idle;
  const factory AvatarPlayerState.loading() = _Loading;
  const factory AvatarPlayerState.playing({
    required int currentIndex,
    required int totalCount,
    required double progress,
  }) = _Playing;
  const factory AvatarPlayerState.paused() = _Paused;
  const factory AvatarPlayerState.completed() = _Completed;
  const factory AvatarPlayerState.error(String message) = _Error;
}
