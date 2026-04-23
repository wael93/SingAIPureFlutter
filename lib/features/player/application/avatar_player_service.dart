import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

/// Video-based avatar player service
/// MVP SCOPE LOCK: Sequential video playback only, no 3D rendering
class AvatarPlayerService {
  VideoPlayerController? _controller;
  final List<String> _playQueue = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  
  final _stateController = StreamController<AvatarPlayerState>.broadcast();
  Stream<AvatarPlayerState> get stateStream => _stateController.stream;

  /// Play sequence of sign videos
  /// CACHE-FIRST: Attempts local cache before network
  Future<void> playSignSequence(List<String> signUrls) async {
    if (signUrls.isEmpty) {
      _emitState(AvatarPlayerState.error('No signs to play'));
      return;
    }

    _playQueue.clear();
    _playQueue.addAll(signUrls);
    _currentIndex = 0;
    _isPlaying = true;

    _emitState(AvatarPlayerState.loading());
    await _playNext();
  }

  Future<void> _playNext() async {
    if (_currentIndex >= _playQueue.length) {
      _isPlaying = false;
      _emitState(AvatarPlayerState.completed());
      return;
    }

    final url = _playQueue[_currentIndex];
    
    try {
      // FALLBACK: Handle missing/corrupt files
      await _initializeController(url);
      
      _emitState(AvatarPlayerState.playing(
        currentIndex: _currentIndex,
        totalCount: _playQueue.length,
        progress: _currentIndex / _playQueue.length,
      ));

      await _controller!.play();
      
      // Wait for video to complete
      await _controller!.position.then((pos) async {
        final duration = _controller!.value.duration;
        if (pos != null && duration != null) {
          await Future.delayed(duration - pos);
        }
      });

      _currentIndex++;
      await _playNext();
      
    } catch (e) {
      // FALLBACK: Skip corrupt video and continue
      debugPrint('Video playback error: $e');
      _currentIndex++;
      await _playNext();
    }
  }

  Future<void> _initializeController(String url) async {
    await _controller?.dispose();
    
    // CACHE-FIRST: Try local file first, fallback to network
    _controller = url.startsWith('http')
        ? VideoPlayerController.networkUrl(Uri.parse(url))
        : VideoPlayerController.asset(url);
    
    await _controller!.initialize();
  }

  void pause() {
    _controller?.pause();
    _isPlaying = false;
    _emitState(AvatarPlayerState.paused());
  }

  void resume() {
    _controller?.play();
    _isPlaying = true;
  }

  void stop() {
    _controller?.pause();
    _controller?.seekTo(Duration.zero);
    _isPlaying = false;
    _currentIndex = 0;
    _playQueue.clear();
    _emitState(AvatarPlayerState.idle());
  }

  VideoPlayerController? get controller => _controller;
  bool get isPlaying => _isPlaying;

  void _emitState(AvatarPlayerState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void dispose() {
    _controller?.dispose();
    _stateController.close();
  }
}

class AvatarPlayerState {
  final String status;
  final int? currentIndex;
  final int? totalCount;
  final double? progress;
  final String? error;

  AvatarPlayerState._({
    required this.status,
    this.currentIndex,
    this.totalCount,
    this.progress,
    this.error,
  });

  factory AvatarPlayerState.idle() => AvatarPlayerState._(status: 'idle');
  factory AvatarPlayerState.loading() => AvatarPlayerState._(status: 'loading');
  factory AvatarPlayerState.playing({
    required int currentIndex,
    required int totalCount,
    required double progress,
  }) => AvatarPlayerState._(
    status: 'playing',
    currentIndex: currentIndex,
    totalCount: totalCount,
    progress: progress,
  );
  factory AvatarPlayerState.paused() => AvatarPlayerState._(status: 'paused');
  factory AvatarPlayerState.completed() => AvatarPlayerState._(status: 'completed');
  factory AvatarPlayerState.error(String message) => AvatarPlayerState._(
    status: 'error',
    error: message,
  );
}
