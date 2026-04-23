import 'package:hive/hive.dart';
import 'dart:convert';

/// Impact report generator for NGO reporting
/// Reads usage stats from Hive and generates formatted reports
class ImpactReportGenerator {
  static const String _statsBoxName = 'usage_stats';

  /// Generate impact report as formatted string
  Future<String> generateReport() async {
    final stats = await _getStats();
    
    return '''
📊 تقرير الأثر - SingAI

🎯 إحصائيات الاستخدام:
- إجمالي الترجمات: ${stats['total_requests'] ?? 0}
- نسبة استخدام الذاكرة المؤقتة: ${stats['cache_hit_rate'] ?? 0}%
- دقائق الوصول المقدرة: ${stats['estimated_accessibility_minutes'] ?? 0}

📅 الفترة: ${stats['period_start'] ?? 'N/A'} - ${stats['period_end'] ?? DateTime.now().toString().split(' ')[0]}

💡 الأثر:
- عدد المستفيدين المقدر: ${(stats['total_requests'] ?? 0) * 2}
- توفير في التكاليف: مجاني 100%
- معالجة محلية: بدون إنترنت

🤝 تم إنشاؤه بواسطة SingAI
تطبيق مفتوح المصدر لخدمة مجتمع الصم
''';
  }

  /// Generate impact report as JSON
  Future<Map<String, dynamic>> generateJsonReport() async {
    final stats = await _getStats();
    
    return {
      'report_date': DateTime.now().toIso8601String(),
      'metrics': {
        'total_translations': stats['total_requests'] ?? 0,
        'cache_hit_rate': stats['cache_hit_rate'] ?? 0,
        'accessibility_minutes': stats['estimated_accessibility_minutes'] ?? 0,
        'estimated_beneficiaries': (stats['total_requests'] ?? 0) * 2,
      },
      'period': {
        'start': stats['period_start'] ?? 'N/A',
        'end': stats['period_end'] ?? DateTime.now().toIso8601String(),
      },
      'impact': {
        'cost_savings': 'Free 100%',
        'offline_capable': true,
        'open_source': true,
      },
    };
  }

  /// Increment translation counter
  Future<void> recordTranslation() async {
    final box = await Hive.openBox(_statsBoxName);
    final current = box.get('total_requests', defaultValue: 0) as int;
    await box.put('total_requests', current + 1);
    
    // Update period
    if (!box.containsKey('period_start')) {
      await box.put('period_start', DateTime.now().toIso8601String());
    }
    await box.put('period_end', DateTime.now().toIso8601String());
  }

  /// Record cache hit
  Future<void> recordCacheHit(bool isHit) async {
    final box = await Hive.openBox(_statsBoxName);
    final hits = box.get('cache_hits', defaultValue: 0) as int;
    final total = box.get('cache_total', defaultValue: 0) as int;
    
    await box.put('cache_hits', isHit ? hits + 1 : hits);
    await box.put('cache_total', total + 1);
    
    // Calculate hit rate
    final hitRate = total > 0 ? ((hits / total) * 100).round() : 0;
    await box.put('cache_hit_rate', hitRate);
  }

  /// Add accessibility minutes
  Future<void> addAccessibilityMinutes(int minutes) async {
    final box = await Hive.openBox(_statsBoxName);
    final current = box.get('estimated_accessibility_minutes', defaultValue: 0) as int;
    await box.put('estimated_accessibility_minutes', current + minutes);
  }

  /// Get all stats
  Future<Map<String, dynamic>> _getStats() async {
    final box = await Hive.openBox(_statsBoxName);
    return {
      'total_requests': box.get('total_requests', defaultValue: 0),
      'cache_hit_rate': box.get('cache_hit_rate', defaultValue: 0),
      'estimated_accessibility_minutes': box.get('estimated_accessibility_minutes', defaultValue: 0),
      'period_start': box.get('period_start'),
      'period_end': box.get('period_end'),
    };
  }

  /// Reset stats (for testing)
  Future<void> resetStats() async {
    final box = await Hive.openBox(_statsBoxName);
    await box.clear();
  }
}
