# 📱 Smart Attendance System

A modern and elegant attendance tracking application built with Flutter and Firebase. This app features face detection, geolocation tracking, and real-time data synchronization.

## ✨ Features

### Core Features
- 🎯 **Face Detection Check-in**: Secure attendance with ML Kit face detection
- 📍 **Geolocation Tracking**: Automatic location capture with address details
- ⏰ **Smart Status Detection**: Automatic status (On Time/Late/Leave) based on check-in time
- 📊 **Real-time Statistics**: Live attendance data with Firebase Firestore
- 📜 **Attendance History**: Complete record of all attendance entries
- 🔔 **Recent Activity**: Quick view of latest check-ins

### UI/UX Features
- 🎨 **Modern Material Design**: Clean and intuitive interface
- 🌈 **Gradient Themes**: Beautiful color schemes throughout the app
- ✨ **Smooth Animations**: Engaging transitions and micro-interactions
- 📱 **Responsive Layout**: Optimized for various screen sizes
- 🔄 **Pull-to-Refresh**: Easy data refresh on home screen
- 💫 **Splash Screen**: Animated app launch experience
- ✅ **Success Dialogs**: Beautiful feedback animations

## 🛠️ Tech Stack

- **Framework**: Flutter 3.9.0+
- **Language**: Dart
- **Backend**: Firebase (Firestore, Auth)
- **ML**: Google ML Kit Face Detection
- **Location**: Geolocator & Geocoding
- **Camera**: Camera Plugin
- **Animations**: Lottie

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  dotted_border: ^2.1.0
  camera: ^0.11.0+2
  geolocator: ^13.0.2
  geocoding: ^3.0.0
  intl: ^0.20.1
  lottie: ^3.3.1
  google_mlkit_face_detection: ^0.12.0
  cloud_firestore: ^5.6.3
  firebase_core: ^3.11.0
  firebase_auth: ^5.4.2
  image_picker: ^1.1.2
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Android Studio / VS Code
- Firebase account
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/attendance-app.git
   cd attendance-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add your Android/iOS app to Firebase
   - Download and add `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
   - Update Firebase configuration in `lib/main.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

### Home Screen
- Dashboard with real-time statistics
- Quick action buttons
- Recent activity feed

### Camera Screen
- Face detection overlay
- Modern capture interface
- Real-time feedback

### Attendance Screen
- Photo preview
- Location display
- Status indicator
- Form validation

## 🎯 Key Features Explained

### Face Detection
The app uses Google ML Kit to detect faces before allowing attendance submission. This ensures that only valid selfies are accepted.

### Geolocation
Automatic location capture provides:
- Latitude and Longitude
- Full address details
- Street, city, postal code, and country

### Smart Status
The app automatically determines attendance status:
- **On Time**: Check-in before 8:30 AM
- **Late**: Check-in between 8:31 AM - 6:00 PM
- **Leave**: Check-in after 6:00 PM

### Real-time Sync
All attendance data is synced in real-time with Firebase Firestore, allowing:
- Instant updates across devices
- Reliable data storage
- Easy data retrieval and analysis

## 🎨 Design Highlights

- **Color Scheme**: Purple gradient theme (#1A008F to #667EEA)
- **Typography**: Roboto font family
- **Icons**: Material Design icons with custom colors
- **Cards**: Elevated cards with rounded corners
- **Buttons**: Gradient buttons with shadow effects
- **Animations**: Smooth transitions and loading states

## 📂 Project Structure

```
lib/
├── main.dart
├── models/
├── services/
├── ui/
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── home_screen.dart
│   ├── attend/
│   │   ├── attend_screen.dart
│   │   └── camera_screen.dart
│   ├── absent/
│   ├── attendance_history/
│   └── profile/
├── utils/
│   └── face_detection/
└── widgets/
    ├── success_dialog.dart
    ├── shimmer_loading.dart
    ├── empty_state.dart
    ├── custom_app_bar.dart
    └── animated_button.dart
```

## 🔐 Permissions Required

### Android
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to capture attendance photos</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to record attendance location</string>
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Developer

Created with ❤️ by [Your Name]

## 📞 Contact

- Email: your.email@example.com
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- GitHub: [Your GitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google ML Kit for face detection
- All open-source contributors

---

⭐ If you found this project helpful, please give it a star!
