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

/// Extension methods for the service locator
/// Provides convenient type-safe access to dependencies

/// Extension for GetIt to provide type-safe service retrieval
extension ServiceLocatorExtension on GetIt {
  // ==================== Voice Recording Services ====================
  
  /// Get the voice recording service
  VoiceRecordingService get voiceRecordingService => get<VoiceRecordingService>();
  
  /// Get the audio recorder
  AudioRecorder get audioRecorder => get<AudioRecorder>();
  
  // ==================== STT Services ====================
  
  /// Get the STT service
  STTService get sttService => get<STTService>();
  
  /// Get the STT model manager
  STTModelManager get sttModelManager => get<STTModelManager>();
  
  /// Get the STT result validator
  STTResultValidator get sttResultValidator => get<STTResultValidator>();
  
  // ==================== Text Normalization Services ====================
  
  /// Get the text normalization service
  TextNormalizationService get textNormalizationService => get<TextNormalizationService>();
  
  /// Get the normalization cache
  NormalizationCache get normalizationCache => get<NormalizationCache>();
  
  // ==================== Sign Mapping Services ====================
  
  /// Get the sign mapping service
  SignMappingService get signMappingService => get<SignMappingService>();
  
  /// Get the sign database
  SignDatabase get signDatabase => get<SignDatabase>();
  
  /// Get the sign lookup cache
  SignLookupCache get signLookupCache => get<SignLookupCache>();
  
  // ==================== Avatar Services ====================
  
  /// Get the avatar service
  AvatarService get avatarService => get<AvatarService>();
  
  /// Get the avatar player
  AvatarPlayer get avatarPlayer => get<AvatarPlayer>();
  
  /// Get the avatar asset manager
  AvatarAssetManager get avatarAssetManager => get<AvatarAssetManager>();
  
  // ==================== Export Services ====================
  
  /// Get the export service
  ExportService get exportService => get<ExportService>();
  
  /// Get the share manager
  ShareManager get shareManager => get<ShareManager>();
  
  /// Get the export format
  ExportFormat get exportFormat => get<ExportFormat>();
  
  /// Get the export result
  ExportResult get exportResult => get<ExportResult>();
  
  // ==================== Asset Manager Services ====================
  
  /// Get the asset manager service
  AssetManagerService get assetManagerService => get<AssetManagerService>();
  
  /// Get the model downloader
  ModelDownloader get modelDownloader => get<ModelDownloader>();
  
  /// Get the model manager
  ModelManager get modelManager => get<ModelManager>();
  
  /// Get the model validator
  ModelValidator get modelValidator => get<ModelValidator>();
  
  // ==================== Cache Services ====================
  
  /// Get the cache service
  CacheService get cacheService => get<CacheService>();
  
  /// Get the cache eviction policy
  CacheEvictionPolicy get cacheEvictionPolicy => get<CacheEvictionPolicy>();
  
  // ==================== Connectivity Services ====================
  
  /// Get the connectivity service
  ConnectivityService get connectivityService => get<ConnectivityService>();
  
  /// Get the network info
  NetworkInfo get networkInfo => get<NetworkInfo>();
  
  // ==================== Repositories ====================
  
  /// Get the translation repository
  TranslationRepository get translationRepository => get<TranslationRepository>();
  
  /// Get the asset repository
  AssetRepository get assetRepository => get<AssetRepository>();
  
  /// Get the cache repository
  CacheRepository get cacheRepository => get<CacheRepository>();
  
  // ==================== Use Cases ====================
  
  // Translation use cases
  TranslateText get translateText => get<TranslateText>();
  TranslateVoice get translateVoice => get<TranslateVoice>();
  GetTranslationHistory get getTranslationHistory => get<GetTranslationHistory>();
  
  // Asset use cases
  DownloadModel get downloadModel => get<DownloadModel>();
  UpdateModel get updateModel => get<UpdateModel>();
  GetAvailableModels get getAvailableModels => get<GetAvailableModels>();
  
  // Cache use cases
  SaveCache get saveCache => get<SaveCache>();
  GetCache get getCache => get<GetCache>();
  ClearCache get clearCache => get<ClearCache>();
  
  // ==================== Blocs/Cubits ====================
  
  /// Get the translation cubit
  TranslationCubit get translationCubit => get<TranslationCubit>();
  
  /// Get the voice recording cubit
  VoiceRecordingCubit get voiceRecordingCubit => get<VoiceRecordingCubit>();
  
  /// Get the asset manager cubit
  AssetManagerCubit get assetManagerCubit => get<AssetManagerCubit>();
  
  /// Get the settings cubit
  SettingsCubit get settingsCubit => get<SettingsCubit>();
}

/// Extension for checking if services are registered
extension ServiceLocatorCheckExtension on GetIt {
  // ==================== Voice Recording Services ====================
  
  bool get hasVoiceRecordingService => isRegistered<VoiceRecordingService>();
  bool get hasAudioRecorder => isRegistered<AudioRecorder>();
  
  // ==================== STT Services ====================
  
  bool get hasSTTService => isRegistered<STTService>();
  bool get hasSTTModelManager => isRegistered<STTModelManager>();
  bool get hasSTTResultValidator => isRegistered<STTResultValidator>();
  
  // ==================== Text Normalization Services ====================
  
  bool get hasTextNormalizationService => isRegistered<TextNormalizationService>();
  bool get hasNormalizationCache => isRegistered<NormalizationCache>();
  
  // ==================== Sign Mapping Services ====================
  
  bool get hasSignMappingService => isRegistered<SignMappingService>();
  bool get hasSignDatabase => isRegistered<SignDatabase>();
  bool get hasSignLookupCache => isRegistered<SignLookupCache>();
  
  // ==================== Avatar Services ====================
  
  bool get hasAvatarService => isRegistered<AvatarService>();
  bool get hasAvatarPlayer => isRegistered<AvatarPlayer>();
  bool get hasAvatarAssetManager => isRegistered<AvatarAssetManager>();
  
  // ==================== Export Services ====================
  
  bool get hasExportService => isRegistered<ExportService>();
  bool get hasShareManager => isRegistered<ShareManager>();
  bool get hasExportFormat => isRegistered<ExportFormat>();
  bool get hasExportResult => isRegistered<ExportResult>();
  
  // ==================== Asset Manager Services ====================
  
  bool get hasAssetManagerService => isRegistered<AssetManagerService>();
  bool get hasModelDownloader => isRegistered<ModelDownloader>();
  bool get hasModelManager => isRegistered<ModelManager>();
  bool get hasModelValidator => isRegistered<ModelValidator>();
  
  // ==================== Cache Services ====================
  
  bool get hasCacheService => isRegistered<CacheService>();
  bool get hasCacheEvictionPolicy => isRegistered<CacheEvictionPolicy>();
  
  // ==================== Connectivity Services ====================
  
  bool get hasConnectivityService => isRegistered<ConnectivityService>();
  bool get hasNetworkInfo => isRegistered<NetworkInfo>();
  
  // ==================== Repositories ====================
  
  bool get hasTranslationRepository => isRegistered<TranslationRepository>();
  bool get hasAssetRepository => isRegistered<AssetRepository>();
  bool get hasCacheRepository => isRegistered<CacheRepository>();
  
  // ==================== Use Cases ====================
  
  bool get hasTranslateText => isRegistered<TranslateText>();
  bool get hasTranslateVoice => isRegistered<TranslateVoice>();
  bool get hasGetTranslationHistory => isRegistered<GetTranslationHistory>();
  bool get hasDownloadModel => isRegistered<DownloadModel>();
  bool get hasUpdateModel => isRegistered<UpdateModel>();
  bool get hasGetAvailableModels => isRegistered<GetAvailableModels>();
  bool get hasSaveCache => isRegistered<SaveCache>();
  bool get hasGetCache => isRegistered<GetCache>();
  bool get hasClearCache => isRegistered<ClearCache>();
  
  // ==================== Blocs/Cubits ====================
  
  bool get hasTranslationCubit => isRegistered<TranslationCubit>();
  bool get hasVoiceRecordingCubit => isRegistered<VoiceRecordingCubit>();
  bool get hasAssetManagerCubit => isRegistered<AssetManagerCubit>();
  bool get hasSettingsCubit => isRegistered<SettingsCubit>();
}

/// Extension for getting services with default values
extension ServiceLocatorDefaultExtension on GetIt {
  // ==================== Voice Recording Services ====================
  
  VoiceRecordingService get voiceRecordingServiceOrDefault([VoiceRecordingService? defaultValue]) =>
      getOrNull<VoiceRecordingService>() ?? defaultValue!;
  
  AudioRecorder get audioRecorderOrDefault([AudioRecorder? defaultValue]) =>
      getOrNull<AudioRecorder>() ?? defaultValue!;
  
  // ==================== STT Services ====================
  
  STTService get sttServiceOrDefault([STTService? defaultValue]) =>
      getOrNull<STTService>() ?? defaultValue!;
  
  STTModelManager get sttModelManagerOrDefault([STTModelManager? defaultValue]) =>
      getOrNull<STTModelManager>() ?? defaultValue!;
  
  STTResultValidator get sttResultValidatorOrDefault([STTResultValidator? defaultValue]) =>
      getOrNull<STTResultValidator>() ?? defaultValue!;
  
  // ==================== Text Normalization Services ====================
  
  TextNormalizationService get textNormalizationServiceOrDefault([TextNormalizationService? defaultValue]) =>
      getOrNull<TextNormalizationService>() ?? defaultValue!;
  
  NormalizationCache get normalizationCacheOrDefault([NormalizationCache? defaultValue]) =>
      getOrNull<NormalizationCache>() ?? defaultValue!;
  
  // ==================== Sign Mapping Services ====================
  
  SignMappingService get signMappingServiceOrDefault([SignMappingService? defaultValue]) =>
      getOrNull<SignMappingService>() ?? defaultValue!;
  
  SignDatabase get signDatabaseOrDefault([SignDatabase? defaultValue]) =>
      getOrNull<SignDatabase>() ?? defaultValue!;
  
  SignLookupCache get signLookupCacheOrDefault([SignLookupCache? defaultValue]) =>
      getOrNull<SignLookupCache>() ?? defaultValue!;
  
  // ==================== Avatar Services ====================
  
  AvatarService get avatarServiceOrDefault([AvatarService? defaultValue]) =>
      getOrNull<AvatarService>() ?? defaultValue!;
  
  AvatarPlayer get avatarPlayerOrDefault([AvatarPlayer? defaultValue]) =>
      getOrNull<AvatarPlayer>() ?? defaultValue!;
  
  AvatarAssetManager get avatarAssetManagerOrDefault([AvatarAssetManager? defaultValue]) =>
      getOrNull<AvatarAssetManager>() ?? defaultValue!;
  
  // ==================== Export Services ====================
  
  ExportService get exportServiceOrDefault([ExportService? defaultValue]) =>
      getOrNull<ExportService>() ?? defaultValue!;
  
  ShareManager get shareManagerOrDefault([ShareManager? defaultValue]) =>
      getOrNull<ShareManager>() ?? defaultValue!;
  
  ExportFormat get exportFormatOrDefault([ExportFormat? defaultValue]) =>
      getOrNull<ExportFormat>() ?? defaultValue!;
  
  ExportResult get exportResultOrDefault([ExportResult? defaultValue]) =>
      getOrNull<ExportResult>() ?? defaultValue!;
  
  // ==================== Asset Manager Services ====================
  
  AssetManagerService get assetManagerServiceOrDefault([AssetManagerService? defaultValue]) =>
      getOrNull<AssetManagerService>() ?? defaultValue!;
  
  ModelDownloader get modelDownloaderOrDefault([ModelDownloader? defaultValue]) =>
      getOrNull<ModelDownloader>() ?? defaultValue!;
  
  ModelManager get modelManagerOrDefault([ModelManager? defaultValue]) =>
      getOrNull<ModelManager>() ?? defaultValue!;
  
  ModelValidator get modelValidatorOrDefault([ModelValidator? defaultValue]) =>
      getOrNull<ModelValidator>() ?? defaultValue!;
  
  // ==================== Cache Services ====================
  
  CacheService get cacheServiceOrDefault([CacheService? defaultValue]) =>
      getOrNull<CacheService>() ?? defaultValue!;
  
  CacheEvictionPolicy get cacheEvictionPolicyOrDefault([CacheEvictionPolicy? defaultValue]) =>
      getOrNull<CacheEvictionPolicy>() ?? defaultValue!;
  
  // ==================== Connectivity Services ====================
  
  ConnectivityService get connectivityServiceOrDefault([ConnectivityService? defaultValue]) =>
      getOrNull<ConnectivityService>() ?? defaultValue!;
  
  NetworkInfo get networkInfoOrDefault([NetworkInfo? defaultValue]) =>
      getOrNull<NetworkInfo>() ?? defaultValue!;
  
  // ==================== Repositories ====================
  
  TranslationRepository get translationRepositoryOrDefault([TranslationRepository? defaultValue]) =>
      getOrNull<TranslationRepository>() ?? defaultValue!;
  
  AssetRepository get assetRepositoryOrDefault([AssetRepository? defaultValue]) =>
      getOrNull<AssetRepository>() ?? defaultValue!;
  
  CacheRepository get cacheRepositoryOrDefault([CacheRepository? defaultValue]) =>
      getOrNull<CacheRepository>() ?? defaultValue!;
  
  // ==================== Use Cases ====================
  
  TranslateText get translateTextOrDefault([TranslateText? defaultValue]) =>
      getOrNull<TranslateText>() ?? defaultValue!;
  
  TranslateVoice get translateVoiceOrDefault([TranslateVoice? defaultValue]) =>
      getOrNull<TranslateVoice>() ?? defaultValue!;
  
  GetTranslationHistory get getTranslationHistoryOrDefault([GetTranslationHistory? defaultValue]) =>
      getOrNull<GetTranslationHistory>() ?? defaultValue!;
  
  DownloadModel get downloadModelOrDefault([DownloadModel? defaultValue]) =>
      getOrNull<DownloadModel>() ?? defaultValue!;
  
  UpdateModel get updateModelOrDefault([UpdateModel? defaultValue]) =>
      getOrNull<UpdateModel>() ?? defaultValue!;
  
  GetAvailableModels get getAvailableModelsOrDefault([GetAvailableModels? defaultValue]) =>
      getOrNull<GetAvailableModels>() ?? defaultValue!;
  
  SaveCache get saveCacheOrDefault([SaveCache? defaultValue]) =>
      getOrNull<SaveCache>() ?? defaultValue!;
  
  GetCache get getCacheOrDefault([GetCache? defaultValue]) =>
      getOrNull<GetCache>() ?? defaultValue!;
  
  ClearCache get clearCacheOrDefault([ClearCache? defaultValue]) =>
      getOrNull<ClearCache>() ?? defaultValue!;
  
  // ==================== Blocs/Cubits ====================
  
  TranslationCubit get translationCubitOrDefault([TranslationCubit? defaultValue]) =>
      getOrNull<TranslationCubit>() ?? defaultValue!;
  
  VoiceRecordingCubit get voiceRecordingCubitOrDefault([VoiceRecordingCubit? defaultValue]) =>
      getOrNull<VoiceRecordingCubit>() ?? defaultValue!;
  
  AssetManagerCubit get assetManagerCubitOrDefault([AssetManagerCubit? defaultValue]) =>
      getOrNull<AssetManagerCubit>() ?? defaultValue!;
  
  SettingsCubit get settingsCubitOrDefault([SettingsCubit? defaultValue]) =>
      getOrNull<SettingsCubit>() ?? defaultValue!;
}
