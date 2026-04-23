import 'package:hive/hive.dart';

part 'sign_mapping_model.g.dart';

/// Sign mapping model for Hive storage
@HiveType(typeId: 2)
class SignMappingModel extends HiveObject {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final String signUrl;

  @HiveField(2)
  final String variant; // ASL, BSL, ArSL

  @HiveField(3)
  final String category;

  @HiveField(4)
  final int priority;

  @HiveField(5)
  final DateTime lastUsed;

  SignMappingModel({
    required this.word,
    required this.signUrl,
    required this.variant,
    required this.category,
    this.priority = 0,
    required this.lastUsed,
  });

  Map<String, dynamic> toJson() => {
    'word': word,
    'signUrl': signUrl,
    'variant': variant,
    'category': category,
    'priority': priority,
    'lastUsed': lastUsed.toIso8601String(),
  };

  factory SignMappingModel.fromJson(Map<String, dynamic> json) {
    return SignMappingModel(
      word: json['word'] as String,
      signUrl: json['signUrl'] as String,
      variant: json['variant'] as String,
      category: json['category'] as String,
      priority: json['priority'] as int? ?? 0,
      lastUsed: DateTime.parse(json['lastUsed'] as String),
    );
  }
}
