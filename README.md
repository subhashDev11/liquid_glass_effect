# Liquid Glass Effect - Flutter Package Documentation

![ScreenRecording2025-06-13at12 43 16PMonline-video-cutter com-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/6d858dac-c8e9-4378-b2cf-38546ffdd93e)

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Theme Setup](#theme-setup)
4. [Components](#components)
    - [LiquidGlassBackground](#liquidglassbackground)
    - [LiquidGlassCard](#liquidglasscard)
    - [LiquidGlassButtons](#liquidglassbuttons)
5. [Customization](#customization)
6. [Examples](#examples)
7. [Contributing](#contributing)
8. [License](#license)

---

## Overview

**Liquid Glass Effect** is a Flutter package that implements iOS-inspired frosted glass effects with customizable themes and widgets. It provides a complete set of UI components with built-in liquid glass visual effects that work across all platforms.

---

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  liquid_glass_effect: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Theme Setup

### Basic Setup

```dart
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass Demo',
      theme: createLiquidGlassTheme(),
      home: const MyHomePage(),
    );
  }
}
```

### Custom Theme Configuration

```dart
theme: createLiquidGlassTheme(
  config: const LiquidGlassConfig(
    blurAmount: 25.0,
    highlightIntensity: 0.3,
    noiseOpacity: 0.05,
    primaryColor: Color(0xFF007AFF),
    secondaryColor: Color(0xFF34C759),
  ),
),
```

---

## Components

### LiquidGlassBackground

The foundation component that creates the frosted glass effect.

**Properties:**

- `child` (Widget): Content to display
- `backgroundImage` (ImageProvider): Optional background image
- `blurAmount` (double): Intensity of blur effect
- `noiseOpacity` (double): Opacity of noise texture
- `highlightIntensity` (double): Strength of liquid highlights
- `highlightColor` (Color): Color of highlights
- `noiseColor` (Color): Color of noise texture

**Example:**

```dart
LiquidGlassBackground(
  backgroundImage: AssetImage('assets/background.jpg'),
  child: Center(child: Text('Hello World')),
)
```

---

### LiquidGlassCard

A card with frosted glass effect.

**Properties:**

- `child` (Widget): Card content
- `borderRadius` (double): Corner radius
- `baseColor` (Color): Base tint color
- `blurAmount` (double): Blur intensity
- `padding` (EdgeInsets): Inner padding
- `onTap` (VoidCallback): Tap handler
- `borderColor` (Color): Border color
- `borderWidth` (double): Border thickness
- `animationDuration` (Duration): Hover/press animation duration
- `scaleFactor` (double): Hover scale amount

**Example:**

```dart
LiquidGlassCard(
  borderRadius: 16,
  onTap: () => print('Card tapped'),
  child: ListTile(title: Text('Example Card')),
)
```

---

### LiquidGlassButtons

#### LiquidGlassElevatedButton

**Properties:**

- `onPressed` (VoidCallback): Press handler
- `child` (Widget): Button content
- `style` (ButtonStyle): Custom style overrides

**Example:**

```dart
LiquidGlassElevatedButton(
  onPressed: () => print('Pressed'),
  child: Text('Submit'),
)
```

#### LiquidGlassOutlinedButton

**Properties:**

- Same as elevated button
- `borderColor` (Color): Custom border color

**Example:**

```dart
LiquidGlassOutlinedButton(
  onPressed: () => print('Pressed'),
  child: Text('Cancel'),
)
```

---

## Customization

### Theme Extension

```dart
final theme = Theme.of(context).extension<LiquidGlassThemeExtension>();
final blurAmount = theme?.blurAmount;
```

### Custom Config

```dart
const customConfig = LiquidGlassConfig(
  blurAmount: 30.0,
  highlightIntensity: 0.4,
  primaryColor: Colors.purple,
);
```

---

## Examples

### Weather App UI

```dart
LiquidGlassScaffold(
  backgroundImage: NetworkImage('https://example.com/sky.jpg'),
  appBar: AppBar(title: Text('Weather')),
  body: Column(
    children: [
      LiquidGlassCard(
        child: WeatherInfo(),
      ),
      LiquidGlassElevatedButton(
        onPressed: fetchWeather,
        child: Text('Refresh'),
      ),
    ],
  ),
)
```

### Settings Page

```dart
LiquidGlassScaffold(
  appBar: AppBar(title: Text('Settings')),
  body: ListView(
    children: [
      LiquidGlassCard(
        child: SwitchListTile(
          title: Text('Dark Mode'),
          value: darkMode,
          onChanged: (v) => setState(() => darkMode = v),
        ),
      ),
      LiquidGlassOutlinedButton(
        onPressed: logout,
        child: Text('Sign Out'),
      ),
    ],
  ),
)
```

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

---

## License

This package is released under the MIT License. See `LICENSE` for details.
