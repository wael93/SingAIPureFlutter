# System Patterns — SingAI

## Architecture
Clean Architecture with 4 layers:

```
lib/
├── core/           # Shared utilities, constants, errors, network
├── domain/         # Models, repository interfaces, use cases
├── application/    # Service implementations (STT, normalization, sign mapping, avatar, cache, export, asset manager, voice recording)
├── presentation/   # Pages, widgets, BLoC/Cubit
└── config/         # AppConfig, DI setup (dependencies.dart)
```

## Dependency Injection
- **GetIt** (`getIt` singleton in `config/dependencies.dart`)
- `initializeDependencies()` called in `main()` before `runApp`
- Registration groups: services → repositories → use cases → blocs
- Repositories: `registerLazySingleton`; everything else: `registerFactory`

## State Management
- **flutter_bloc** (Cubit pattern)
- Cubits: `TranslationCubit`, `VoiceRecordingCubit`, `AssetManagerCubit`, `SettingsCubit`

## Key Design Patterns
- Repository pattern: abstract interfaces in `domain/repositories/`, concrete impls registered via GetIt
- Service abstraction: abstract classes in `application/` (e.g. `STTService`, `SignMappingService`, `TextNormalizationService`)
- Use-case layer: one class per action (e.g. `TranslateText`, `TranslateVoice`, `DownloadModel`)
- Cache: `CacheManager` with `CacheEvictionPolicy`; `NormalizationCache` and `SignLookupCache` for per-service caching

## Local Storage
- **Hive** for structured local data
- `path_provider` for file-system paths
- Directories defined in `AppConfig`: `models/stt`, `models/normalization`, `models/sign_mapping`, `assets/avatar`, `cache/`

## AI / ML
- STT: `flutter_whisper` (Whisper model, local)
- Normalization: RAG approach (`RAGNormalizer`)
- Sign mapping: `SignDatabase` + `SignMapper`
- TFLite: `tflite_flutter` for additional model inference

## Networking (minimal)
- `connectivity_plus` + `ConnectivityService` / `NetworkInfo` — only for model downloads
- `http` for `ModelDownloader`
- `crypto` (SHA-256) for model file validation

## Security / Privacy
- No data sent externally (all processing local)
- AES-256 for locally stored data
- No user tracking without consent
