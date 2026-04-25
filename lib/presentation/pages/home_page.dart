import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/player/application/avatar_player_service.dart';
import '../../features/player/presentation/widgets/avatar_player_widget.dart';
import '../../features/export/application/export_service.dart';
import '../../features/export/presentation/bloc/export_cubit.dart';

/// NGO-focused home page
/// MVP SCOPE LOCK: 3 elements only - input, player, export
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  final _playerService = AvatarPlayerService();
  final _exportService = ExportService();
  List<String> _currentSignUrls = [];
  String _currentText = '';

  @override
  void dispose() {
    _textController.dispose();
    _playerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SingAI - ترجمة لغة الإشارة'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6200EE),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. INPUT SECTION
              _buildInputSection(),
              const SizedBox(height: 24),
              
              // 2. PLAYER SECTION
              Expanded(
                child: _buildPlayerSection(),
              ),
              const SizedBox(height: 24),
              
              // 3. EXPORT SECTION
              _buildExportSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'اكتب النص هنا...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
              maxLines: 3,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _handleTranslate,
              icon: const Icon(Icons.translate),
              label: const Text('ترجم إلى لغة الإشارة'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: const Color(0xFF6200EE),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AvatarPlayerWidget(playerService: _playerService),
      ),
    );
  }

  Widget _buildExportSection() {
    return BlocProvider(
      create: (_) => ExportCubit(_exportService),
      child: BlocBuilder<ExportCubit, ExportState>(
        builder: (context, state) {
          return state.when(
            idle: () => _buildExportButton(context),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (path, size) => _buildExportButton(context),
            error: (msg) => Column(
              children: [
                Text('خطأ: $msg', style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                _buildExportButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExportButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _currentSignUrls.isEmpty ? null : () => _handleExport(context),
      icon: const Icon(Icons.share),
      label: const Text('مشاركة الترجمة'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _handleTranslate() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      // FALLBACK: Show error state
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('النص فارغ')),
      );
      return;
    }

    // MVP SCOPE LOCK: Mock sign URLs for MVP with cache-first fallback
    // TODO: Replace with actual sign mapping service
    _currentText = text;
    
    // FALLBACK: Check cache first, then fallback to mock
    final cachedSigns = _getCachedSigns(text);
    if (cachedSigns != null && cachedSigns.isNotEmpty) {
      _currentSignUrls = cachedSigns;
    } else {
      _currentSignUrls = [
        'assets/signs/hello.mp4',
        'assets/signs/world.mp4',
      ];
    }

    _playerService.playSignSequence(_currentSignUrls);
  }

  void _handleExport(BuildContext context) {
    context.read<ExportCubit>().exportAndShare(
      videoUrls: _currentSignUrls,
      inputText: _currentText,
    );
  }

  // FALLBACK: Simple cache lookup
  List<String>? _getCachedSigns(String text) {
    // TODO: Implement actual cache lookup
    return null;
  }
}
