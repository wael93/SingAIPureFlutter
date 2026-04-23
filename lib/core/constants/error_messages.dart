/// Error messages for the application
class ErrorMessages {
  // General errors
  static const String unknownError = 'An unknown error occurred';
  static const String networkError = 'Network error occurred';
  static const String storageError = 'Storage error occurred';
  static const String permissionDenied = 'Permission denied';
  
  // Voice recording errors
  static const String microphonePermissionRequired = 'Microphone permission is required';
  static const String recordingTooShort = 'Recording must be at least 1 second';
  static const String recordingFailed = 'Failed to record audio';
  static const String audioFileNotFound = 'Audio file not found';
  static const String audioFormatNotSupported = 'Audio format not supported';
  
  // STT errors
  static const String sttProcessingFailed = 'Failed to process speech to text';
  static const String sttLowConfidence = 'Low confidence in recognition results';
  static const String sttModelNotFound = 'STT model not found';
  static const String sttModelCorrupted = 'STT model is corrupted';
  static const String sttLanguageNotSupported = 'Language not supported by STT model';
  static const String sttAudioProcessingFailed = 'Failed to process audio data';
  
  // Normalization errors
  static const String normalizationFailed = 'Failed to normalize text';
  static const String vocabularyNotFound = 'Vocabulary not found';
  static const String normalizationModelNotFound = 'Normalization model not found';
  static const String normalizationModelCorrupted = 'Normalization model is corrupted';
  
  // Sign mapping errors
  static const String signMappingFailed = 'Failed to map signs';
  static const String signNotFound = 'Sign not found for word';
  static const String signCoverageLow = 'Sign coverage is below 80%';
  static const String signDatabaseNotFound = 'Sign database not found';
  static const String signDatabaseCorrupted = 'Sign database is corrupted';
  static const String signVariantNotSupported = 'Sign language variant not supported';
  
  // Avatar errors
  static const String avatarRenderingFailed = 'Failed to render avatar';
  static const String avatarAssetNotFound = 'Avatar asset not found';
  static const String avatarAssetCorrupted = 'Avatar asset is corrupted';
  static const String avatarPlaybackFailed = 'Failed to play avatar';
  static const String avatarModelNotFound = 'Avatar model not found';
  
  // Export errors
  static const String exportFailed = 'Failed to export content';
  static const String storageLimitExceeded = 'Storage limit exceeded';
  static const String exportFileNotFound = 'Export file not found';
  static const String exportFormatNotSupported = 'Export format not supported';
  
  // Asset manager errors
  static const String downloadFailed = 'Failed to download model';
  static const String downloadCancelled = 'Download cancelled';
  static const String downloadPaused = 'Download paused';
  static const String checksumMismatch = 'Model checksum verification failed';
  static const String modelVerificationFailed = 'Model verification failed';
  static const String insufficientStorage = 'Insufficient storage space';
  static const String storageAccessDenied = 'Storage access denied';
  static const String modelUpdateFailed = 'Failed to update model';
  static const String modelDeleteFailed = 'Failed to delete model';
  
  // Cache errors
  static const String cacheReadFailed = 'Failed to read from cache';
  static const String cacheWriteFailed = 'Failed to write to cache';
  static const String cacheNotFound = 'Cache entry not found';
  static const String cacheCorrupted = 'Cache entry is corrupted';
  static const String cacheLimitExceeded = 'Cache size limit exceeded';
  static const String cacheEvictionFailed = 'Failed to evict old cache entries';
  
  // Settings errors
  static const String settingsSaveFailed = 'Failed to save settings';
  static const String settingsLoadFailed = 'Failed to load settings';
  static const String invalidSettingsValue = 'Invalid settings value';
  
  // File system errors
  static const String fileNotFound = 'File not found';
  static const String fileAccessDenied = 'File access denied';
  static const String fileReadFailed = 'Failed to read file';
  static const String fileWriteFailed = 'Failed to write file';
  static const String directoryNotFound = 'Directory not found';
  static const String directoryCreationFailed = 'Failed to create directory';
  
  // Network errors
  static const String noInternetConnection = 'No internet connection';
  static const String connectionTimeout = 'Connection timed out';
  static const String serverError = 'Server error occurred';
  static const String invalidResponse = 'Invalid response from server';
  static const String sslCertificateError = 'SSL certificate error';
  
  // Permission errors
  static const String permissionNotGranted = 'Permission not granted';
  static const String permissionPermanentlyDenied = 'Permission permanently denied';
  static const String permissionRationaleRequired = 'Permission rationale required';
  
  // Model errors
  static const String modelDownloadFailed = 'Model download failed';
  static const String modelInstallationFailed = 'Model installation failed';
  static const String modelUpdateRequired = 'Model update required';
  static const String modelIncompatible = 'Model is incompatible with current version';
  
  // Processing errors
  static const String processingFailed = 'Processing failed';
  static const String processingCancelled = 'Processing cancelled';
  static const String processingTimeout = 'Processing timed out';
  static const String processingResourceExhausted = 'Processing resources exhausted';
  
  // User-friendly error messages with actionable solutions
  static const Map<String, String> errorSolutions = {
    networkError: 'Please check your internet connection and try again',
    storageError: 'Please free up some storage space and try again',
    permissionDenied: 'Please enable the required permission in settings',
    microphonePermissionRequired: 'Please allow microphone access to record audio',
    recordingTooShort: 'Please record for at least 1 second',
    recordingFailed: 'Please try recording again',
    sttProcessingFailed: 'Please try again or use text input instead',
    sttLowConfidence: 'The recognition has low confidence. Please try again or use text input',
    sttModelNotFound: 'Please download the STT model for your language',
    sttModelCorrupted: 'Please redownload the STT model',
    normalizationFailed: 'Please try again or use the original text',
    signMappingFailed: 'Please check your text and try again',
    signNotFound: 'Some signs are not available. The translation may be incomplete',
    signCoverageLow: 'Sign coverage is low. Some words may not have signs',
    avatarRenderingFailed: 'Please try again or select a different avatar',
    avatarAssetNotFound: 'Avatar assets are missing. Please download them',
    exportFailed: 'Please check your storage and try again',
    storageLimitExceeded: 'Please clear some space or delete old content',
    downloadFailed: 'Please check your connection and try again',
    checksumMismatch: 'The downloaded model is corrupted. Please redownload',
    insufficientStorage: 'Please free up at least 500MB of storage space',
    cacheReadFailed: 'Please try again or clear the cache',
    cacheWriteFailed: 'Please check your storage and try again',
    cacheLimitExceeded: 'Please clear some cache entries',
    settingsSaveFailed: 'Please try again',
    fileNotFound: 'Please check the file path and try again',
    fileAccessDenied: 'Please check file permissions',
    noInternetConnection: 'Please connect to the internet',
    connectionTimeout: 'Please try again',
    serverError: 'Please try again later',
    modelDownloadFailed: 'Please check your connection and try again',
    modelInstallationFailed: 'Please check your storage and try again',
    modelIncompatible: 'Please update the app to use this model',
    processingFailed: 'Please try again',
    processingCancelled: 'Processing was cancelled',
    processingTimeout: 'Processing took too long. Please try again',
  };
  
  // Get error message with solution
  static String getErrorMessage(String errorCode) {
    return '$errorCode. ${errorSolutions[errorCode] ?? ''}';
  }
}
