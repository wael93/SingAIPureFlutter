# 🧠 Memory Bank — SingAI Project

> **Purpose**: This document serves as the project's knowledge base, capturing architectural decisions, patterns, conventions, and critical context for developers and AI assistants.

---

## 📋 Project Overview

**Name**: SingAI  
**Type**: Sign Language Translation Mobile App  
**Platform**: Flutter (Android & iOS)  
**Architecture**: Clean Architecture with BLoC pattern  
**Key Feature**: Offline-first AI-powered speech-to-sign-language translation

---

## 🏗️ Architecture Patterns

### Clean Architecture Layers

```
presentation/ → application/ → domain/ → core/
     ↓              ↓            ↓         ↓
   UI/BLoC      Services      Business   Shared
                              Logic      Utils
```

**Layer Responsibilities**:
- **presentation/**: UI components, pages, widgets, BLoC/Cubit state management
- **application/**: Service implementations (STT, normalization, sign mapping, etc.)
- **domain/**: Business models, repository interfaces, use cases
- **core/**: Shared utilities, constants, error handling, network services

### Dependency Flow
- **Rule**: Dependencies flow inward (presentation → application → domain → core)
- **Interfaces**: Domain defines interfaces, application implements them
- **Injection**: GetIt for dependency injection (configured in `config/`)

---

## 🎯 Key Technical Decisions

### 1. State Management
- **Pattern**: BLoC/Cubit (flutter_bloc)
- **Location**: `presentation/bloc/`
- **Naming**: `*_cubit.dart`, `*_state.dart`
- **Immutability**: Using `freezed` for state classes

### 2. Data Models
- **Pattern**: Freezed immutable models
- **Location**: `domain/models/`
- **Features**: JSON serialization, copyWith, equality
- **Generation**: `flutter pub run build_runner build`

### 3. Local Storage
- **Primary**: Hive (NoSQL, fast, offline-first)
- **Use Cases**: Caching translations, storing models, user preferences
- **Location**: `application/cache/`

### 4. AI Processing
- **STT**: flutter_whisper (local Whisper model)
- **Normalization**: Local RAG with TensorFlow Lite
- **Sign Mapping**: Custom dictionary-based mapping
- **Principle**: All processing on-device (no cloud)

### 5. Error Handling
- **Pattern**: Result/Either pattern
- **Location**: `core/errors/`
- **Types**: `Failure` abstract class with concrete implementations
- **Logging**: Custom logger in `core/utils/logger.dart`

---

## 📁 Directory Structure Rules

### Feature Organization
```
lib/
├── core/                    # Shared across all features
├── domain/                  # Business logic (pure Dart)
├── application/             # Service implementations
│   └── [feature]/
│       ├── [feature]_service.dart
│       └── [feature]_service_impl.dart
└── presentation/            # UI layer
    ├── pages/
    │   └── [feature]_page.dart
    ├── widgets/
    │   └── [feature]_*.dart
    └── bloc/
        ├── [feature]_cubit.dart
        └── [feature]_state.dart
```

### Naming Conventions
- **Files**: snake_case (e.g., `voice_recording_service.dart`)
- **Classes**: PascalCase (e.g., `VoiceRecordingService`)
- **Variables**: camelCase (e.g., `audioFilePath`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `MAX_RECORDING_DURATION`)
- **Private**: Prefix with `_` (e.g., `_internalMethod`)

---

## 🔧 Service Patterns

### Service Interface Pattern
```dart
// domain/repositories/
abstract class FeatureRepository {
  Future<Result<Data, Failure>> performAction();
}

// application/feature/
class FeatureService implements FeatureRepository {
  @override
  Future<Result<Data, Failure>> performAction() async {
    // Implementation
  }
}
```

### Dependency Injection Pattern
```dart
// config/service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // Singletons
  getIt.registerSingleton<FeatureService>(FeatureServiceImpl());
  
  // Factories
  getIt.registerFactory<FeatureCubit>(() => FeatureCubit(getIt()));
}
```

---

## 🎨 UI/UX Patterns

### Page Structure
```dart
class FeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeatureCubit>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<FeatureCubit, FeatureState>(
          builder: (context, state) => state.when(
            initial: () => _buildInitial(),
            loading: () => _buildLoading(),
            success: (data) => _buildSuccess(data),
            error: (message) => _buildError(message),
          ),
        ),
      ),
    );
  }
}
```

### Widget Composition
- **Principle**: Small, reusable widgets
- **Location**: `presentation/widgets/`
- **Naming**: Descriptive (e.g., `RecordingButton`, `SignAvatarDisplay`)

---

## 🔐 Security & Privacy

### Data Protection
- **Encryption**: AES-256 for local storage
- **Permissions**: Request only when needed (runtime permissions)
- **Privacy**: No data sent to external servers
- **Validation**: Input sanitization for all user inputs

### File Handling
- **Location**: Use `path_provider` for platform-specific paths
- **Verification**: SHA-256 checksums for downloaded models
- **Cleanup**: Automatic cleanup of temporary files

---

## 🧪 Testing Strategy

### Test Structure
```
test/
├── unit/              # Pure logic tests
├── widget/            # Widget tests
└── integration/       # E2E tests
```

### Mocking
- **Tool**: mockito
- **Generation**: `@GenerateMocks([ClassName])`
- **Location**: `*.mocks.dart` files (auto-generated)

### Coverage Goals
- **Core Logic**: 80%+ coverage
- **Services**: 70%+ coverage
- **UI**: 50%+ coverage

---

## 📦 Asset Management

### Model Files
- **Location**: `assets/models/`
- **Format**: `.tflite`, `.onnx`
- **Loading**: Lazy loading on first use
- **Updates**: Version-based with checksums

### Sign Language Data
- **Location**: `assets/signs/`
- **Format**: JSON dictionaries + video/animation files
- **Structure**: `{ "word": "path/to/sign.mp4" }`

### Localization
- **Location**: `assets/i18n/`
- **Format**: JSON per language
- **Fallback**: Arabic (primary), English (secondary)

---

## 🚀 Performance Optimization

### Key Principles
1. **Lazy Loading**: Load AI models only when needed
2. **Caching**: Cache translations and frequently used data
3. **Debouncing**: Debounce text input (300ms)
4. **Pagination**: Load sign animations in chunks
5. **Memory**: Dispose controllers and streams properly

### Critical Paths
- **STT Processing**: Max 3s for 10s audio
- **Sign Mapping**: Max 500ms for 50 words
- **Avatar Rendering**: 60 FPS target

---

## 🐛 Common Issues & Solutions

### Issue: Build Runner Conflicts
**Solution**: `flutter pub run build_runner build --delete-conflicting-outputs`

### Issue: Hive Box Already Open
**Solution**: Check if box is open before opening: `Hive.isBoxOpen(boxName)`

### Issue: Permission Denied (Audio)
**Solution**: Check `permission_handler` status before recording

### Issue: Model Loading Fails
**Solution**: Verify asset path in `pubspec.yaml` and file existence

---

## 🔄 Data Flow Examples

### Speech-to-Sign Translation Flow
```
1. User taps record button
   → RecordingCubit.startRecording()
   
2. Audio recorded to file
   → VoiceRecordingService.record()
   
3. Audio sent to STT
   → STTService.transcribe(audioPath)
   
4. Text normalized
   → NormalizationService.normalize(text)
   
5. Words mapped to signs
   → SignMappingService.mapToSigns(words)
   
6. Signs displayed via avatar
   → AvatarService.playSignSequence(signs)
   
7. Result cached
   → CacheService.saveTranslation(result)
```

---

## 📚 Key Dependencies

### Production
- `flutter_bloc: ^8.1.3` - State management
- `freezed: ^2.4.5` - Immutable models
- `get_it: ^7.6.4` - Dependency injection
- `hive: ^2.2.3` - Local database
- `record: ^5.0.4` - Audio recording
- `permission_handler: ^11.0.1` - Permissions

### Development
- `build_runner: ^2.4.6` - Code generation
- `mockito: ^5.4.2` - Testing mocks
- `flutter_test` - Testing framework

---

## 🌍 Localization

### Supported Languages
- **Primary**: Arabic (ar)
- **Secondary**: English (en)
- **Planned**: French (fr), Spanish (es)

### RTL Support
- **Enabled**: Full RTL support for Arabic
- **Detection**: Automatic based on locale
- **Testing**: Test both LTR and RTL layouts

---

## 🎯 MVP Scope (Current Phase)

### ✅ Completed
- Clean Architecture setup
- Audio recording
- STT integration (Whisper)
- Text normalization
- Sign mapping
- Local caching
- Settings page

### 🔄 In Progress
- Avatar animation display
- Home page UI
- Export/share functionality

### 🔮 Future
- Multiple sign language dialects
- Admin dashboard
- Cloud sync (optional)
- Web support (PWA)

---

## 💡 Development Guidelines

### Before Coding
1. Check if feature fits Clean Architecture
2. Identify which layer(s) need changes
3. Define interfaces before implementation
4. Consider offline-first approach

### During Coding
1. Follow existing patterns in similar features
2. Add logging for debugging
3. Handle errors gracefully
4. Write self-documenting code

### After Coding
1. Run `flutter analyze` (zero issues)
2. Test on both Android and iOS
3. Update this Memory Bank if needed
4. Add tests for critical paths

---

## 🔗 Important Files Reference

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, DI setup |
| `lib/config/service_locator.dart` | Dependency injection config |
| `lib/core/errors/failures.dart` | Error handling definitions |
| `lib/core/utils/logger.dart` | Logging utility |
| `pubspec.yaml` | Dependencies and assets |
| `.env` | Environment configuration |

---

## 📝 Code Review Checklist

- [ ] Follows Clean Architecture layers
- [ ] Uses dependency injection (GetIt)
- [ ] Implements error handling
- [ ] Includes logging for debugging
- [ ] Disposes resources properly
- [ ] Handles offline scenarios
- [ ] Follows naming conventions
- [ ] Passes `flutter analyze`
- [ ] Includes relevant tests
- [ ] Updates documentation

---

## 🤖 Custom Prompts للتطوير الفعّال

### الموقع
`.amazonq/prompts/`

### الملفات المتاحة

#### 1. `singai-optimizer.md` (400 توكن)
للتطوير اليومي والمهام المتوسطة إلى المعقدة.

**الاستخدام**:
```
@singai-optimizer اكتب service جديدة للتصدير
```

#### 2. `singai-quick.md` (200 توكن)
للأسئلة السريعة والمهام البسيطة.

**الاستخدام**:
```
@singai-quick كيف أضيف dependency؟
```

### Quick Commands
- `كود فقط` - كود بدون شرح
- `خطة` - خطوات بدون تنفيذ
- `مراجعة` - تحليل كود موجود
- `تحسين` - اقتراحات optimization

### أفضل الممارسات
1. استخدم `@filename` لتحديد الملفات المطلوبة فقط
2. كن محدداً في طلبك
3. استخدم Quick Commands عند الحاجة
4. راجع `.kiroignore` للملفات المستبعدة

### توفير التوكنات
- بدون prompt مخصص: ~1500 توكن/طلب
- مع singai-optimizer: ~600 توكن/طلب (60% توفير)
- مع singai-quick: ~300 توكن/طلب (80% توفير)

للمزيد من التفاصيل، راجع `.amazonq/prompts/README.md`

---

## 🤝 Contribution Context

### For New Contributors
1. Read this Memory Bank first
2. Review existing similar features
3. Follow the architecture patterns
4. Ask questions in GitHub Discussions

### For AI Assistants
- **Always** reference this Memory Bank for context
- **Maintain** consistency with existing patterns
- **Suggest** improvements aligned with project goals
- **Respect** the offline-first, privacy-focused approach

---

## 📅 Last Updated

**Date**: 2024  
**Version**: MVP Phase 3  
**Maintainer**: Project Contributors

---

**Note**: This Memory Bank is a living document. Update it when:
- Adding new architectural patterns
- Making significant technical decisions
- Discovering common issues/solutions
- Completing major milestones
