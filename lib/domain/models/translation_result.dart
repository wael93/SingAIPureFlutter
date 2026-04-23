import 'package:hive/hive.dart';

part 'translation_result.g.dart';

/// Translation result model for Hive storage
@HiveType(typeId: 1)
class TranslationResult extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String inputText;

  @HiveField(2)
  final String normalizedText;

  @HiveField(3)
  final List<String> signUrls;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String language;

  @HiveField(6)
  final int durationMs;

  TranslationResult({
    required this.id,
    required this.inputText,
    required this.normalizedText,
    required this.signUrls,
    required this.createdAt,
    required this.language,
    required this.durationMs,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'inputText': inputText,
    'normalizedText': normalizedText,
    'signUrls': signUrls,
    'createdAt': createdAt.toIso8601String(),
    'language': language,
    'durationMs': durationMs,
  };

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      id: json['id'] as String,
      inputText: json['inputText'] as String,
      normalizedText: json['normalizedText'] as String,
      signUrls: (json['signUrls'] as List).cast<String>(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      language: json['language'] as String,
      durationMs: json['durationMs'] as int,
    );
  }
}
