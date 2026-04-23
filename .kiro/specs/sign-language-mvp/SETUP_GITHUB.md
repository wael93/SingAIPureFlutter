# إنشاء مستودع GitHub - دليل خطوة بخطوة

## مقدمة

هذا الدليل يشرح كيفية إنشاء مستودع GitHub لمشروع نظام ترجمة الإشارة مع ضمان الأمان.

## الخطوة 1: إنشاء حساب GitHub (إذا لم يكن لديك)

1. اذهب إلى [github.com](https://github.com)
2. انقر على "Sign up"
3. أنشئ حساباً جديداً

## الخطوة 2: إنشاء مستودع جديد

1. سجل الدخول إلى GitHub
2. انقر على أيقونة "+" في الزاوية العلوية اليمنى
3. اختر "New repository"
4. املأ النموذج:

**Repository name:** `sign-language-translator-mvp`

**Description:** `Flutter app for sign language translation - Local-first MVP for NGOs`

**Privacy:** اختر "Public" (للعامة) أو "Private" (للمشروع الخاص)

5. انقر على "Create repository"

## الخطوة 3: إعداد المشروع محلياً

افتح Terminal وانتقل إلى مجلد المشروع:

```bash
cd /path/to/sign-language-mvp
```

## الخطوة 4: تهيئة Git

```bash
# تهيئة Git إذا لم يكن مهيأً
git init

# إضافة الملفات إلى التحكم في الإصدارات
git add .

# إنشاء أول كوميت
git commit -m "Initial commit: Project structure and configuration"
```

## الخطوة 5: ربط المستودع المحلي بـ GitHub

```bash
# أضف remote repository
git remote add origin https://github.com/YOUR_USERNAME/sign-language-translator-mvp.git

# ادفع الكود إلى GitHub
git push -u origin main
```

## الدفع التدريجي (Recommended)

بدلاً من دفع كل شيء دفعة واحدة، يمكنك الدفع على مراحل:

### الدفعة 1: البنية الأساسية

```bash
git add pubspec.yaml analysis_options.yaml README.md SECURITY.md
git commit -m "chore: add project configuration and documentation"
git push origin main
```

### الدفعة 2: البنية المعمارية

```bash
git add lib/main.dart lib/config/
git commit -m "feat: add main app and configuration layer"
git push origin main
```

### الدفعة 3: النطاق (Domain)

```bash
git add lib/domain/
git commit -m "feat: add domain layer with models and repositories"
git push origin main
```

### الدفعة 4: التطبيق (Application)

```bash
git add lib/application/
git commit -m "feat: add application layer services"
git push origin main
```

### الدفعة 5: العرض (Presentation)

```bash
git add lib/presentation/
git commit -m "feat: add presentation layer with UI"
git push origin main
```

### الدفعة 6: الاختبارات

```bash
git add test/
git commit -m "test: add unit and integration tests"
git push origin main
```

## التحقق من الأمان قبل كل دفعة

قبل كل دفعة، تأكد من عدم وجود ملفات حساسة:

```bash
# تحقق من الملفات التي سيتم رفعها
git status

# تحقق من المحتوى
git diff --cached

# تحقق من الملفات الكبيرة
git ls-files | xargs ls -lh
```

## ملف .gitignore

تم إنشاء ملف `.gitignore` يضمن عدم رفع:

- ✅ ملفات `.env` (البيانات الحساسة)
- ✅ ملفات النماذج الكبيرة (`.tflite`, `.bin`)
- ✅ المفاتيح والشهادات
- ✅ ملفات الإعداد الشخصية
- ✅ مجلدات الإنشاء (`build/`, `.dart_tool/`)

## نصائح الأمان

1. **لا ترفع أبداً:**
   - ملفات `.env` تحتوي على بيانات حقيقية
   - المفاتيح السرية (API Keys, Secrets)
   - الشهادات والملفات المشفرة

2. **استخدم `.gitignore`:**
   - تأكد من أن `.gitignore` محدث
   - تحقق من الملفات المهمة

3. **تحقق قبل الرفع:**
   ```bash
   # تحقق من الملفات التي سيتم رفعها
   git status
   
   # تحقق من المحتوى
   git diff --cached
   ```

4. **إذا رفعت بيانات حساسة عن طريق الخطأ:**
   - أوقف العملية فوراً
   - احذف الملف من الكوميت
   - استخدم `git reset` لإلغاء الكوميت
   - غيّر البيانات فوراً

## مثال على ملف .env آمن

```bash
# هذا الملف مهمل في .gitignore
# استخدم هذا كنموذج فقط

# إعدادات التطوير (بدون بيانات حقيقية)
API_KEY=your_api_key_here
DATABASE_URL=your_database_url_here
```

## متابعة التطوير

بعد إنشاء المستودع:

1. أنشئ فروعاً (branches) للميزات الجديدة
2. ادفع التغييرات بشكل متكرر
3. اكتب رسائل كوميت واضحة
4. استخدم Pull Requests للمراجعة

## مصادر إضافية

- [GitHub Docs](https://docs.github.com)
- [Git Book](https://git-scm.com/book/en/v2)
- [Flutter Documentation](https://flutter.dev/docs)
