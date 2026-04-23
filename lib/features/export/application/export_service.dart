import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';

/// Export service for sharing sign language translations
/// MVP SCOPE LOCK: Direct share only, no complex video merge
class ExportService {
  /// Export and share translation
  /// FALLBACK: If merge fails, share direct links
  Future<ExportResult> exportAndShare({
    required List<String> videoUrls,
    required String inputText,
    String format = 'mp4',
  }) async {
    try {
      // MVP SCOPE LOCK: Skip merge, share cache links directly
      // FALLBACK: Low-end devices can't handle video processing
      
      final message = _buildNGOMessage(inputText, videoUrls.length);
      
      if (videoUrls.isEmpty) {
        return ExportResult.error('No videos to share');
      }

      // Share first video or list of videos
      if (videoUrls.length == 1) {
        await _shareFile(videoUrls.first, message);
      } else {
        await _shareText(message + '\n\nVideos: ${videoUrls.length}');
      }

      return ExportResult.success(
        filePath: videoUrls.first,
        fileSize: 0,
        duration: videoUrls.length,
      );
      
    } catch (e) {
      debugPrint('Export error: $e');
      return ExportResult.error(e.toString());
    }
  }

  /// Build NGO-ready share message
  String _buildNGOMessage(String text, int signCount) {
    return '''
🤟 ترجمة لغة الإشارة - SingAI

النص: $text
عدد الإشارات: $signCount

تم إنشاؤه بواسطة SingAI - تطبيق مجاني لخدمة مجتمع الصم
''';
  }

  Future<void> _shareFile(String filePath, String message) async {
    if (filePath.startsWith('http')) {
      // FALLBACK: Share URL if file is remote
      await Share.share('$message\n\n$filePath');
    } else {
      // Share local file
      await Share.shareXFiles(
        [XFile(filePath)],
        text: message,
      );
    }
  }

  Future<void> _shareText(String text) async {
    await Share.share(text);
  }

  /// Get export directory
  Future<Directory> getExportDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${appDir.path}/exports');
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir;
  }
}

class ExportResult {
  final bool success;
  final String? filePath;
  final int? fileSize;
  final int? duration;
  final String? error;

  ExportResult._({
    required this.success,
    this.filePath,
    this.fileSize,
    this.duration,
    this.error,
  });

  factory ExportResult.success({
    required String filePath,
    required int fileSize,
    required int duration,
  }) => ExportResult._(
    success: true,
    filePath: filePath,
    fileSize: fileSize,
    duration: duration,
  );

  factory ExportResult.error(String message) => ExportResult._(
    success: false,
    error: message,
  );
}
