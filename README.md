# Kisan - Agricultural Crop Registration Platform

## Overview
Kisan is a Flutter-based mobile application designed to streamline the process of crop registration and management for farmers. The app enables users to register their crops, upload images, and manage their agricultural produce efficiently.

## Features
- **Crop Registration**: Easy-to-use interface for registering various types of crops
- **Image Management**: Support for multiple image uploads from camera or gallery
- **Location Support**: State-wise crop registration system
- **Bidding System**: Minimum bid setting for crops
- **Real-time Updates**: Firebase integration for real-time data management
- **User Authentication**: Secure Firebase authentication system
- **Cloud Storage**: Firebase storage for managing crop images

## Prerequisites
- Flutter SDK (^3.5.3)
- Dart SDK
- Android Studio / VS Code
- Firebase account and project setup
- Android SDK (minimum version 23)

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^0.8.4+4
  firebase_auth: ^5.3.1
  firebase_core: ^3.6.0
  provider: ^6.1.2
  cloud_firestore: ^5.0.0
  firebase_storage: 12.3.4
  intl: ^0.19.0
```

## Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd kisan
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android app to Firebase project
   - Download `google-services.json` and place it in `android/app/`
   - Enable Authentication, Cloud Firestore, and Storage in Firebase Console

4. Run the application:
```bash
flutter run
```

## Project Structure
```
kisan/
├── lib/
│   ├── models/
│   │   └── register_crop.dart
│   ├── pages/
│   │   └── crop_registration_page.dart
│   └── main.dart
├── android/
│   └── app/
│       └── build.gradle
├── ios/
├── pubspec.yaml
└── README.md
```

## Usage
1. Launch the app and authenticate
2. Navigate to crop registration
3. Select crop type from available options
4. Fill in required details:
   - Minimum bid amount
   - Total weight
   - State location
   - Contact number
5. Upload crop images (multiple supported)
6. Submit registration

## Configuration
### Android
- Minimum SDK: 23
- Target SDK: 33
- Compile SDK: Latest Flutter SDK version

### Firebase
Ensure the following Firebase services are enabled:
- Authentication
- Cloud Firestore
- Storage

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Support
For support, email [mohmedhusain72@gmail.com] or create an issue in the repository.

## Acknowledgments
- Flutter Team
- Firebase
- Contributors and maintainers

---
Built with ❤️ using Flutter and Firebase