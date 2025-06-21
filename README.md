<<<<<<< HEAD
# Sarv-Suvidhaen

A secure Flutter application with Google OAuth login and Remember My Password functionality

## 🚀 Features

### ✅ Google OAuth Authentication
- **Google Sign-In Integration**: Seamless authentication using Google OAuth 2.0
- **Firebase Authentication**: Secure backend authentication with Firebase
- **User Profile Management**: Display user information and profile pictures
- **Error Handling**: Comprehensive error handling for authentication failures

### ✅ Remember My Password Functionality
- **Secure Session Storage**: Uses Flutter Secure Storage for sensitive data
- **Session Persistence**: Remembers user sessions across app restarts
- **Session Validation**: Validates session expiry (30-day limit)
- **Privacy-First**: Never stores passwords in plain text
- **Cross-Platform**: Works consistently across iOS and Android

### ✅ Modern UI/UX Design
- **Material Design 3**: Latest Material Design principles
- **Dark/Light Theme**: Automatic theme switching based on system preference
- **Smooth Animations**: Beautiful transitions and micro-interactions
- **Responsive Design**: Optimized for different screen sizes
- **Accessibility**: Built with accessibility best practices

### ✅ Security Features
- **Secure Storage**: All sensitive data encrypted using Flutter Secure Storage
- **Token Management**: Secure JWT token handling
- **Input Validation**: Comprehensive form validation
- **Error Handling**: User-friendly error messages
- **Session Security**: Automatic session cleanup on logout

## 🛠️ Technology Stack

- **Frontend**: Flutter 3.0+
- **Authentication**: Firebase Authentication
- **Google OAuth**: Google Sign-In Plugin
- **State Management**: Provider Pattern
- **Secure Storage**: Flutter Secure Storage
- **UI Framework**: Material Design 3
- **Typography**: Google Fonts (Inter)
- **Animations**: Flutter Animation Controllers

## 📱 Screenshots

The app includes the following screens:
- **Splash Screen**: Beautiful loading animation with app branding
- **Login Screen**: Email/password login with Google OAuth option
- **Register Screen**: User registration with form validation
- **Home Screen**: User profile display with session information

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 2.19 or higher
- Android Studio / VS Code
- Firebase project setup
- Google Cloud Console project

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd password_remember
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   
   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable Authentication and add Google Sign-In provider
   
   c. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   
   d. Place the files in:
      - Android: `android/app/google-services.json`
      - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Google Cloud Console Setup**
   
   a. Go to [Google Cloud Console](https://console.cloud.google.com/)
   
   b. Create a new project or select existing one
   
   c. Enable Google+ API
   
   d. Create OAuth 2.0 credentials
   
   e. Add your app's package name and SHA-1 fingerprint

5. **Configure Android**
   
   Add to `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```
   
   Add to `android/build.gradle`:
   ```gradle
   classpath 'com.google.gms:google-services:4.3.15'
   ```

6. **Configure iOS**
   
   Add to `ios/Runner/Info.plist`:
   ```xml
   <key>CFBundleURLTypes</key>
   <array>
     <dict>
       <key>CFBundleURLName</key>
       <string>REVERSED_CLIENT_ID</string>
       <key>CFBundleURLSchemes</key>
       <array>
         <string>YOUR_REVERSED_CLIENT_ID</string>
       </array>
     </dict>
   </array>
   ```

7. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── services/
│   └── auth_service.dart     # Authentication logic
├── screens/
│   ├── splash_screen.dart    # Loading screen
│   ├── login_screen.dart     # Login form
│   ├── register_screen.dart  # Registration form
│   └── home_screen.dart      # User dashboard
├── widgets/
│   ├── custom_button.dart    # Reusable button component
│   └── custom_text_field.dart # Reusable text field component
└── utils/
    └── theme.dart           # App theme configuration
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:
```env
GOOGLE_CLIENT_ID=your_google_client_id
FIREBASE_PROJECT_ID=your_firebase_project_id
```

### Firebase Configuration

1. Enable Authentication in Firebase Console
2. Add Google Sign-In provider
3. Configure authorized domains
4. Set up security rules

## 🧪 Testing

### Manual Testing Checklist

- [ ] App launches and shows splash screen
- [ ] Navigation to login screen works
- [ ] Email/password validation works
- [ ] Google Sign-In button works
- [ ] Remember password checkbox functions
- [ ] Registration form validation works
- [ ] User profile displays correctly
- [ ] Session persistence works after app restart
- [ ] Logout functionality works
- [ ] Error messages display properly

### Automated Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 🔒 Security Considerations

- **No Plain Text Passwords**: Passwords are never stored in plain text
- **Secure Storage**: All sensitive data uses Flutter Secure Storage
- **Token Expiry**: Sessions automatically expire after 30 days
- **Input Sanitization**: All user inputs are validated and sanitized
- **Error Handling**: Sensitive information is not exposed in error messages

## 📊 Performance

- **Fast Loading**: Optimized splash screen with smooth animations
- **Efficient State Management**: Provider pattern for minimal rebuilds
- **Memory Management**: Proper disposal of controllers and listeners
- **Image Optimization**: Efficient profile picture loading with error handling

## 🐛 Troubleshooting

### Common Issues

1. **Google Sign-In not working**
   - Verify SHA-1 fingerprint in Google Cloud Console
   - Check package name matches Firebase configuration
   - Ensure Google+ API is enabled

2. **Firebase connection issues**
   - Verify `google-services.json` is in correct location
   - Check Firebase project configuration
   - Ensure Authentication is enabled

3. **Build errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter and Dart SDK versions
   - Verify all dependencies are compatible

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the troubleshooting section

## 🎯 Future Enhancements

- [ ] Biometric authentication
- [ ] Multi-factor authentication
- [ ] Password strength indicator
- [ ] Account recovery options
- [ ] Social media login integration
- [ ] Offline mode support
- [ ] Push notifications
- [ ] User preferences management

---

**Note**: This project is for educational purposes and demonstrates best practices for Flutter authentication implementation. Always follow security best practices when implementing authentication in production applications. 
=======
# Sarv-Suvidhaen
>>>>>>> e9caf3c4f4bb73e5d098b59c9f917c0c8bc32942
