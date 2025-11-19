# 🚀 Setup Guide

Complete guide to set up and run the Smart Attendance System on your local machine.

## 📋 Prerequisites

### Required Software
1. **Flutter SDK** (3.9.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter --version`

2. **Android Studio** or **VS Code**
   - Android Studio: https://developer.android.com/studio
   - VS Code: https://code.visualstudio.com/

3. **Git**
   - Download from: https://git-scm.com/downloads
   - Verify installation: `git --version`

4. **Firebase Account**
   - Create account at: https://firebase.google.com/

### Optional Tools
- Android Emulator or Physical Device
- iOS Simulator (Mac only)
- Xcode (Mac only, for iOS development)

## 🔧 Installation Steps

### 1. Clone the Repository

```bash
# Clone the repository
git clone https://github.com/yourusername/attendance-app.git

# Navigate to project directory
cd attendance-app
```

### 2. Install Flutter Dependencies

```bash
# Get all dependencies
flutter pub get

# Verify no issues
flutter doctor
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name (e.g., "attendance-app")
4. Disable Google Analytics (optional)
5. Click "Create Project"

#### Enable Firestore Database
1. In Firebase Console, go to "Firestore Database"
2. Click "Create Database"
3. Select "Start in test mode"
4. Choose your location
5. Click "Enable"

#### Configure Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /attendance/{document} {
      allow read, write: if true; // Change this for production
    }
  }
}
```

### 4. Android Configuration

#### Add Android App to Firebase
1. In Firebase Console, click "Add App" → Android
2. Enter package name: `com.example.attendance_app`
3. Download `google-services.json`
4. Place file in: `android/app/google-services.json`

#### Update build.gradle Files

**android/build.gradle**
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

**android/app/build.gradle**
```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

#### Add Permissions

**android/app/src/main/AndroidManifest.xml**
```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    
    <application>
        <!-- Your app configuration -->
    </application>
</manifest>
```

### 5. iOS Configuration (Mac Only)

#### Add iOS App to Firebase
1. In Firebase Console, click "Add App" → iOS
2. Enter bundle ID: `com.example.attendanceApp`
3. Download `GoogleService-Info.plist`
4. Place file in: `ios/Runner/GoogleService-Info.plist`

#### Update Info.plist

**ios/Runner/Info.plist**
```xml
<dict>
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to capture attendance photos</string>
    
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs location access to record attendance location</string>
    
    <key>NSLocationAlwaysUsageDescription</key>
    <string>This app needs location access to record attendance location</string>
</dict>
```

#### Install Pods
```bash
cd ios
pod install
cd ..
```

### 6. Update Firebase Configuration

**lib/main.dart**
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
  ),
);
```

Replace with your Firebase project credentials from:
- Firebase Console → Project Settings → General

## 🏃 Running the App

### Check Connected Devices
```bash
flutter devices
```

### Run on Android
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

### Run on iOS (Mac Only)
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

### Run on Specific Device
```bash
flutter run -d <device_id>
```

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Check for Issues
```bash
flutter analyze
```

### Format Code
```bash
flutter format .
```

## 📱 Building Release

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS (Mac Only)
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Common Issues

#### 1. Firebase Connection Failed
**Problem**: App can't connect to Firebase
**Solution**:
- Verify `google-services.json` is in correct location
- Check Firebase configuration in `main.dart`
- Ensure internet connection is available

#### 2. Camera Not Working
**Problem**: Camera doesn't open or crashes
**Solution**:
- Check camera permissions in AndroidManifest.xml
- Verify device has camera
- Test on physical device (emulator cameras can be unreliable)

#### 3. Location Not Working
**Problem**: Can't get user location
**Solution**:
- Check location permissions
- Enable location services on device
- Test on physical device with GPS

#### 4. Face Detection Not Working
**Problem**: Face detection fails
**Solution**:
- Ensure good lighting
- Face should be clearly visible
- Update Google ML Kit dependencies

#### 5. Build Errors
**Problem**: Build fails with errors
**Solution**:
```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

### Get Help
- Check [Flutter Documentation](https://flutter.dev/docs)
- Visit [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- Open an issue on GitHub

## 📚 Additional Resources

### Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [Firebase Docs](https://firebase.google.com/docs)
- [Dart Docs](https://dart.dev/guides)

### Tutorials
- [Flutter Codelabs](https://flutter.dev/docs/codelabs)
- [Firebase Tutorials](https://firebase.google.com/docs/tutorials)

### Community
- [Flutter Community](https://flutter.dev/community)
- [Firebase Community](https://firebase.google.com/community)

## ✅ Verification Checklist

Before running the app, ensure:
- [ ] Flutter SDK installed and configured
- [ ] Firebase project created
- [ ] Firestore database enabled
- [ ] Android/iOS app added to Firebase
- [ ] Configuration files in correct locations
- [ ] Permissions added to manifest files
- [ ] Dependencies installed (`flutter pub get`)
- [ ] No errors in `flutter doctor`
- [ ] Device/emulator connected

## 🎉 Success!

If everything is set up correctly, you should see:
1. Splash screen with animation
2. Home screen with statistics
3. Ability to check in with camera
4. Location tracking working
5. Data saving to Firebase

---

Need help? Open an issue on GitHub or contact the developer.

**Happy Coding! 🚀**
