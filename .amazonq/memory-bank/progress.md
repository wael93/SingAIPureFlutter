# Progress — SingAI

## Completed
- [x] Clean Architecture folder structure
- [x] `AppConfig` with all constants and feature flags
- [x] DI container (`config/dependencies.dart`) — full wiring
- [x] Core layer: constants, errors, network, utils
- [x] Service abstractions: STTService, TextNormalizationService, SignMappingService, AvatarService, CacheService, AssetManagerService, ExportService
- [x] Application layer files created (all services, managers, validators)
- [x] Domain repository interfaces (TranslationRepository, AssetRepository, CacheRepository)
- [x] Use-case files created (TranslateText, TranslateVoice, GetTranslationHistory, DownloadModel, UpdateModel, GetAvailableModels, SaveCache, GetCache, ClearCache)
- [x] Cubit files created (TranslationCubit, VoiceRecordingCubit, AssetManagerCubit, SettingsCubit)
- [x] All page files created (Home, Settings, Usage, ModelManager, TranslationResult)
- [x] All widget files created (VoiceRecorder, AvatarPlayer, SignMapping)
- [x] pubspec.yaml with all dependencies

## In Progress
- [ ] Domain models implementation (TranslationRequest, TranslationResult, ModelInfo, etc.)
- [ ] STT service implementation (LocalSTTService with flutter_whisper)
- [ ] Sign mapping implementation (SignMapper, SignDatabase)
- [ ] Avatar rendering (AvatarPlayer, AvatarService)
- [ ] Export / share (ExportService, ShareManager)
- [ ] HomePage full UI

## Not Started
- [ ] Hive adapters and DB initialization
- [ ] Unit tests
- [ ] Integration tests
- [ ] Multi-dialect support (ASL, BSL, Arabic SL)
- [ ] Admin usage dashboard logic
- [ ] Optional cloud sync
- [ ] Web/PWA support

## Bugs / Issues
- `main.dart` BlocProvider: `Dependencies.container<Dependencies>()` — invalid call, needs fix
- Most service `registerFactory` calls will fail at runtime until implementations are filled in
