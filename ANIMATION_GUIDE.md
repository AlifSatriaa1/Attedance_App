# 🎬 Animation Quick Reference Guide

## Table of Contents
1. [Basic Animations](#basic-animations)
2. [Custom Widgets](#custom-widgets)
3. [Page Transitions](#page-transitions)
4. [Common Patterns](#common-patterns)
5. [Tips & Tricks](#tips--tricks)

---

## Basic Animations

### Fade Animation
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: child,
    );
  },
  child: YourWidget(),
)
```

### Scale Animation
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.8, end: 1.0),
  duration: Duration(milliseconds: 400),
  curve: Curves.elasticOut,
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
  child: YourWidget(),
)
```

### Slide Animation
```dart
TweenAnimationBuilder<Offset>(
  tween: Tween(begin: Offset(0, 0.2), end: Offset.zero),
  duration: Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Transform.translate(
      offset: Offset(0, value.dy * 100),
      child: child,
    );
  },
  child: YourWidget(),
)
```

---

## Custom Widgets

### PulseAnimation
**Use Case:** Highlight important elements, notifications, live indicators

```dart
PulseAnimation(
  child: Icon(Icons.notifications, size: 32),
  duration: Duration(milliseconds: 1000),
  minScale: 0.95,
  maxScale: 1.05,
)
```

**Example - Live Indicator:**
```dart
PulseAnimation(
  child: Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
  ),
)
```

### GradientButton
**Use Case:** Primary actions, CTAs, submit buttons

```dart
GradientButton(
  text: 'Check In',
  icon: Icons.login,
  onPressed: () async {
    setState(() => isLoading = true);
    await performAction();
    setState(() => isLoading = false);
  },
  isLoading: isLoading,
  gradientColors: [Color(0xFF1A008F), Color(0xFF3D1FA8)],
)
```

**Example - Without Icon:**
```dart
GradientButton(
  text: 'Submit',
  onPressed: handleSubmit,
  height: 48,
  width: double.infinity,
)
```

### SlideFadeTransition
**Use Case:** List items, cards, sequential animations

```dart
// Single item
SlideFadeTransition(
  child: Card(...),
  offset: Offset(0, 0.2),
  duration: Duration(milliseconds: 500),
)

// Staggered list
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return SlideFadeTransition(
      delayInMilliseconds: index * 100,
      child: ListTile(...),
    );
  },
)
```

### RippleAnimation
**Use Case:** Focus indicators, active states, loading

```dart
RippleAnimation(
  child: CircleAvatar(
    radius: 40,
    child: Icon(Icons.person),
  ),
  color: Colors.blue,
  ripplesCount: 3,
  duration: Duration(milliseconds: 2000),
)
```

**Example - Loading State:**
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

### LoadingOverlay
**Use Case:** Full-screen loading, processing states

```dart
LoadingOverlay(
  isLoading: isProcessing,
  message: 'Processing your request...',
  child: YourScreen(),
)
```

**Example - Conditional Loading:**
```dart
class MyScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      message: _loadingMessage,
      child: Scaffold(
        body: YourContent(),
      ),
    );
  }
}
```

---

## Page Transitions

### Fade Transition
**Best for:** Modal screens, overlays
```dart
Navigator.push(
  context,
  PageTransitions.fadeTransition(DetailScreen()),
);
```

### Slide from Right
**Best for:** Forward navigation, detail views
```dart
Navigator.push(
  context,
  PageTransitions.slideFromRight(ProfileScreen()),
);
```

### Slide from Bottom
**Best for:** Modal sheets, forms
```dart
Navigator.push(
  context,
  PageTransitions.slideFromBottom(SettingsScreen()),
);
```

### Scale Transition
**Best for:** Pop-ups, dialogs
```dart
Navigator.push(
  context,
  PageTransitions.scaleTransition(ImagePreview()),
);
```

### Elastic Transition
**Best for:** Fun interactions, game-like UX
```dart
Navigator.push(
  context,
  PageTransitions.elasticTransition(AchievementScreen()),
);
```

---

## Common Patterns

### Animated List Item
```dart
class AnimatedListItem extends StatelessWidget {
  final int index;
  final Widget child;

  const AnimatedListItem({
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SlideFadeTransition(
      delayInMilliseconds: index * 50,
      offset: Offset(0, 0.1),
      child: child,
    );
  }
}

// Usage
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      child: ListTile(title: Text(items[index])),
    );
  },
)
```

### Animated Card Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Card(
            child: items[index],
          ),
        );
      },
    );
  },
)
```

### Interactive Button
```dart
class InteractiveButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  @override
  State<InteractiveButton> createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Shimmer Loading Card
```dart
Widget buildLoadingCard() {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(width: 200, height: 20),
          SizedBox(height: 8),
          ShimmerLoading(width: 150, height: 16),
          SizedBox(height: 8),
          ShimmerLoading(width: double.infinity, height: 100),
        ],
      ),
    ),
  );
}
```

---

## Tips & Tricks

### 1. Performance Optimization

**DO:**
```dart
// Use const constructors
const Text('Hello')
const Icon(Icons.home)

// Dispose controllers
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

// Use RepaintBoundary for complex animations
RepaintBoundary(
  child: AnimatedWidget(),
)
```

**DON'T:**
```dart
// Avoid creating controllers in build method
// Avoid nested animations without RepaintBoundary
// Don't forget to dispose controllers
```

### 2. Animation Curves

```dart
// Smooth & Natural
Curves.easeInOut
Curves.easeOut

// Bouncy & Fun
Curves.elasticOut
Curves.bounceOut

// Fast & Snappy
Curves.fastOutSlowIn
Curves.easeInOutCubic

// Dramatic
Curves.decelerate
Curves.anticipate
```

### 3. Duration Guidelines

```dart
// Micro-interactions: 100-200ms
Duration(milliseconds: 150)

// Standard transitions: 200-400ms
Duration(milliseconds: 300)

// Complex animations: 400-800ms
Duration(milliseconds: 600)

// Attention-grabbing: 800-1200ms
Duration(milliseconds: 1000)
```

### 4. Stagger Delays

```dart
// Calculate delay based on index
final delay = index * 50; // 50ms between each item

// Maximum delay cap
final delay = min(index * 50, 500); // Max 500ms

// Exponential delay
final delay = pow(1.2, index) * 50;
```

### 5. Combining Animations

```dart
// Slide + Fade
Transform.translate(
  offset: Offset(0, 20 * (1 - animation.value)),
  child: Opacity(
    opacity: animation.value,
    child: child,
  ),
)

// Scale + Rotate
Transform.scale(
  scale: animation.value,
  child: Transform.rotate(
    angle: (1 - animation.value) * 0.5,
    child: child,
  ),
)
```

### 6. Conditional Animations

```dart
// Only animate on first build
class AnimatedOnce extends StatefulWidget {
  final Widget child;

  @override
  State<AnimatedOnce> createState() => _AnimatedOnceState();
}

class _AnimatedOnceState extends State<AnimatedOnce> {
  bool _hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    if (!_hasAnimated) {
      _hasAnimated = true;
      return SlideFadeTransition(child: widget.child);
    }
    return widget.child;
  }
}
```

### 7. Hero Animations

```dart
// Source screen
Hero(
  tag: 'profile-image',
  child: CircleAvatar(
    backgroundImage: NetworkImage(imageUrl),
  ),
)

// Destination screen
Hero(
  tag: 'profile-image',
  child: Image.network(imageUrl),
)
```

---

## Animation Checklist

Before implementing animations:

- [ ] Does it improve UX or just look cool?
- [ ] Is the duration appropriate?
- [ ] Does it work on low-end devices?
- [ ] Is the animation controller disposed?
- [ ] Is there a loading/error state?
- [ ] Does it respect user's motion preferences?
- [ ] Is it accessible?

---

## Common Mistakes to Avoid

1. **Too many animations at once**
   - Limit to 2-3 simultaneous animations
   - Use stagger delays for multiple items

2. **Too long durations**
   - Keep most animations under 500ms
   - Users shouldn't wait for animations

3. **Forgetting to dispose**
   - Always dispose AnimationControllers
   - Use StatefulWidget lifecycle properly

4. **Animating everything**
   - Not everything needs animation
   - Use animations purposefully

5. **Ignoring performance**
   - Test on real devices
   - Use RepaintBoundary when needed
   - Profile your animations

---

## Resources

- [Flutter Animation Docs](https://flutter.dev/docs/development/ui/animations)
- [Material Motion](https://material.io/design/motion)
- [Animation Curves Visualizer](https://api.flutter.dev/flutter/animation/Curves-class.html)

---

**Happy Animating! 🎨✨**
