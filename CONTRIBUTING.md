# 🤝 Contributing to Smart Attendance System

First off, thank you for considering contributing to Smart Attendance System! It's people like you that make this project better.

## 📋 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Process](#development-process)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

## 📜 Code of Conduct

### Our Pledge
We are committed to providing a welcoming and inspiring community for all. Please be respectful and constructive in your interactions.

### Our Standards
- ✅ Using welcoming and inclusive language
- ✅ Being respectful of differing viewpoints
- ✅ Gracefully accepting constructive criticism
- ✅ Focusing on what is best for the community
- ❌ Using sexualized language or imagery
- ❌ Trolling, insulting/derogatory comments
- ❌ Public or private harassment

## 🚀 Getting Started

### Prerequisites
1. Read the [README.md](README.md)
2. Follow the [SETUP.md](SETUP.md) guide
3. Familiarize yourself with [FEATURES.md](FEATURES.md)

### Development Setup
```bash
# Fork the repository
# Clone your fork
git clone https://github.com/YOUR_USERNAME/attendance-app.git

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL_OWNER/attendance-app.git

# Install dependencies
flutter pub get

# Create a branch
git checkout -b feature/your-feature-name
```

## 💡 How to Contribute

### Reporting Bugs
Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce**
- **Expected behavior**
- **Actual behavior**
- **Screenshots** (if applicable)
- **Device/OS information**
- **Flutter version**

**Bug Report Template:**
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- Device: [e.g. Pixel 6]
- OS: [e.g. Android 13]
- Flutter Version: [e.g. 3.9.0]
- App Version: [e.g. 2.0.0]
```

### Suggesting Features
Feature requests are welcome! Please provide:

- **Clear title and description**
- **Use case** - Why is this feature needed?
- **Proposed solution**
- **Alternative solutions** considered
- **Mockups/wireframes** (if applicable)

**Feature Request Template:**
```markdown
**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Any alternative solutions or features.

**Additional context**
Add any other context or screenshots.
```

### Code Contributions

#### Good First Issues
Look for issues labeled:
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `bug` - Something isn't working
- `enhancement` - New feature or request

## 🔧 Development Process

### 1. Create a Branch
```bash
# Feature branch
git checkout -b feature/add-dark-mode

# Bug fix branch
git checkout -b fix/camera-crash

# Documentation branch
git checkout -b docs/update-readme
```

### 2. Make Changes
- Write clean, readable code
- Follow the style guidelines
- Add comments for complex logic
- Update documentation if needed

### 3. Test Your Changes
```bash
# Run tests
flutter test

# Check for issues
flutter analyze

# Format code
flutter format .

# Test on device
flutter run
```

### 4. Commit Your Changes
```bash
git add .
git commit -m "feat: add dark mode support"
```

### 5. Push to Your Fork
```bash
git push origin feature/add-dark-mode
```

### 6. Create Pull Request
- Go to the original repository
- Click "New Pull Request"
- Select your branch
- Fill in the PR template

## 🎨 Style Guidelines

### Dart Code Style
Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)

#### Naming Conventions
```dart
// Classes: UpperCamelCase
class AttendanceScreen extends StatefulWidget {}

// Variables: lowerCamelCase
String userName = "John Doe";

// Constants: lowerCamelCase
const double borderRadius = 16.0;

// Private members: _lowerCamelCase
String _privateVariable = "private";

// Files: snake_case
// attendance_screen.dart
// success_dialog.dart
```

#### Code Organization
```dart
// 1. Imports
import 'package:flutter/material.dart';
import 'package:attendance_app/widgets/custom_button.dart';

// 2. Class declaration
class MyWidget extends StatelessWidget {
  // 3. Constructor
  const MyWidget({super.key});
  
  // 4. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 5. Helper methods
  void _helperMethod() {}
}
```

#### Widget Structure
```dart
// Prefer const constructors
const Text('Hello');

// Use named parameters
Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 20),
  child: Text('Content'),
);

// Extract complex widgets
Widget _buildHeader() {
  return Container(
    // ...
  );
}
```

### UI/UX Guidelines

#### Colors
```dart
// Use theme colors
Theme.of(context).primaryColor

// Or defined constants
const Color primaryColor = Color(0xFF1A008F);
```

#### Spacing
```dart
// Use consistent spacing
const double spacingSmall = 8.0;
const double spacingMedium = 16.0;
const double spacingLarge = 24.0;
```

#### Typography
```dart
// Use TextStyle consistently
const TextStyle headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
```

## 📝 Commit Messages

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

### Examples
```bash
# Feature
git commit -m "feat(auth): add biometric authentication"

# Bug fix
git commit -m "fix(camera): resolve crash on Android 13"

# Documentation
git commit -m "docs(readme): update installation steps"

# Style
git commit -m "style(home): improve card spacing"

# Refactor
git commit -m "refactor(widgets): extract reusable components"
```

## 🔄 Pull Request Process

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Added unit tests
- [ ] All tests passing

## Screenshots
If applicable, add screenshots

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests added/updated
```

### Review Process
1. **Automated Checks**: CI/CD runs tests
2. **Code Review**: Maintainer reviews code
3. **Feedback**: Address review comments
4. **Approval**: PR gets approved
5. **Merge**: PR is merged to main branch

### After Merge
- Delete your branch
- Update your fork
- Celebrate! 🎉

## 🏆 Recognition

Contributors will be:
- Listed in README.md
- Mentioned in release notes
- Given credit in commits

## 📞 Questions?

- Open an issue with `question` label
- Contact maintainers
- Join community discussions

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- [Git Best Practices](https://git-scm.com/book/en/v2)

---

Thank you for contributing! 🙏

**Happy Coding! 🚀**
