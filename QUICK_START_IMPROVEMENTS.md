# 🚀 Quick Start - Using New Improvements

## Panduan Cepat Menggunakan Fitur Baru

---

## 1. Custom Snackbar ✨

### Import
```dart
import 'package:attendance_app/utils/custom_snackbar.dart';
```

### Usage
```dart
// Success
CustomSnackbar.show(
  context,
  message: 'Attendance recorded successfully!',
  type: SnackbarType.success,
);

// Error
CustomSnackbar.show(
  context,
  message: 'Failed to connect to server',
  type: SnackbarType.error,
);

// Warning
CustomSnackbar.show(
  context,
  message: 'Please enable location services',
  type: SnackbarType.warning,
);

// Info
CustomSnackbar.show(
  context,
  message: 'Swipe to refresh data',
  type: SnackbarType.info,
);
```

---

## 2. Gradient Button 🎨

### Import
```dart
import 'package:attendance_app/widgets/gradient_button.dart';
```

### Basic Usage
```dart
GradientButton(
  text: 'Check In',
  onPressed: () {
    // Your action
  },
)
```

### With Icon
```dart
GradientButton(
  text: 'Submit',
  icon: Icons.check,
  onPressed: handleSubmit,
)
```

### With Loading State
```dart
bool isLoading = false;

GradientButton(
  text: 'Processing',
  onPressed: () async {
    setState(() => isLoading = true);
    await performAction();
    setState(() => isLoading = false);
  },
  isLoading: isLoading,
)
```

### Custom Colors
```dart
GradientButton(
  text: 'Delete',
  icon: Icons.delete,
  onPressed: handleDelete,
  gradientColors: [Colors.red, Colors.redAccent],
)
```

---

## 3. Page Transitions 🔄

### Import
```dart
import 'package:attendance_app/utils/page_transitions.dart';
```

### Slide from Right (Default Navigation)
```dart
Navigator.push(
  context,
  PageTransitions.slideFromRight(ProfileScreen()),
);
```

### Slide from Bottom (Modal Style)
```dart
Navigator.push(
  context,
  PageTransitions.slideFromBottom(SettingsScreen()),
);
```

### Fade Transition (Subtle)
```dart
Navigator.push(
  context,
  PageTransitions.fadeTransition(DetailScreen()),
);
```

### Scale Transition (Pop-up Style)
```dart
Navigator.push(
  context,
  PageTransitions.scaleTransition(ImagePreview()),
);
```

### Elastic Transition (Fun & Bouncy)
```dart
Navigator.push(
  context,
  PageTransitions.elasticTransition(AchievementScreen()),
);
```

---

## 4. Slide Fade Animation 🎬

### Import
```dart
import 'package:attendance_app/widgets/slide_fade_transition.dart';
```

### Single Widget
```dart
SlideFadeTransition(
  child: Card(
    child: Text('Animated Card'),
  ),
)
```

### Staggered List
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return SlideFadeTransition(
      delayInMilliseconds: index * 100, // 100ms delay between items
      child: ListTile(
        title: Text(items[index]),
      ),
    );
  },
)
```

### Custom Direction & Duration
```dart
SlideFadeTransition(
  offset: Offset(0.3, 0), // Slide from right
  duration: Duration(milliseconds: 600),
  curve: Curves.easeOutCubic,
  child: YourWidget(),
)
```

---

## 5. Pulse Animation 💓

### Import
```dart
import 'package:attendance_app/widgets/pulse_animation.dart';
```

### Notification Badge
```dart
Stack(
  children: [
    Icon(Icons.notifications, size: 32),
    Positioned(
      right: 0,
      top: 0,
      child: PulseAnimation(
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),
  ],
)
```

### Live Indicator
```dart
Row(
  children: [
    PulseAnimation(
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    ),
    SizedBox(width: 8),
    Text('Live'),
  ],
)
```

---

## 6. Ripple Animation 🌊

### Import
```dart
import 'package:attendance_app/widgets/ripple_animation.dart';
```

### Active User Indicator
```dart
RippleAnimation(
  child: CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(userImage),
  ),
  color: Colors.blue,
  ripplesCount: 3,
)
```

### Loading State
```dart
RippleAnimation(
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.sync, color: Colors.white),
  ),
  color: Colors.blue.withOpacity(0.3),
)
```

---

## 7. Loading Overlay 📱

### Import
```dart
import 'package:attendance_app/widgets/loading_overlay.dart';
```

### Full Screen Loading
```dart
class MyScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      message: 'Loading data...',
      child: Scaffold(
        body: YourContent(),
      ),
    );
  }
}
```

### With Custom Background
```dart
LoadingOverlay(
  isLoading: true,
  message: 'Processing...',
  backgroundColor: Colors.blue,
  child: YourWidget(),
)
```

---

## 8. Using App Theme 🎨

### In main.dart
```dart
import 'package:attendance_app/utils/app_theme.dart';

MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // Auto switch based on system
  home: HomeScreen(),
)
```

### Force Light Mode
```dart
themeMode: ThemeMode.light,
```

### Force Dark Mode
```dart
themeMode: ThemeMode.dark,
```

### Access Theme Colors
```dart
// In your widgets
final primaryColor = Theme.of(context).colorScheme.primary;
final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
```

---

## 9. Complete Example - Form Screen

```dart
import 'package:flutter/material.dart';
import 'package:attendance_app/widgets/gradient_button.dart';
import 'package:attendance_app/widgets/slide_fade_transition.dart';
import 'package:attendance_app/utils/custom_snackbar.dart';
import 'package:attendance_app/utils/page_transitions.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      // Your API call
      await Future.delayed(Duration(seconds: 2));

      CustomSnackbar.show(
        context,
        message: 'Form submitted successfully!',
        type: SnackbarType.success,
      );

      // Navigate to next screen
      Navigator.push(
        context,
        PageTransitions.slideFromRight(SuccessScreen()),
      );
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Error: $e',
        type: SnackbarType.error,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Example')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SlideFadeTransition(
                delayInMilliseconds: 0,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              SlideFadeTransition(
                delayInMilliseconds: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32),
              SlideFadeTransition(
                delayInMilliseconds: 200,
                child: GradientButton(
                  text: 'Submit',
                  icon: Icons.check,
                  onPressed: handleSubmit,
                  isLoading: isLoading,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 10. Complete Example - List Screen

```dart
import 'package:flutter/material.dart';
import 'package:attendance_app/widgets/slide_fade_transition.dart';
import 'package:attendance_app/widgets/shimmer_loading.dart';
import 'package:attendance_app/utils/page_transitions.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool isLoading = true;
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(10, (i) => 'Item ${i + 1}');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Example')),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: isLoading
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(width: 200, height: 20),
                          SizedBox(height: 8),
                          ShimmerLoading(width: 150, height: 16),
                        ],
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return SlideFadeTransition(
                    delayInMilliseconds: index * 50,
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(items[index]),
                        subtitle: Text('Description for ${items[index]}'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransitions.slideFromRight(
                              DetailScreen(item: items[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
```

---

## Tips & Best Practices 💡

### 1. Animation Duration
- Micro-interactions: 100-200ms
- Standard transitions: 200-400ms
- Complex animations: 400-800ms

### 2. Stagger Delays
```dart
// Good: 50-100ms between items
delayInMilliseconds: index * 50

// Too slow: > 150ms
delayInMilliseconds: index * 200 // ❌

// Too fast: < 30ms
delayInMilliseconds: index * 20 // ❌
```

### 3. Loading States
Always provide feedback:
```dart
// ✅ Good
GradientButton(
  text: 'Submit',
  onPressed: handleSubmit,
  isLoading: isLoading,
)

// ❌ Bad - No feedback
ElevatedButton(
  onPressed: isLoading ? null : handleSubmit,
  child: Text('Submit'),
)
```

### 4. Error Handling
Always show user-friendly messages:
```dart
try {
  await performAction();
  CustomSnackbar.show(
    context,
    message: 'Success!',
    type: SnackbarType.success,
  );
} catch (e) {
  CustomSnackbar.show(
    context,
    message: 'Something went wrong. Please try again.',
    type: SnackbarType.error,
  );
}
```

---

## Common Patterns 🎯

### Pattern 1: Animated Form
```dart
Column(
  children: List.generate(
    formFields.length,
    (index) => SlideFadeTransition(
      delayInMilliseconds: index * 100,
      child: formFields[index],
    ),
  ),
)
```

### Pattern 2: Loading to Content
```dart
isLoading
  ? ShimmerLoading(...)
  : SlideFadeTransition(child: Content())
```

### Pattern 3: Success Flow
```dart
await performAction();
CustomSnackbar.show(context, ...);
Navigator.push(context, PageTransitions.slideFromRight(...));
```

---

## Troubleshooting 🔧

### Animation not showing?
- Check if widget is mounted
- Verify animation controller is initialized
- Ensure duration is not too short

### Performance issues?
- Use `RepaintBoundary` for complex animations
- Reduce number of simultaneous animations
- Check for memory leaks (dispose controllers)

### Snackbar not appearing?
- Ensure context is valid
- Check if another snackbar is showing
- Verify Scaffold is in widget tree

---

**Happy Coding! 🎉**
