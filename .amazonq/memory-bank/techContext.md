# Tech Context — SingAI

## Stack
| Layer | Technology |
|---|---|
| Framework | Flutter 3.24+ / Dart 3.4+ |
| State management | flutter_bloc ^8.14.0 |
| DI | get_it ^7.6.0 |
| Local DB | hive ^2.2.3 + hive_flutter ^1.1.0 |
| STT | flutter_whisper ^2.0.0 |
| ML inference | tflite_flutter ^0.10.4 |
| Audio recording | record ^4.5.0 |
| Video playback | video_player ^2.8.0 |
| SVG rendering | flutter_svg ^2.0.9 |
| Networking | http ^1.2.0 + connectivity_plus ^5.0.2 |
| Permissions | permission_handler ^11.1.0 |
| Crypto | crypto ^3.0.3 |
| Logging | logger ^2.2.0 |
| Code gen | freezed ^2.4.0 + build_runner 2.4.7+ |
| Unique IDs | uuid ^4.3.3 |

## Build / Code Generation
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## App Config Highlights (`AppConfig`)
- `confidenceThreshold`: 0.7
- `supportedLanguages`: ['en', 'ar', 'es']
- `maxCacheSizeMB`: 500, `cacheRetentionDays`: 30
- `monthlyUsageLimit`: 1000 (NGO usage cap)
- Performance targets: initial load 2 s, cached 3 s, new content 8 s, avatar render 5 s
- Feature flags: `enableAnalytics=false`, `enableCache=true`, `enableCloudSync=false`

## Platform Targets
- Android API 21+
- iOS 12+

## Package Name
`sign_language_mvp` (pubspec.yaml)
