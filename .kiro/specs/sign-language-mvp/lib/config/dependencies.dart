import 'package:get_it/get_it.dart';

import '../core/network/connectivity_service.dart';
import '../application/asset_manager/asset_manager_service.dart';
import '../application/cache/cache_service.dart';
import '../application/stt/stt_service.dart';
import '../application/normalization/text_normalization_service.dart';
import '../application/sign_mapping/sign_mapping_service.dart';
import '../application/avatar/avatar_service.dart';
import '../application/export/export_service.dart';
import '../application/voice_recording/voice_recording_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Network
  getIt.registerSingleton<ConnectivityService>(ConnectivityService());
  
  // Services
  getIt.registerLazySingleton<AssetManagerService>(() => AssetManagerService());
  getIt.registerLazySingleton<CacheService>(() => CacheService());
  getIt.registerLazySingleton<STTService>(() => STTService());
  getIt.registerLazySingleton<TextNormalizationService>(() => TextNormalizationService());
  getIt.registerLazySingleton<SignMappingService>(() => SignMappingService());
  getIt.registerLazySingleton<AvatarService>(() => AvatarService());
  getIt.registerLazySingleton<ExportService>(() => ExportService());
  getIt.registerLazySingleton<VoiceRecordingService>(() => VoiceRecordingService());
}
