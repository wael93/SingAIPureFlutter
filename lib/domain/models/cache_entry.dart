import 'package:hive/hive.dart';

part 'cache_entry.g.dart';

/// Cache entry model for Hive storage
/// Run: flutter pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 0)
class CacheEntry extends HiveObject {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String value;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final DateTime? expiresAt;

  @HiveField(4)
  final int accessCount;

  @HiveField(5)
  final DateTime lastAccessedAt;

  CacheEntry({
    required this.key,
    required this.value,
    required this.createdAt,
    this.expiresAt,
    this.accessCount = 0,
    required this.lastAccessedAt,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  CacheEntry copyWith({
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? expiresAt,
    int? accessCount,
    DateTime? lastAccessedAt,
  }) {
    return CacheEntry(
      key: key ?? this.key,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      accessCount: accessCount ?? this.accessCount,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
    );
  }
}
