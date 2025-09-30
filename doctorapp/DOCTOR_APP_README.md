# Doctor App

A modern Flutter application for connecting patients with healthcare professionals.

## Features

### ✨ Splash Screen

- Animated logo with fade and scale transitions
- Loading indicator
- Auto-navigation to home screen after 3 seconds
- Fallback UI if splash image is not available

### 🏠 Home Screen

- Clean, modern UI design
- Welcome section with search functionality
- Quick stats displaying total doctors and specialties
- Medical specialty categories grid:
  - Cardiology
  - Neurology
  - Orthopedic
  - Pediatrics
  - Dermatology
  - General Medicine
- Quick action buttons for booking appointments and emergency
- Bottom navigation bar with 4 tabs (Home, Appointments, Medical Records, Profile)

## File Structure

```
lib/
├── main.dart                 # App entry point
└── screens/
    ├── splash_screen.dart    # Animated splash screen
    └── home_screen.dart      # Main home screen with navigation
```

## Assets

- `assets/images/splashscreen.jpeg` - Splash screen image (with fallback if not found)

## Getting Started

1. Make sure you have Flutter installed
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Design Features

- Material 3 design system
- Blue color scheme theme
- Responsive grid layout
- Smooth animations and transitions
- Shadow effects and gradients
- Interactive cards with feedback

## Future Enhancements

The app includes placeholder screens for:

- Appointments management
- Medical records
- User profile
- Doctor search and booking
- Emergency services

## Dependencies

- Flutter SDK ^3.7.0
- Material Design icons
- Standard Flutter packages

## Platform Support

This app supports:

- Android
- iOS
- Web
- Windows
- macOS
- Linux
