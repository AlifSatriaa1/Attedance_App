# ⚡ Quick Start Guide

Get the Smart Attendance System up and running in 5 minutes!

## 🎯 Prerequisites

Before you begin, ensure you have:
- ✅ Flutter SDK installed (3.9.0+)
- ✅ Android Studio or VS Code
- ✅ A physical device or emulator
- ✅ Firebase account (free tier is fine)

## 🚀 5-Minute Setup

### Step 1: Clone & Install (1 minute)

```bash
# Clone the repository
git clone https://github.com/yourusername/attendance-app.git
cd attendance-app

# Install dependencies
flutter pub get
```

### Step 2: Firebase Setup (2 minutes)

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add Project"
   - Name it "attendance-app"
   - Click "Create Project"

2. **Enable Firestore**
   - Click "Firestore Database"
   - Click "Create Database"
   - Select "Test mode"
   - Click "Enable"

3. **Add Android App**
   - Click "Add App" → Android icon
   - Package name: `com.example.attendance_app`
   - Download `google-services.json`
   - Place in `android/app/`

### Step 3: Update Configuration (1 minute)

Open `lib/main.dart` and update Firebase config:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',           // From Firebase Console
    appId: 'YOUR_APP_ID',             // From Firebase Console
    messagingSenderId: 'YOUR_ID',     // From Firebase Console
    projectId: 'YOUR_PROJECT_ID',     // From Firebase Console
  ),
);
```

Find these values in:
Firebase Console → Project Settings → General → Your apps

### Step 4: Run the App (1 minute)

```bash
# Check connected devices
flutter devices

# Run the app
flutter run
```

## 🎉 That's It!

You should now see:
1. ✨ Animated splash screen
2. 🏠 Home screen with statistics
3. 📸 Camera for check-in
4. 📍 Location tracking

## 🔧 Troubleshooting

### Issue: Firebase connection failed
**Solution**: Double-check your Firebase configuration in `main.dart`

### Issue: Camera not working
**Solution**: Test on a physical device (emulator cameras can be unreliable)

### Issue: Location not working
**Solution**: Enable location services on your device

### Issue: Build errors
**Solution**: 
```bash
flutter clean
flutter pub get
flutter run
```

## 📱 Test the Features

### 1. Check In
- Tap "Check In" on home screen
- Take a selfie
- Enter your name
- Submit

### 2. View Statistics
- See real-time stats on home screen
- Pull down to refresh

### 3. View History
- Tap "History" to see all records
- Swipe to delete entries

## 🎨 Customize

### Change Colors
Edit `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF1A008F), // Change this!
),
```

### Change App Name
Edit `lib/main.dart`:
```dart
title: 'Your App Name',
```

### Change Check-in Times
Edit `lib/ui/attend/attend_screen.dart`:
```dart
if (dateHours < 8 || (dateHours == 8 && dateMinutes <= 30)) {
  strStatus = "Attend";  // Change time here
}
```

## 📚 Next Steps

- 📖 Read [FEATURES.md](FEATURES.md) for detailed features
- 🛠️ Check [SETUP.md](SETUP.md) for advanced setup
- 🤝 See [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
- 📸 View [SCREENSHOTS.md](SCREENSHOTS.md) for UI guide

## 💡 Pro Tips

1. **Use Physical Device**: For best experience with camera and location
2. **Enable Developer Mode**: For faster debugging
3. **Hot Reload**: Press `r` in terminal for instant updates
4. **Hot Restart**: Press `R` for full restart

## 🆘 Need Help?

- 📖 Check [SETUP.md](SETUP.md) for detailed guide
- 🐛 Open an issue on GitHub
- 💬 Contact the developer

## ✅ Verification Checklist

Before considering setup complete:
- [ ] App launches without errors
- [ ] Splash screen appears
- [ ] Home screen loads with statistics
- [ ] Camera opens when tapping Check In
- [ ] Location is captured
- [ ] Data saves to Firebase
- [ ] History shows records

## 🎊 Success!

If all checks pass, you're ready to:
- ✨ Customize the app
- 🚀 Deploy to production
- 📱 Share with users
- 💼 Add to your portfolio

---

**Happy Coding! 🚀**

Need more details? Check out the full [SETUP.md](SETUP.md) guide.
