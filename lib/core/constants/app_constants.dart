/// Application-wide constants
class AppConstants {
  // Storage paths
  static const String modelsPath = 'models';
  static const String cachePath = 'cache';
  static const String assetsPath = 'assets';
  static const String avatarPath = 'avatar';
  
  // Model types
  static const String sttModelType = 'stt';
  static const String normalizationModelType = 'normalization';
  static const String signMappingModelType = 'sign_mapping';
  
  // File extensions
  static const String tfliteExtension = '.tflite';
  static const String jsonExtension = '.json';
  static const String dbExtension = '.db';
  static const String videoExtension = '.mp4';
  static const String imageExtension = '.svg';
  
  // Cache keys
  static const String translationCachePrefix = 'translation_';
  static const String normalizationCachePrefix = 'normalization_';
  static const String signCachePrefix = 'sign_';
  
  // Cache size limits
  static const int maxCacheSizeMB = 500;
  static const int maxCacheSizeBytes = maxCacheSizeMB * 1024 * 1024;
  
  // Performance targets (in milliseconds)
  static const int initialLoadTargetMs = 2000;
  static const int cachedContentTargetMs = 3000;
  static const int newContentTargetMs = 8000;
  static const int avatarRenderTargetMs = 5000;
  
  // Default settings values
  static const bool defaultEnableAnalytics = false;
  static const bool defaultEnableCache = true;
  static const bool defaultEnableHighContrast = false;
  static const bool defaultEnableScreenReader = false;
  static const String defaultLanguage = 'en';
  static const String defaultSignVariant = 'ASL';
  static const int defaultCacheRetentionDays = 30;
  static const double defaultConfidenceThreshold = 0.7;
  
  // Text processing limits
  static const int maxTextLength = 500;
  static const int minRecordingDurationSeconds = 1;
  static const int maxRecordingDurationSeconds = 300;
  
  // Model configuration
  static const int minStorageSpaceMB = 500;
  static const int downloadRetryCount = 3;
  static const int downloadTimeoutSeconds = 300;
  
  // Usage monitoring
  static const int monthlyUsageLimit = 1000;
  static const double usageWarningThreshold = 0.8;
  static const double usageRestrictionThreshold = 0.95;
  
  // Export configuration
  static const int linkExpirationDays = 30;
  
  // Avatar configuration
  static const double defaultPlaybackSpeed = 1.0;
  static const double minPlaybackSpeed = 0.5;
  static const double maxPlaybackSpeed = 2.0;
}
