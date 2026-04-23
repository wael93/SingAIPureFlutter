import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../application/avatar_player_service.dart';
import '../bloc/avatar_player_cubit.dart';

class AvatarPlayerWidget extends StatelessWidget {
  final AvatarPlayerService playerService;

  const AvatarPlayerWidget({super.key, required this.playerService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AvatarPlayerCubit(playerService),
      child: BlocBuilder<AvatarPlayerCubit, AvatarPlayerState>(
        builder: (context, state) {
          return state.when(
            idle: () => _buildPlaceholder('جاهز للتشغيل'),
            loading: () => _buildLoading(),
            playing: (index, total, progress) => _buildPlayer(progress, index, total),
            paused: () => _buildPlaceholder('متوقف مؤقتاً'),
            completed: () => _buildPlaceholder('اكتمل التشغيل'),
            error: (message) => _buildError(message),
          );
        },
      ),
    );
  }

  Widget _buildPlayer(double progress, int index, int total) {
    // FALLBACK: Show placeholder if controller not ready
    if (playerService.controller == null || !playerService.controller!.value.isInitialized) {
      return _buildLoading();
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: playerService.controller!.value.aspectRatio,
          child: VideoPlayer(playerService.controller!),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 4),
        Text('${index + 1} / $total', style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('جاري التحميل...'),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sign_language, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('خطأ: $message', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
