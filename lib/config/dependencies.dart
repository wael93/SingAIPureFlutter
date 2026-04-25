import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/models/cache_entry.dart';
import '../domain/models/sign_mapping_model.dart';
import '../domain/models/translation_result.dart';
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
import '../features/player/application/avatar_player_service.dart';
import '../features/export/application/export_service.dart';

/// Dependency injection container using GetIt
final getIt = GetIt.instance;

/// Initialize all dependencies
/// CACHE-FIRST: Opens Hive boxes before registering services
Future<void> initializeDependencies() async {
  // HIVE INITIALIZATION: Register adapters
  // Run: flutter pub run build_runner build --delete-conflicting-outputs
  Hive.registerAdapter(CacheEntryAdapter());
  Hive.registerAdapter(TranslationResultAdapter());
  Hive.registerAdapter(SignMappingModelAdapter());
  
  // HIVE INITIALIZATION: Open boxes
  await Hive.openBox<CacheEntry>('cache');
  await Hive.openBox<TranslationResult>('translations');
  await Hive.openBox<SignMappingModel>('sign_mappings');
  await Hive.openBox('settings');
  await Hive.openBox('usage_stats');
  
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
  getIt.registerFactory<VoiceRecordingService>(() => VoiceRecorder());
  
  // AudioRecorder
  getIt.registerFactory<AudioRecorder>(() => AudioRecorder());
}

/// Register STT services
void registerSTTServices() {
  // STTService
  getIt.registerFactory<STTService>(() => LocalSTTService());
  
  // STTModelManager
  getIt.registerFactory<STTModelManager>(() => STTModelManager());
  
  // STTResultValidator
  getIt.registerFactory<STTResultValidator>(() => STTResultValidator());
}

/// Register text normalization services
void registerTextNormalizationServices() {
  // TextNormalizationService
  getIt.registerFactory<TextNormalizationService>(() => RAGNormalizer());
  
  // NormalizationCache
  getIt.registerFactory<NormalizationCache>(() => NormalizationCache());
}

/// Register sign mapping services
void registerSignMappingServices() {
  // SignMappingService
  getIt.registerFactory<SignMappingService>(() => SignMapper());
  
  // SignDatabase
  getIt.registerFactory<SignDatabase>(() => SignDatabase());
  
  // SignLookupCache
  getIt.registerFactory<SignLookupCache>(() => SignLookupCache());
}

/// Register avatar services
void registerAvatarServices() {
  // AvatarService
  getIt.registerFactory<AvatarService>(() => AvatarService());
  
  // AvatarPlayer
  getIt.registerFactory<AvatarPlayer>(() => AvatarPlayer());
  
  // AvatarAssetManager
  getIt.registerFactory<AvatarAssetManager>(() => AvatarAssetManager());
}

/// Register export services
void registerExportServices() {
  // ExportService
  getIt.registerFactory<ExportService>(() => ExportService());
  
  // ShareManager
  getIt.registerFactory<ShareManager>(() => ShareManager());
  
  // ExportFormat
  getIt.registerFactory<ExportFormat>(() => ExportFormat());
  
  // ExportResult
  getIt.registerFactory<ExportResult>(() => ExportResult());
}

/// Register asset manager services
void registerAssetManagerServices() {
  // AssetManagerService
  getIt.registerFactory<AssetManagerService>(() => AssetManager());
  
  // ModelDownloader
  getIt.registerFactory<ModelDownloader>(() => ModelDownloader());
  
  // ModelManager
  getIt.registerFactory<ModelManager>(() => ModelManager());
  
  // ModelValidator
  getIt.registerFactory<ModelValidator>(() => ModelValidator());
}

/// Register cache services
void registerCacheServices() {
  // CacheService
  getIt.registerFactory<CacheService>(() => CacheManager());
  
  // CacheEvictionPolicy
  getIt.registerFactory<CacheEvictionPolicy>(() => CacheEvictionPolicy());
}

/// Register connectivity services
void registerConnectivityServices() {
  // ConnectivityService
  getIt.registerFactory<ConnectivityService>(() => ConnectivityService());
  
  // NetworkInfo
  getIt.registerFactory<NetworkInfo>(() => NetworkInfo());
}

/// Register repositories
void registerRepositories() {
  // TranslationRepository
  getIt.registerLazySingleton<TranslationRepository>(() => TranslationRepository());
  
  // AssetRepository
  getIt.registerLazySingleton<AssetRepository>(() => AssetRepository());
  
  // CacheRepository
  getIt.registerLazySingleton<CacheRepository>(() => CacheRepository());
}

/// Register use cases
void registerUseCases() {
  // Translation use cases
  getIt.registerFactory<TranslateText>(() => TranslateText());
  getIt.registerFactory<TranslateVoice>(() => TranslateVoice());
  getIt.registerFactory<GetTranslationHistory>(() => GetTranslationHistory());
  
  // Asset use cases
  getIt.registerFactory<DownloadModel>(() => DownloadModel());
  getIt.registerFactory<UpdateModel>(() => UpdateModel());
  getIt.registerFactory<GetAvailableModels>(() => GetAvailableModels());
  
  // Cache use cases
  getIt.registerFactory<SaveCache>(() => SaveCache());
  getIt.registerFactory<GetCache>(() => GetCache());
  getIt.registerFactory<ClearCache>(() => ClearCache());
}

/// Register blocs/cubits
void registerBlocs() {
  // TranslationCubit
  getIt.registerFactory<TranslationCubit>(() => TranslationCubit());
  
  // VoiceRecordingCubit
  getIt.registerFactory<VoiceRecordingCubit>(() => VoiceRecordingCubit());
  
  // AssetManagerCubit
  getIt.registerFactory<AssetManagerCubit>(() => AssetManagerCubit());
  
  // SettingsCubit
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit());
  
  // RecorderCubit - MVP SCOPE LOCK: Added for voice recording feature
  getIt.registerFactory<RecorderCubit>(() => RecorderCubit());
  
  // AvatarPlayerCubit - MVP SCOPE LOCK: Added for player feature
  getIt.registerFactory<AvatarPlayerCubit>(() => AvatarPlayerCubit());
}

/// Reset the dependency injection container (useful for testing)
void resetDependencies() {
  getIt.reset();
}
