/// Application configuration
class AppConfig {
  // App identity
  static const String appName = 'Sign Language Translator';
  static const String appVersion = '1.0.0';
  static const String appBuild = '1';
  
  // Build configuration
  static const bool isDebug = bool.fromEnvironment('dart.vm.debug', defaultValue: false);
  static const bool isRelease = bool.fromEnvironment('dart.vm.release', defaultValue: false);
  static const bool isProfile = bool.fromEnvironment('dart.vm.profile', defaultValue: false);
  
  // Feature flags
  static const bool enableAnalytics = false;
  static const bool enableCache = true;
  static const bool enableCloudSync = false;
  static const bool enableHighContrast = true;
  static const bool enableScreenReader = true;
  
  // Cache configuration
  static const int maxCacheSizeMB = 500;
  static const int cacheRetentionDays = 30;
  static const int cacheEvictionCheckIntervalMinutes = 60;
  
  // STT configuration
  static const double confidenceThreshold = 0.7;
  static const List<String> supportedLanguages = ['en', 'ar', 'es'];
  static const String defaultLanguage = 'en';
  
  // Usage monitoring
  static const int monthlyUsageLimit = 1000;
  static const double usageWarningThreshold = 0.8;
  static const double usageRestrictionThreshold = 0.95;
  
  // Performance targets (in milliseconds)
  static const int initialLoadTargetMs = 2000;
  static const int cachedContentTargetMs = 3000;
  static const int newContentTargetMs = 8000;
  static const int avatarRenderTargetMs = 5000;
  
  // Model configuration
  static const String modelsDirectory = 'models';
  static const String cacheDirectory = 'cache';
  static const String assetsDirectory = 'assets';
  static const String avatarDirectory = 'avatar';
  
  // Model storage paths
  static const String sttModelsPath = '$modelsDirectory/stt';
  static const String normalizationModelsPath = '$modelsDirectory/normalization';
  static const String signMappingModelsPath = '$modelsDirectory/sign_mapping';
  static const String avatarAssetsPath = '$assetsDirectory/avatar';
  
  // File extensions
  static const String tfliteExtension = '.tflite';
  static const String jsonExtension = '.json';
  static const String dbExtension = '.db';
  static const String videoExtension = '.mp4';
  static const String imageExtension = '.svg';
  static const String audioExtension = '.wav';
  
  // Checksum algorithm
  static const String checksumAlgorithm = 'sha256';
  
  // Export configuration
  static const int linkExpirationDays = 30;
  
  // Logging configuration
  static const bool enableLogging = true;
  static const int maxLogSizeMB = 10;
  static const int maxLogFiles = 5;
}
