# Flutter Splash Screen 🚀

A modern and animated Flutter splash screen built as a simple UI demonstration project.

The application features an **Orbit-themed welcome screen** where users can press the **"Let's begin"** button to launch an animated splash experience. The splash animation displays an orbital graphic, loading progress, and transitions into a welcome screen.

## ✨ Features

- Modern dark-themed Flutter UI
- Animated orbital splash screen
- Interactive **"Let's begin"** button
- 2.8-second splash animation
- Animated loading progress indicator
- Custom-drawn orbit and planet using `CustomPainter`
- Smooth transition to the welcome screen
- **"Experience it again"** replay button
- Responsive layout for different screen sizes
- Large-text accessibility support
- Reduced-motion support
- Flutter widget tests

## 📱 App Flow

```text
Open App
   ↓
Orbit Welcome Screen
   ↓
Tap "Let's begin"
   ↓
Animated Splash Screen
   ↓
Loading Progress (0% → 100%)
   ↓
Welcome Screen
   ↓
Tap "Experience it again"
   ↓
Replay Splash Animation
```

## 🛠️ Built With

- Flutter
- Dart
- Material 3
- Flutter AnimationController
- CustomPainter
- Flutter Widget Testing

No external Flutter packages are required for the splash screen animation.

## 🚀 Getting Started

### Prerequisites

Make sure Flutter is installed on your computer.

Check your Flutter installation:

```bash
flutter doctor
```

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd flutter_splash_screen
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

Connect an Android device, start an emulator, or select another supported Flutter device.

```bash
flutter run
```

## 🧪 Testing

Run the widget tests with:

```bash
flutter test
```

The tests verify that:

- The splash animation starts after pressing **"Let's begin"**
- The application transitions to the welcome screen
- The splash animation can be replayed
- The UI works on smaller screens with larger text

## 🔍 Code Analysis

Run Flutter's static analyzer with:

```bash
flutter analyze
```

The current project passes Flutter analysis and widget tests.

## 📂 Project Structure

```text
flutter_splash_screen/
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```

The main splash screen implementation is located in:

```text
lib/main.dart
```

## 🎨 Splash Screen Design

The splash screen uses a custom **Orbit** visual style featuring:

- Dark radial-gradient background
- Glowing central planet
- Animated orbital paths
- Moving orbit particles
- Progress animation
- Material icons
- Lime-green accent colour

The orbital graphic is rendered directly in Flutter using `CustomPainter`, so no external image assets are required.

## 📦 Build APK

To generate a release APK:

```bash
flutter build apk --release
```

After the build completes, the APK can normally be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## 📄 License

This project is intended for learning, demonstration, and portfolio purposes.
