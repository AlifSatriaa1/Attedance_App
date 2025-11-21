import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance_app/ui/splash/splash_screen.dart';
import 'package:attendance_app/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyARQomvP-ekwFCs2kaI-YlIlGqMtLZI3ic',
        appId: '1:751508408499:android:28e3766e70b2f983f7c8c6',
        messagingSenderId: '751508408499',
        projectId: 'idn1-fc3fc',
      ),
    );
    print("Firebase Connected Successfully");
    print("Project ID: ${Firebase.app().options.projectId}");
  } catch (e) {
    print("Firebase connection failed: $e");
  }
  runApp(const PresenceApp());
}

class PresenceApp extends StatelessWidget {
  const PresenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance System',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // You can change to ThemeMode.system for auto dark mode
      home: const SplashScreen(),
    );
  }
}
