import 'package:get_it/get_it.dart';

import '../application/asset_manager/asset_manager.dart';
import '../application/asset_manager/model_downloader.dart';
import '../application/asset_manager/model_manager.dart';
import '../application/asset_manager/model_validator.dart';
import '../application/avatar/avatar_asset_manager.dart';
import '../application/avatar/avatar_player.dart';
import '../application/avatar/avatar_service.dart';
import '../application/cache/cache_eviction_policy.dart';
import '../application/cache/cache_manager.dart';
import '../application/export/export_format.dart';
import '../application/export/export_result.dart';
import '../application/export/export_service.dart';
import '../application/export/share_manager.dart';
import '../application/normalization/normalization_cache.dart';
import '../application/normalization/rag_normalizer.dart';
import '../application/normalization/text_normalizer.dart';
import '../application/sign_mapping/sign_database.dart';
import '../application/sign_mapping/sign_language_variant.dart';
import '../application/sign_mapping/sign_lookup_cache.dart';
import '../application/sign_mapping/sign_mapper.dart';
import '../application/stt/local_stt_service.dart';
import '../application/stt/stt_model_manager.dart';
import '../application/stt/stt_result_validator.dart';
import '../application/stt/stt_service.dart';
import '../application/voice_recording/audio_recorder.dart';
import '../application/voice_recording/voice_recorder.dart';
import '../core/network/connectivity_service.dart';
import '../core/network/network_info.dart';
import '../domain/repositories/asset_repository.dart';
import '../domain/repositories/cache_repository.dart';
import '../domain/repositories/translation_repository.dart';
import '../domain/use_cases/asset/download_model.dart';
import '../domain/use_cases/asset/get_available_models.dart';
import '../domain/use_cases/asset/update_model.dart';
import '../domain/use_cases/cache/clear_cache.dart';
import '../domain/use_cases/cache/get_cache.dart';
import '../domain/use_cases/cache/save_cache.dart';
import '../domain/use_cases/translation/get_translation_history.dart';
import '../domain/use_cases/translation/translate_text.dart';
import '../domain/use_cases/translation/translate_voice.dart';
import '../presentation/bloc/asset_manager/asset_manager_cubit.dart';
import '../presentation/bloc/settings/settings_cubit.dart';
import '../presentation/bloc/translation/translation_cubit.dart';
import '../presentation/bloc/voice_recording/voice_recording_cubit.dart';
import '../features/recorder/presentation/bloc/recorder_cubit.dart';
import '../features/player/presentation/bloc/avatar_player_cubit.dart';

/// Dependency Injection setup functions
/// Provides a clean way to register and retrieve dependencies

/// Get the global dependency injection container
GetIt getDIContainer() => GetIt.instance;

/// Register a service with singleton lifetime
/// The same instance is returned for all requests
void registerSingleton<T>(T instance) {
  getDIContainer().registerSingleton<T>(instance);
}

/// Register a service with lazy singleton lifetime
/// The instance is created on first request and reused
void registerLazySingleton<T>(T Function() createInstance) {
  getDIContainer().registerLazySingleton<T>(createInstance);
}

/// Register a service with factory lifetime
/// A new instance is created for each request
void registerFactory<T>(T Function() createInstance) {
  getDIContainer().registerFactory<T>(createInstance);
}

/// Register a service with factory lifetime and a name
/// Useful for registering multiple implementations of the same interface
void registerFactoryNamed<T>(String name, T Function() createInstance) {
  getDIContainer().registerFactory<T>(createInstance, instanceName: name);
}

/// Register a service with factory lifetime and async initialization
/// The instance is created asynchronously on first request
Future<void> registerFactoryAsync<T>(Future<T> Function() createInstance) async {
  await getDIContainer().registerFactoryAsync<T>(createInstance);
}

/// Check if a service is registered
bool isRegistered<T>() => getDIContainer().isRegistered<T>();

/// Get a service instance
/// Throws an exception if the service is not registered
T getService<T>() => getDIContainer().get<T>();

/// Get a service instance with a name
/// Throws an exception if the service is not registered
T getServiceNamed<T>(String name) => getDIContainer().get<T>(instanceName: name);

/// Get a service instance or null if not registered
T? getServiceOrNull<T>() => getDIContainer().getOrNull<T>();

/// Get a service instance with lazy initialization
T getLazy<T>() => getDIContainer().get<T>(lazy: true);

/// Get a service instance with factory initialization
T getFactory<T>() => getDIContainer().get<T>(instanceName: 'factory');

/// Reset the dependency injection container
/// Useful for testing to ensure clean state
void resetDIContainer() {
  getDIContainer().reset();
}

/// Setup all dependencies
/// Call this during app initialization
Future<void> setupDependencies() async {
  // Register services
  setupVoiceRecordingServices();
  setupSTTServices();
  setupTextNormalizationServices();
  setupSignMappingServices();
  setupAvatarServices();
  setupExportServices();
  setupAssetManagerServices();
  setupCacheServices();
  setupConnectivityServices();
  
  // Register repositories
  setupRepositories();
  
  // Register use cases
  setupUseCases();
  
  // Register blocs/cubits
  setupBlocs();
}

/// Setup voice recording services
void setupVoiceRecordingServices() {
  // VoiceRecordingService
  registerFactory<VoiceRecordingService>(() => VoiceRecorder());
  
  // AudioRecorder
  registerFactory<AudioRecorder>(() => AudioRecorder());
}

/// Setup STT services
void setupSTTServices() {
  // STTService
  registerFactory<STTService>(() => LocalSTTService());
  
  // STTModelManager
  registerFactory<STTModelManager>(() => STTModelManager());
  
  // STTResultValidator
  registerFactory<STTResultValidator>(() => STTResultValidator());
}

/// Setup text normalization services
void setupTextNormalizationServices() {
  // TextNormalizationService
  registerFactory<TextNormalizationService>(() => RAGNormalizer());
  
  // NormalizationCache
  registerFactory<NormalizationCache>(() => NormalizationCache());
}

/// Setup sign mapping services
void setupSignMappingServices() {
  // SignMappingService
  registerFactory<SignMappingService>(() => SignMapper());
  
  // SignDatabase
  registerFactory<SignDatabase>(() => SignDatabase());
  
  // SignLookupCache
  registerFactory<SignLookupCache>(() => SignLookupCache());
}

/// Setup avatar services
void setupAvatarServices() {
  // AvatarService
  registerFactory<AvatarService>(() => AvatarService());
  
  // AvatarPlayer
  registerFactory<AvatarPlayer>(() => AvatarPlayer());
  
  // AvatarAssetManager
  registerFactory<AvatarAssetManager>(() => AvatarAssetManager());
}

/// Setup export services
void setupExportServices() {
  // ExportService
  registerFactory<ExportService>(() => ExportService());
  
  // ShareManager
  registerFactory<ShareManager>(() => ShareManager());
  
  // ExportFormat
  registerFactory<ExportFormat>(() => ExportFormat());
  
  // ExportResult
  registerFactory<ExportResult>(() => ExportResult());
}

/// Setup asset manager services
void setupAssetManagerServices() {
  // AssetManagerService
  registerFactory<AssetManagerService>(() => AssetManager());
  
  // ModelDownloader
  registerFactory<ModelDownloader>(() => ModelDownloader());
  
  // ModelManager
  registerFactory<ModelManager>(() => ModelManager());
  
  // ModelValidator
  registerFactory<ModelValidator>(() => ModelValidator());
}

/// Setup cache services
void setupCacheServices() {
  // CacheService
  registerFactory<CacheService>(() => CacheManager());
  
  // CacheEvictionPolicy
  registerFactory<CacheEvictionPolicy>(() => CacheEvictionPolicy());
}

/// Setup connectivity services
void setupConnectivityServices() {
  // ConnectivityService
  registerFactory<ConnectivityService>(() => ConnectivityService());
  
  // NetworkInfo
  registerFactory<NetworkInfo>(() => NetworkInfo());
}

/// Setup repositories
void setupRepositories() {
  // TranslationRepository
  registerLazySingleton<TranslationRepository>(() => TranslationRepository());
  
  // AssetRepository
  registerLazySingleton<AssetRepository>(() => AssetRepository());
  
  // CacheRepository
  registerLazySingleton<CacheRepository>(() => CacheRepository());
}

/// Setup use cases
void setupUseCases() {
  // Translation use cases
  registerFactory<TranslateText>(() => TranslateText());
  registerFactory<TranslateVoice>(() => TranslateVoice());
  registerFactory<GetTranslationHistory>(() => GetTranslationHistory());
  
  // Asset use cases
  registerFactory<DownloadModel>(() => DownloadModel());
  registerFactory<UpdateModel>(() => UpdateModel());
  registerFactory<GetAvailableModels>(() => GetAvailableModels());
  
  // Cache use cases
  registerFactory<SaveCache>(() => SaveCache());
  registerFactory<GetCache>(() => GetCache());
  registerFactory<ClearCache>(() => ClearCache());
}

/// Setup blocs/cubits
void setupBlocs() {
  // TranslationCubit
  registerFactory<TranslationCubit>(() => TranslationCubit());
  
  // VoiceRecordingCubit
  registerFactory<VoiceRecordingCubit>(() => VoiceRecordingCubit());
  
  // AssetManagerCubit
  registerFactory<AssetManagerCubit>(() => AssetManagerCubit());
  
  // SettingsCubit
  registerFactory<SettingsCubit>(() => SettingsCubit());
  
  // RecorderCubit - MVP SCOPE LOCK: Added for voice recording feature
  registerFactory<RecorderCubit>(() => RecorderCubit());
  
  // AvatarPlayerCubit - MVP SCOPE LOCK: Added for player feature
  registerFactory<AvatarPlayerCubit>(() => AvatarPlayerCubit());
}

/// Setup services with cloud implementations (future)
/// This allows easy swapping between local and cloud implementations
Future<void> setupCloudDependencies() async {
  // These will be implemented when cloud features are added
  // For now, this is a placeholder for future implementation
  
  // Example:
  // registerSingleton<CloudStorageService>(CloudStorageServiceImpl());
  // registerSingleton<CloudSyncService>(CloudSyncServiceImpl());
}

/// Setup test dependencies
/// Use this to register mock implementations for testing
void setupTestDependencies() {
  // This will be implemented when adding tests
  // Example:
  // registerSingleton<STTService>(MockSTTService());
  // registerSingleton<CacheService>(MockCacheService());
}
