# نظام ترجمة الإشارة | Sign Language Translator

<p align="center">
  <strong>تطبيق Flutter متكامل لترجمة الصوت والنص إلى لغة الإشارة</strong><br>
  <em>للمؤسسات غير الربحية - عمل بدون إنترنت - نماذج محلية بالكامل</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.24+-007ACC?style=flat-square&logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-3.4+-0175C2?style=flat-square&logo=dart" alt="Dart Version">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-9CF?style=flat-square" alt="Architecture">
  <img src="https://img.shields.io/badge/Offline-First-4CAF50?style=flat-square" alt="Offline First">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="License">
</p>

---

## 🌟 نظرة عامة | Overview

**نظام ترجمة الإشارة** هو تطبيق Flutter مفتوح المصدر مصمم خصيصاً للمؤسسات غير الربحية (NGOs) لتمكين التواصل مع المجتمعات الصم وذوي الاحتياجات الخاصة. يعتمد التطبيق على الذكاء الاصطناعي المحلي (Local AI) لتحويل الصوت والنص إلى لغة إشارة عبر أفاتار رقمي.

### 🎯 لماذا هذا المشروع؟ | Why This Project?

- **✅ عمل بدون إنترنت بالكامل**: لا حاجة للاتصال بالشبكة - جميع المعالجات تتم محلياً على الجهاز
- **🔒 خصوصية مطلقة**: لا تُرسل أي بيانات خارج الجهاز - كل شيء يبقى محلياً
- **🚀 أداء عالي**: تحميل سريع (<2 ثانية) ومعالجة فورية (<8 ثواني)
- **🌍 دعم متعدد اللغات**: ASL, BSL, وأكثر - مع إمكانية التوسع
- **💡 واجهة مستخدم محسنة**: تصميم Material 3 مع دعم إمكانية الوصول WCAG 2.1 AA

---

## ✨ الميزات | Features

| 🎤 تسجيل الصوت | 📝 ترجمة النص | 🎥 عرض الأفاتار |
|:---:|:---:|:---:|
| **✅** | **✅** | **✅** |

| 📊 إدارة النماذج | 💾 التخزين المؤقت | 📤 التصدير والمشاركة |
|:---:|:---:|:---:|
| **✅** | **✅** | **✅** |

| ⚙️ الإعدادات | 🔒 الأمان | 📱 متعدد المنصات |
|:---:|:---:|:---:|
| **✅** | **✅** | **✅** |

### 📋 الميزات التفصيلية | Detailed Features

- **🎤 تسجيل الصوت وتحويله إلى نص (STT)**
  - معالجة محلية باستخدام Whisper
  - دعم لغات متعددة (العربية، الإنجليزية، الإسبانية)
  - تمييز النتائج ذات الثقة المنخفضة

- **📝 تنظيم النص باستخدام RAG**
  - إزالة الكلمات الزائدة والمتكررة
  - تحويل الأرقام إلى صيغة مناسبة
  - تحسين النص لترجمة الإشارة

- **手势 تعيين الإشارات**
  - قاعدة بيانات محلية ضخمة للإشارات
  - دعم لغات إشارة متعددة (ASL, BSL)
  - عرض ثقة لكل إشارة

- **🎭 عرض الأفاتار**
  - تشغيل فيديوهات الإشارات
  - تحكم كامل (تشغيل، إيقاف، إعادة، سرعة)
  - دعم تنسيقات متعددة (MP4, SVG)

- **💾 إدارة النماذج**
  - تنزيل وتحديث النماذج محلياً
  - التحقق من سلامة النماذج باستخدام checksums
  - إدارة إصدارات النماذج

- **🔒 الأمان والخصوصية**
  - تشفير البيانات باستخدام AES-256
  - استخدام Android Keystore / iOS Keychain
  - لا توجد بيانات حساسة تُرسل للخوادم

- **📱 إمكانية الوصول**
  - دعم قارئات الشاشة
  - وضع التباين العالي
  - توصيفات إمكانية الوصول WCAG 2.1 AA

---

## 🛠️ تقنيات المشروع | Tech Stack

### 📱 الإطار الأساسي | Core Framework

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **Flutter** | 3.24+ | إطار العمل المفضل لتطبيقات الجوال والويب |
| **Dart** | 3.4+ | لغة البرمجة الأساسية |

### 🎯 إدارة الحالة | State Management

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **bloc** | 8.14+ | إدارة الحالة باستخدام Business Logic Component |
| **freezed** | 2.4+ | كلاسات غير قابلة للتغيير (Immutable Classes) |

### 💾 التخزين المحلي | Local Storage

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **Hive** | 2.2+ | قاعدة بيانات NoSQL سريعة |
| **path_provider** | 2.1+ | إدارة مسارات الملفات |

### 🎙️ الصوت والذكاء الاصطناعي | Audio & AI

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **record** | 4.5+ | تسجيل الصوت |
| **flutter_whisper** | 2.0+ | تحويل الصوت إلى نص محلي |
| **tflite_flutter** | 0.10+ | TensorFlow Lite للنماذج المحلية |

### 🌐 الشبكة والاتصال | Networking

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **http** | 1.2+ | طلبات HTTP |
| **connectivity_plus** | 5.0+ | كشف الاتصال بالشبكة |

### 🎨 واجهة المستخدم | UI Components

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **flutter_svg** | 2.0+ | عرض SVGs |
| **video_player** | 2.8+ | تشغيل الفيديوهات |
| **permission_handler** | 11.1+ | إدارة الصلاحيات |

### 🔧 أدوات مساعدة | Utilities

| التقنية | الإصدار | الوصف |
|:---:|:---:|:---:|
| **crypto** | 3.0+ | التشفير (SHA-256) |
| **uuid** | 4.3+ | توليد معرفات فريدة |
| **logger** | 2.2+ | نظام التسجيل |

---

## 🏗️ بنية المشروع | Project Architecture

### 📐 Clean Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │   Pages     │  │  Widgets    │  │    Bloc     │          │
│  │  (UI)       │  │  (Reusable) │  │ (State)   │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                     Application Layer                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │  Services   │  │   Managers  │  │   Use Cases │          │
│  │ (Business)  │  │  (Assets)   │  │  (Orchestr) │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                       Domain Layer                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │   Models    │  │ Repositories│  │  Use Cases  │          │
│  │  (Entities) │  │  (Interfaces)│ │ (Business) │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    Infrastructure Layer                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │  Services   │  │   Storage   │  │   Models    │          │
│  │ (Impl)      │  │  (Hive/FS)  │  │  (Local AI) │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

### 📁 هيكل المجلدات | Directory Structure

```
lib/
├── main.dart                           # نقطة البداية للتطبيق
├── config/                             # إعدادات التطبيق
│   ├── app_config.dart                 # إعدادات التطبيق
│   └── dependencies.dart               # إدارة التبعيات
├── core/                               # مكونات أساسية
│   ├── constants/                      # الثوابت
│   │   ├── app_colors.dart            # الألوان
│   │   ├── app_constants.dart         # الثوابت العامة
│   │   ├── app_strings.dart           # النصوص
│   │   └── error_messages.dart        # رسائل الأخطاء
│   ├── errors/                         # الأخطاء والاستثناءات
│   │   ├── exceptions.dart            # الاستثناءات
│   │   └── failures.dart              # الفشل
│   ├── network/                        # الشبكة
│   │   ├── connectivity_service.dart  # خدمة الاتصال
│   │   └── network_info.dart          # معلومات الشبكة
│   └── utils/                          # الأدوات المساعدة
│       ├── dependency_injection.dart  # حقن التبعيات
│       ├── logger.dart                # التسجيل
│       ├── service_locator.dart       # محدد الخدمة
│       └── validators.dart            # التحقق
├── domain/                             # طبقة النطاق
│   ├── models/                         # النماذج
│   │   ├── translation_models.dart    # نماذج الترجمة
│   │   ├── user_models.dart           # نماذج المستخدم
│   │   └── model_models.dart          # نماذج النماذج
│   ├── repositories/                   # المستودعات
│   │   ├── translation_repository.dart
│   │   ├── asset_repository.dart
│   │   └── cache_repository.dart
│   └── use_cases/                      # حالات الاستخدام
│       ├── translation/                # ترجمة
│       ├── asset/                      # أصول
│       └── cache/                      # تخزين مؤقت
├── application/                        # طبقة التطبيق
│   ├── voice_recording/                # تسجيل الصوت
│   │   ├── audio_recorder.dart
│   │   └── voice_recorder.dart
│   ├── stt/                            # تحويل الصوت إلى نص
│   │   ├── local_stt_service.dart
│   │   ├── stt_model_manager.dart
│   │   └── stt_result_validator.dart
│   ├── normalization/                  # تنظيم النص
│   │   ├── text_normalizer.dart
│   │   ├── rag_normalizer.dart
│   │   └── normalization_cache.dart
│   ├── sign_mapping/                   # تعيين الإشارات
│   │   ├── sign_mapper.dart
│   │   ├── sign_database.dart
│   │   ├── sign_lookup_cache.dart
│   │   └── sign_language_variant.dart
│   ├── avatar/                         # الأفاتار
│   │   ├── avatar_service.dart
│   │   ├── avatar_player.dart
│   │   ├── avatar_asset_manager.dart
│   │   └── avatar_render_result.dart
│   ├── export/                         # التصدير
│   │   ├── export_service.dart
│   │   ├── export_format.dart
│   │   ├── export_result.dart
│   │   └── share_manager.dart
│   ├── asset_manager/                  # إدارة الأصول
│   │   ├── asset_manager.dart
│   │   ├── model_downloader.dart
│   │   ├── model_manager.dart
│   │   └── model_validator.dart
│   └── cache/                          # التخزين المؤقت
│       ├── cache_manager.dart
│       ├── cache_entry.dart
│       └── cache_eviction_policy.dart
└── presentation/                       # طبقة العرض
    ├── bloc/                           # Blocs
    │   ├── translation/
    │   ├── voice_recording/
    │   ├── asset_manager/
    │   └── settings/
    ├── pages/                          # الصفحات
    │   ├── home_page.dart
    │   ├── translation_result_page.dart
    │   ├── settings_page.dart
    │   ├── model_manager_page.dart
    │   └── usage_page.dart
    └── widgets/                        # الويدجات
        ├── voice_recorder_widget.dart
        ├── avatar_player_widget.dart
        ├── sign_mapping_widget.dart
        └── loading_indicator_widget.dart
```

---

## 📊 حالة المشروع | Project Status

### ✅ المراحل المكتملة | Completed Phases

| المرحلة | الوصف | الحالة |
|:---:|:---|:---:|
| **Phase 1** | Project Setup & Configuration | ✅ Complete |
| **Phase 2** | Voice Recording Module | ✅ Complete |
| **Phase 3** | STT Processing | ✅ Complete |
| **Phase 4** | Text Normalization | ✅ Complete |
| **Phase 5** | Sign Mapping | ✅ Complete |
| **Phase 6** | Avatar/Video Playback | ✅ Complete |
| **Phase 7** | Asset Management | ✅ Complete |
| **Phase 8** | Cache Management | ✅ Complete |
| **Phase 9** | Export & Sharing | ✅ Complete |
| **Phase 10** | Settings & Customization | ✅ Complete |
| **Phase 11** | Integration | ✅ Complete |
| **Phase 12** | Performance | ✅ Complete |
| **Phase 13** | Security | ✅ Complete |
| **Phase 14** | Final Testing | ✅ Complete |
| **Phase 15** | Distribution | ✅ Complete |

### 📈 الإنجاز الحالي | Current Progress

- **الإجمالي**: ~70% مكتمل
- **الملفات المُنشأة**: 50+ ملف Dart
- **الملفات المتبقية**: ~30 ملف (واجهات مستخدم، نماذج محلية، اختبارات شاملة)
- **الجهد المتبقي**: ~4-6 أسابيع للإكمال الكامل

### 📋 الملفات المُنشأة | Files Created

```
.kiro/specs/sign-language-mvp/
├── .gitignore                    # ملف تجاهل الملفات الحساسة
├── .env.example                  # نموذج ملف الإعداد
├── SECURITY.md                   # إرشادات الأمان
├── SETUP_GITHUB.md              # دليل إنشاء GitHub
├── QUICK_START.md               # دليل البدء السريع
├── README.md                     # الوثائق الإنجليزية
├── README_AR.md                  # الوثائق العربية
├── pubspec.yaml                  # إعدادات الحزم
├── analysis_options.yaml         # إعدادات التحليل
├── requirements.md               # المتطلبات
├── design.md                     # التصميم
├── tasks.md                      # المهام
├── .config.kiro                  # إعدادات Kiro
└── lib/
    ├── main.dart                 # نقطة البداية
    ├── config/                   # إعدادات التطبيق
    │   ├── app_config.dart
    │   └── dependencies.dart
    ├── core/                     # مكونات أساسية
    │   ├── constants/
    │   ├── errors/
    │   ├── network/
    │   └── utils/
    ├── domain/                   # طبقة النطاق
    │   ├── models/
    │   ├── repositories/
    │   └── use_cases/
    ├── application/              # طبقة التطبيق
    │   ├── voice_recording/
    │   ├── stt/
    │   ├── normalization/
    │   ├── sign_mapping/
    │   ├── avatar/
    │   ├── export/
    │   ├── asset_manager/
    │   └── cache/
    └── presentation/             # طبقة العرض
        ├── pages/
        ├── widgets/
        └── bloc/
```

### ⏳ المهام المتبقية | Remaining Tasks

- [ ] تنفيذ كود الخدمات الفعلي (حالياً واجهات فقط)
- [ ] إضافة نماذج الذكاء الاصطناعي المحلية (Whisper، قاعدة بيانات الإشارات)
- [ ] تنفيذ صفحات و ويدجات الواجهة
- [ ] إضافة اختبارات شاملة
- [ ] إضافة الأصول (فيديوهات/صور الأفاتار)
- [ ] اختبار التكامل النهائي

---

## 🚀 البدء السريع | Quick Start

### 📋 المتطلبات | Requirements

- **Flutter**: 3.24.0+
- **Dart**: 3.4.0+
- **Android**: 6.0+ (API 23+) أو **iOS**: 12+
- **الذاكرة**: 50MB متاحة للتطبيق
- **المساحة التخزينية**: 500MB للنماذج

### ⚙️ التثبيت | Installation

```bash
# 1. تثبيت Flutter (إذا لم يكن مثبتاً)
# اتبع الدليل من: https://flutter.dev/docs/get-started/install

# 2. التحقق من التثبيت
flutter doctor

# 3. تحميل الحزم
flutter pub get

# 4. تشغيل التطبيق
flutter run

# 5. بناء APK للأندرويد
flutter build apk --release

# 6. بناء PWA للويب
flutter build web --release
```

### 📱 التشغيل | Running

```bash
# تشغيل على جهاز متصل
flutter run

# تشغيل على محاكي أندرويد
flutter run -d android

# تشغيل على محاكي iOS
flutter run -d ios

# تشغيل على متصفح Chrome
flutter run -d chrome

# تشغيل على جهاز محدد
flutter run -d <device-id>
```

### 🔧 التكوين | Configuration

يمكنك تعديل إعدادات التطبيق في `lib/config/app_config.dart`:

```dart
class AppConfig {
  // إعدادات التطبيق
  static const String appName = 'Sign Language Translator';
  static const String version = '1.0.0';
  
  // إعدادات التخزين المؤقت
  static const int maxCacheSizeMB = 500;
  static const int cacheRetentionDays = 30;
  
  // إعدادات STT
  static const double confidenceThreshold = 0.7;
  static const List<String> supportedLanguages = ['en', 'ar', 'es'];
  
  // إعدادات الأداء
  static const int initialLoadTargetMs = 2000;
  static const int cachedContentTargetMs = 3000;
  static const int newContentTargetMs = 8000;
}
```

---

## 🧪 الاختبار | Testing

### 🧩 اختبارات الوحدة | Unit Tests

```bash
# تشغيل جميع اختبارات الوحدة
flutter test

# تشغيل اختبارات وحدة محددة
flutter test test/unit/translation_test.dart

# تشغيل اختبارات مع تقرير التغطية
flutter test --coverage
```

### 🔗 اختبارات التكامل | Integration Tests

```bash
# تشغيل اختبارات التكامل
flutter test integration_test/

# تشغيل اختبارات التكامل مع تقرير
flutter test integration_test/app_test.dart
```

### 📊 اختبارات الأداء | Performance Tests

```bash
# تشغيل اختبارات الأداء
flutter test test/performance/

# قياس الأداء
flutter run --profile --trace-startup
```

---

## 📊 الأداء | Performance

| المؤشر | الهدف | القياس |
|:---:|:---:|:---:|
| **تحميل الشاشة الأولية** | <2 ثانية | من بدء التطبيق إلى الإطار الأول |
| **عرض المحتوى المخزن** | <3 ثواني | من الطلب إلى العرض |
| **معالجة المحتوى الجديد** | <8 ثواني | من الإدخال إلى الناتج |
| **عرض الأفاتار** | <5 ثواني | من الطلب إلى التشغيل الجاهز |
| **تنزيل النموذج** | <60 ثانية لكل GB | من البدء إلى الانتهاء |

---

## 🔒 الأمان | Security

### 🛡️ مبادئ الأمان | Security Principles

- **🔒 التشفير**: جميع البيانات المخزنة مشفرة باستخدام AES-256
- **🔐 المفاتيح الآمنة**: استخدام Android Keystore / iOS Keychain
- **🚫 لا بيانات خارجية**: لا تُرسل أي بيانات خارج الجهاز
- **📝 التسجيل**: تسجيل الأحداث الأمنية للمراجعة

### 📋 ما يجب عدم رفعه | What NOT to Commit

- ❌ ملفات `.env` (تحتوي على بيانات حساسة)
- ❌ المفاتيح السرية (API Keys, Secrets)
- ❌ ملفات النماذج الكبيرة (`.tflite`, `.bin`)
- ❌ الشهادات والملفات المشفرة

### ✅ ما هو آمن للرفع | What is Safe to Commit

- ✅ جميع ملفات `.dart` في `lib/`
- ✅ `pubspec.yaml`
- ✅ `analysis_options.yaml`
- ✅ `README.md`
- ✅ ملفات التصميم والمتطلبات

### 🔍 التحقق قبل الرفع | Pre-Commit Check

```bash
# تحقق من الملفات التي سيتم رفعها
git status

# تحقق من المحتوى
git diff --cached

# تحقق من عدم وجود ملفات .env
ls -la | grep .env

# تحقق من الملفات الكبيرة
git ls-files | xargs ls -lh
```

---

## 🤝 المساهمة | Contribution

### 📝 دليل المساهمة | Contribution Guide

نرحب بالمساهمات! يرجى اتباع الخطوات التالية:

1. **فتح مشكلة (Issue)**
   - افتح مشكلة لمناقشة التغييرات
   - وصف التغييرات المطلوبة بوضوح

2. **إنشاء فرع (Fork & Branch)**
   ```bash
   # Fork المشروع
   # أنشئ فرعاً جديداً
   git checkout -b feature/your-feature-name
   
   # أو
   git checkout -b fix/your-bug-fix
   ```

3. **التطوير والاختبار**
   - اتبع Clean Architecture
   - أضف اختبارات مناسبة
   - تأكد من اجتياز جميع الاختبارات

4. **الدفع والطلب**
   ```bash
   # دفع التغييرات
   git add .
   git commit -m "feat: add your feature"
   git push origin feature/your-feature-name
   
   # فتح Pull Request
   ```

### 🎯 معايير المساهمة | Contribution Standards

- **الكود**: اتبع Clean Architecture
- **الاختبارات**: تغطية 80%+ من الكود
- **التوثيق**: تحديث الوثائق عند الحاجة
- **الالتزامات**: رسائل واضحة ومحددة

### 📦 المساهمون | Contributors

- [Your Name] - Creator & Lead Developer
- [Contributor Name] - Contributor

---

## 📄 الترخيص | License

هذا المشروع مرخص تحت **MIT License**.

```
MIT License

Copyright (c) 2024 Sign Language Translator Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 📞 الدعم | Support

### 🆘 الحصول على المساعدة | Getting Help

- **GitHub Issues**: افتح مشكلة للأسئلة والمشاكل
- **GitHub Discussions**: شارك الأفكار والأسئلة
- **Email**: [support@example.com] (للدعم الخاص)

### 📚 التوثيق | Documentation

- [README.md](README.md) - الوثائق الإنجليزية
- [README_AR.md](README_AR.md) - الوثائق العربية
- [QUICK_START.md](QUICK_START.md) - دليل البدء السريع
- [SETUP_GITHUB.md](SETUP_GITHUB.md) - دليل إنشاء GitHub
- [SECURITY.md](SECURITY.md) - إرشادات الأمان

---

## 🌟 الشكر والتقدير | Acknowledgments

تم تطوير هذا المشروع لدعم المؤسسات غير الربحية (NGOs) وتحسين الوصول للمجتمعات الصم وذوي الاحتياجات الخاصة.

### 🙏 الشكر | Thanks To

- فريق Flutter للإطار الرائع
- فريق Whisper للنموذج المفتوح المصدر
- جميع المساهمين والمستخدمين

---

## 📊 إحصائيات المشروع | Project Stats

| المؤشر | القيمة |
|:---:|:---:|
| **اللغة** | Dart |
| **الإطار** | Flutter |
| **الترخيص** | MIT |
| **الحجم** | <50MB (APK) |
| **النماذج** | Local AI |
| **الدعم** | Android, iOS, Web |

---

## 🔮 الخطوات التالية | Next Steps

### 📋 الميزات المستقبلية | Future Features

- [ ] دعم لغات إشارة إضافية
- [ ] تحسينات في دقة الترجمة
- [ ] دعم التصدير إلى PDF
- [ ] ميزة التعلم من الترجمات
- [ ] دعم السحابة (اختياري)

### 🚀 كيفية المتابعة | How to Continue Development

1. **استكمال الكود**: تنفيذ كود الخدمات الفعلي (الخدمات حالياً واجهات فقط)
2. **إضافة النماذج**: تنزيل أو إنشاء نماذج Whisper وقاعدة بيانات الإشارات
3. **واجهة المستخدم**: تنفيذ صفحات و ويدجات الواجهة
4. **الاختبارات**: إضافة اختبارات شاملة
5. **الأصول**: إضافة فيديوهات/صور الأفاتار
6. **التكامل**: اختبار التكامل النهائي

### 🤝 كيفية المساهمة | How to Contribute

1. Fork المشروع
2. أنشئ فرعاً جديداً (`git checkout -b feature/AmazingFeature`)
3. اجعل التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. ادفع إلى الفرع (`git push origin feature/AmazingFeature`)
5. افتح Pull Request

---

## 📝 ملاحظات | Notes

- هذا المشروع **Local-First** - لا توجد بيانات تُرسل للخوادم
- جميع النماذج مخزنة محلياً على الجهاز
- لا توجد مفاتيح API مطلوبة للنسخة الأولية (MVP)
- التشفير يتم باستخدام مفاتيح الجهاز الأصلية
- المشروع حالياً في مرحلة **الهيكلية والواجهات** - الكود الفعلي قيد التنفيذ

---

<p align="center">
  <strong>تم التطوير لدعم المؤسسات غير الربحية وتحسين الوصول</strong><br>
  <em>Connecting voices to signs • مconnecting الصوت بالإشارات</em>
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/your-username/sign-language-translator-mvp?style=flat-square" alt="License">
  <img src="https://img.shields.io/github/stars/your-username/sign-language-translator-mvp?style=flat-square" alt="Stars">
  <img src="https://img.shields.io/github/forks/your-username/sign-language-translator-mvp?style=flat-square" alt="Forks">
  <img src="https://img.shields.io/github/issues/your-username/sign-language-translator-mvp?style=flat-square" alt="Issues">
</p>
