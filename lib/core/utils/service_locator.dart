import 'package:get_it/get_it.dart';

import '../../application/asset_manager/asset_manager.dart';
import '../../application/asset_manager/model_downloader.dart';
import '../../application/asset_manager/model_manager.dart';
import '../../application/asset_manager/model_validator.dart';
import '../../application/avatar/avatar_asset_manager.dart';
import '../../application/avatar/avatar_player.dart';
import '../../application/avatar/avatar_service.dart';
import '../../application/cache/cache_eviction_policy.dart';
import '../../application/cache/cache_manager.dart';
import '../../application/export/export_format.dart';
import '../../application/export/export_result.dart';
import '../../application/export/export_service.dart';
import '../../application/export/share_manager.dart';
import '../../application/normalization/normalization_cache.dart';
import '../../application/normalization/rag_normalizer.dart';
import '../../application/normalization/text_normalizer.dart';
import '../../application/sign_mapping/sign_database.dart';
import '../../application/sign_mapping/sign_language_variant.dart';
import '../../application/sign_mapping/sign_lookup_cache.dart';
import '../../application/sign_mapping/sign_mapper.dart';
import '../../application/stt/local_stt_service.dart';
import '../../application/stt/stt_model_manager.dart';
import '../../application/stt/stt_result_validator.dart';
import '../../application/stt/stt_service.dart';
import '../../application/voice_recording/audio_recorder.dart';
import '../../application/voice_recording/voice_recorder.dart';
import '../../core/network/connectivity_service.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/asset_repository.dart';
import '../../domain/repositories/cache_repository.dart';
import '../../domain/repositories/translation_repository.dart';
import '../../domain/use_cases/asset/download_model.dart';
import '../../domain/use_cases/asset/get_available_models.dart';
import '../../domain/use_cases/asset/update_model.dart';
import '../../domain/use_cases/cache/clear_cache.dart';
import '../../domain/use_cases/cache/get_cache.dart';
import '../../domain/use_cases/cache/save_cache.dart';
import '../../domain/use_cases/translation/get_translation_history.dart';
import '../../domain/use_cases/translation/translate_text.dart';
import '../../domain/use_cases/translation/translate_voice.dart';
import '../../presentation/bloc/asset_manager/asset_manager_cubit.dart';
import '../../presentation/bloc/settings/settings_cubit.dart';
import '../../presentation/bloc/translation/translation_cubit.dart';
import '../../presentation/bloc/voice_recording/voice_recording_cubit.dart';

/// Service Locator using GetIt
/// Provides a centralized way to access dependencies throughout the app
final serviceLocator = GetIt.instance;

/// Extension methods for type-safe service retrieval
extension ServiceLocatorExtension on GetIt {
  /// Get a service instance with type safety
  /// Throws an exception if the service is not registered
  T getService<T>() => get<T>();
  
  /// Get a service instance with type safety
  /// Returns null if the service is not registered
  T? getServiceOrNull<T>() => getOrNull<T>();
  
  /// Check if a service is registered
  bool hasService<T>() => isRegistered<T>();
  
  /// Get a service with lazy initialization
  /// The service is created only when first requested
  T getLazy<T>() => get<T>(lazy: true);
  
  /// Get a service with factory initialization
  /// A new instance is created every time the service is requested
  T getFactory<T>() => get<T>(instanceName: 'factory');
}

/// Initialize all services in the service locator
/// Call this during app startup before running the app
Future<void> initializeServiceLocator() async {
  // Register services
  registerServices();
  
  // Register repositories
  registerRepositories();
  
  // Register use cases
  registerUseCases();
  
  // Register blocs/cubits
  registerBlocs();
}

/// Register all services (local and future cloud implementations)
void registerServices() {
  // Voice Recording Services
  registerVoiceRecordingServices();
  
  // STT Services
  registerSTTServices();
  
  // Text Normalization Services
  registerTextNormalizationServices();
  
  // Sign Mapping Services
  registerSignMappingServices();
  
  // Avatar Services
  registerAvatarServices();
  
  // Export Services
  registerExportServices();
  
  // Asset Manager Services
  registerAssetManagerServices();
  
  // Cache Services
  registerCacheServices();
  
  // Connectivity Services
  registerConnectivityServices();
}

/// Register voice recording services
void registerVoiceRecordingServices() {
  // VoiceRecordingService
  serviceLocator.registerFactory<VoiceRecordingService>(() => VoiceRecorder());
  
  // AudioRecorder
  serviceLocator.registerFactory<AudioRecorder>(() => AudioRecorder());
}

/// Register STT services
void registerSTTServices() {
  // STTService
  serviceLocator.registerFactory<STTService>(() => LocalSTTService());
  
  // STTModelManager
  serviceLocator.registerFactory<STTModelManager>(() => STTModelManager());
  
  // STTResultValidator
  serviceLocator.registerFactory<STTResultValidator>(() => STTResultValidator());
}

/// Register text normalization services
void registerTextNormalizationServices() {
  // TextNormalizationService
  serviceLocator.registerFactory<TextNormalizationService>(() => RAGNormalizer());
  
  // NormalizationCache
  serviceLocator.registerFactory<NormalizationCache>(() => NormalizationCache());
}

/// Register sign mapping services
void registerSignMappingServices() {
  // SignMappingService
  serviceLocator.registerFactory<SignMappingService>(() => SignMapper());
  
  // SignDatabase
  serviceLocator.registerFactory<SignDatabase>(() => SignDatabase());
  
  // SignLookupCache
  serviceLocator.registerFactory<SignLookupCache>(() => SignLookupCache());
}

/// Register avatar services
void registerAvatarServices() {
  // AvatarService
  serviceLocator.registerFactory<AvatarService>(() => AvatarService());
  
  // AvatarPlayer
  serviceLocator.registerFactory<AvatarPlayer>(() => AvatarPlayer());
  
  // AvatarAssetManager
  serviceLocator.registerFactory<AvatarAssetManager>(() => AvatarAssetManager());
}

/// Register export services
void registerExportServices() {
  // ExportService
  serviceLocator.registerFactory<ExportService>(() => ExportService());
  
  // ShareManager
  serviceLocator.registerFactory<ShareManager>(() => ShareManager());
  
  // ExportFormat
  serviceLocator.registerFactory<ExportFormat>(() => ExportFormat());
  
  // ExportResult
  serviceLocator.registerFactory<ExportResult>(() => ExportResult());
}

/// Register asset manager services
void registerAssetManagerServices() {
  // AssetManagerService
  serviceLocator.registerFactory<AssetManagerService>(() => AssetManager());
  
  // ModelDownloader
  serviceLocator.registerFactory<ModelDownloader>(() => ModelDownloader());
  
  // ModelManager
  serviceLocator.registerFactory<ModelManager>(() => ModelManager());
  
  // ModelValidator
  serviceLocator.registerFactory<ModelValidator>(() => ModelValidator());
}

/// Register cache services
void registerCacheServices() {
  // CacheService
  serviceLocator.registerFactory<CacheService>(() => CacheManager());
  
  // CacheEvictionPolicy
  serviceLocator.registerFactory<CacheEvictionPolicy>(() => CacheEvictionPolicy());
}

/// Register connectivity services
void registerConnectivityServices() {
  // ConnectivityService
  serviceLocator.registerFactory<ConnectivityService>(() => ConnectivityService());
  
  // NetworkInfo
  serviceLocator.registerFactory<NetworkInfo>(() => NetworkInfo());
}

/// Register repositories
void registerRepositories() {
  // TranslationRepository
  serviceLocator.registerLazySingleton<TranslationRepository>(() => TranslationRepository());
  
  // AssetRepository
  serviceLocator.registerLazySingleton<AssetRepository>(() => AssetRepository());
  
  // CacheRepository
  serviceLocator.registerLazySingleton<CacheRepository>(() => CacheRepository());
}

/// Register use cases
void registerUseCases() {
  // Translation use cases
  serviceLocator.registerFactory<TranslateText>(() => TranslateText());
  serviceLocator.registerFactory<TranslateVoice>(() => TranslateVoice());
  serviceLocator.registerFactory<GetTranslationHistory>(() => GetTranslationHistory());
  
  // Asset use cases
  serviceLocator.registerFactory<DownloadModel>(() => DownloadModel());
  serviceLocator.registerFactory<UpdateModel>(() => UpdateModel());
  serviceLocator.registerFactory<GetAvailableModels>(() => GetAvailableModels());
  
  // Cache use cases
  serviceLocator.registerFactory<SaveCache>(() => SaveCache());
  serviceLocator.registerFactory<GetCache>(() => GetCache());
  serviceLocator.registerFactory<ClearCache>(() => ClearCache());
}

/// Register blocs/cubits
void registerBlocs() {
  // TranslationCubit
  serviceLocator.registerFactory<TranslationCubit>(() => TranslationCubit());
  
  // VoiceRecordingCubit
  serviceLocator.registerFactory<VoiceRecordingCubit>(() => VoiceRecordingCubit());
  
  // AssetManagerCubit
  serviceLocator.registerFactory<AssetManagerCubit>(() => AssetManagerCubit());
  
  // SettingsCubit
  serviceLocator.registerFactory<SettingsCubit>(() => SettingsCubit());
}

/// Reset the service locator (useful for testing)
void resetServiceLocator() {
  serviceLocator.reset();
}
