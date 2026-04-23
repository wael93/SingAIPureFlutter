# دليل البدء السريع - نظام ترجمة الإشارة

## نظرة عامة

هذا الدليل يشرح كيفية إنشاء مستودع GitHub ورفع الكود بالتدريج مع ضمان الأمان.

## الخطوات السريعة

### 1. إنشاء المستودع على GitHub

1. اذهب إلى [github.com](https://github.com)
2. انقر على "+" → "New repository"
3. املأ البيانات:
   - **Name:** `sign-language-translator-mvp`
   - **Description:** `Flutter app for sign language translation`
   - **Privacy:** Public أو Private
4. انقر على "Create repository"

### 2. ربط المشروع بـ GitHub

```bash
# انتقل إلى مجلد المشروع
cd /path/to/sign-language-mvp

# تهيئة Git
git init

# إضافة remote
git remote add origin https://github.com/YOUR_USERNAME/sign-language-translator-mvp.git

# رفع الكود
git add .
git commit -m "chore: initial project structure"
git push -u origin main
```

### 3. الدفع التدريجي (موصى به)

بدلاً من دفع كل شيء دفعة واحدة، استخدم هذه الأوامر:

```bash
# الدفعة 1: التكوين
git add pubspec.yaml analysis_options.yaml README.md SECURITY.md
git commit -m "chore: add project configuration and documentation"
git push origin main

# الدفعة 2: البنية الأساسية
git add lib/main.dart lib/config/
git commit -m "feat: add main app and configuration layer"
git push origin main

# الدفعة 3: النطاق
git add lib/domain/
git commit -m "feat: add domain layer with models and repositories"
git push origin main

# الدفعة 4: التطبيق
git add lib/application/
git commit -m "feat: add application layer services"
git push origin main

# الدفعة 5: العرض
git add lib/presentation/
git commit -m "feat: add presentation layer with UI"
git push origin main
```

## التحقق من الأمان

### قبل كل دفعة:

```bash
# تحقق من الملفات التي سيتم رفعها
git status

# تحقق من المحتوى
git diff --cached

# تحقق من عدم وجود ملفات .env
ls -la | grep .env
```

### ملفات آمنة للرفع:

- ✅ جميع ملفات `.dart` في `lib/`
- ✅ `pubspec.yaml`
- ✅ `analysis_options.yaml`
- ✅ `README.md`
- ✅ `SECURITY.md`
- ✅ ملفات التصميم والمتطلبات

### ملفات **غير** آمنة للرفع:

- ❌ ملفات `.env` (تحتوي على بيانات حساسة)
- ❌ المفاتيح السرية (API Keys, Secrets)
- ❌ ملفات النماذج الكبيرة (`.tflite`, `.bin`)
- ❌ الشهادات والملفات المشفرة

## ملاحظات مهمة

1. **التطبيق يعمل محلياً**: لا توجد بيانات تُرسل للخوادم
2. **النماذج محلية**: جميع النماذج مخزنة على الجهاز
3. **لا توجد مفاتيح API**: لا توجد مفاتيح API مطلوبة للنسخة الأولية
4. **التشفير**: يتم باستخدام مفاتيح الجهاز الأصلية

## مصادر إضافية

- `SETUP_GITHUB.md`: دليل مفصل لإنشاء المستودع
- `SECURITY.md`: إرشادات الأمان
- `README.md`: وثائق المشروع

## الدعم

لأي أسئلة، راجع ملفات الوثائق أو افتح مشكلة في GitHub.
