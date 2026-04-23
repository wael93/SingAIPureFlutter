import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/dependencies.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  // STARTUP: Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // FALLBACK: Wrap initialization in error boundary
  try {
    // Initialize Hive for local storage
    await Hive.initFlutter();
    
    // Initialize dependency injection
    await initializeDependencies();
    
    runApp(const SignLanguageApp());
  } catch (e, stackTrace) {
    // FALLBACK: Show error screen if initialization fails
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'فشل تشغيل التطبيق',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
    debugPrint('Startup error: $e\n$stackTrace');
  }
}

class SignLanguageApp extends StatelessWidget {
  const SignLanguageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Language Translator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
        ),
      ),
      home: const HomePage(),
    );
  }
}
