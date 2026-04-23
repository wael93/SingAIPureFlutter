# Active Context — SingAI

## Current Phase
MVP Phase 3 — UI & Integration (in progress)

## What's Working
- Full Clean Architecture skeleton in place
- All service abstractions defined (STT, normalization, sign mapping, avatar, cache, export, asset manager)
- DI wiring complete in `config/dependencies.dart`
- Pages scaffolded: `HomePage`, `SettingsPage`, `UsagePage`, `ModelManagerPage`, `TranslationResultPage`
- Widgets scaffolded: `VoiceRecorderWidget`, `AvatarPlayerWidget`, `SignMappingWidget`
- Cubits registered: `TranslationCubit`, `VoiceRecordingCubit`, `AssetManagerCubit`, `SettingsCubit`

## What's Placeholder / TODO
Most domain models and service implementations are stubs:
- `domain/models/translation_models.dart` — empty placeholders
- `domain/models/model_models.dart` — empty placeholders
- `domain/repositories/translation_repository.dart` — abstract stub
- `application/stt/stt_service.dart` — abstract stub
- `application/sign_mapping/sign_mapper.dart` — abstract stub
- `presentation/pages/home_page.dart` — minimal scaffold only
- All use-case files under `domain/use_cases/` — likely stubs

## Active Work Areas
1. Avatar rendering (`AvatarPlayer`, `AvatarPlayerWidget`)
2. Export / share (`ExportService`, `ShareManager`)
3. Full `HomePage` implementation
4. Filling in domain models and repository implementations

## Known Issues
- `main.dart` calls `Dependencies.container<Dependencies>()` which doesn't exist — likely a placeholder/bug in BlocProvider
- Many `registerFactory` calls instantiate concrete classes that are currently stubs

## Next Steps (Roadmap Phase 3)
- [ ] Implement `TranslationModels` (TranslationRequest, TranslationResult, InputType, TranslationStatus)
- [ ] Implement `STTService` and `LocalSTTService`
- [ ] Implement `SignMappingService` and `SignMapper`
- [ ] Build full `HomePage` with voice/text input
- [ ] Complete `AvatarPlayer` + `AvatarPlayerWidget`
- [ ] Complete `ExportService` + `ShareManager`
