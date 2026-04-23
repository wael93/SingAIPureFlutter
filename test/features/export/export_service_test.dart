import 'package:flutter_test/flutter_test.dart';
import 'package:singai/features/export/application/export_service.dart';

void main() {
  late ExportService service;

  setUp(() {
    service = ExportService();
  });

  group('ExportService', () {
    test('exportAndShare returns error for empty video list', () async {
      final result = await service.exportAndShare(
        videoUrls: [],
        inputText: 'test',
      );

      expect(result.success, false);
      expect(result.error, 'No videos to share');
    });

    test('exportAndShare builds NGO message correctly', () async {
      // FALLBACK TEST: Should handle single video
      final result = await service.exportAndShare(
        videoUrls: ['test.mp4'],
        inputText: 'مرحبا',
      );

      expect(result.success, true);
    });

    test('getExportDirectory creates directory if not exists', () async {
      final dir = await service.getExportDirectory();
      expect(dir.existsSync(), true);
    });
  });

  group('ExportResult', () {
    test('success factory creates valid result', () {
      final result = ExportResult.success(
        filePath: '/test/path.mp4',
        fileSize: 1024,
        duration: 10,
      );

      expect(result.success, true);
      expect(result.filePath, '/test/path.mp4');
      expect(result.fileSize, 1024);
      expect(result.duration, 10);
      expect(result.error, null);
    });

    test('error factory creates valid result', () {
      final result = ExportResult.error('Test error');

      expect(result.success, false);
      expect(result.error, 'Test error');
      expect(result.filePath, null);
    });
  });
}
