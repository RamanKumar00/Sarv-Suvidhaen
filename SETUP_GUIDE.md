# Setup Guide - Password Remember Flutter App

This guide will walk you through setting up Firebase and Google OAuth for the Password Remember Flutter application.

## 🔥 Firebase Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "password-remember-app")
4. Choose whether to enable Google Analytics (recommended)
5. Click "Create project"

### Step 2: Enable Authentication

1. In your Firebase project, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to the "Sign-in method" tab
4. Enable "Email/Password" provider
5. Enable "Google" provider
6. For Google provider, add your authorized domains

### Step 3: Add Your App

#### For Android:
1. Click the Android icon to add an Android app
2. Enter package name: `com.example.password_remember`
3. Enter app nickname: "Password Remember"
4. Click "Register app"
5. Download `google-services.json`
6. Place it in `android/app/google-services.json`

#### For iOS:
1. Click the iOS icon to add an iOS app
2. Enter bundle ID: `com.example.passwordRemember`
3. Enter app nickname: "Password Remember"
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Place it in `ios/Runner/GoogleService-Info.plist`

### Step 4: Generate Firebase Options

1. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

2. Configure Firebase for your app:
   ```bash
   flutterfire configure
   ```

3. This will generate the `firebase_options.dart` file with your actual configuration.

## 🔐 Google OAuth Setup

### Step 1: Google Cloud Console

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project (or create a new one)
3. Enable the Google+ API:
   - Go to "APIs & Services" > "Library"
   - Search for "Google+ API"
   - Click "Enable"

### Step 2: Create OAuth 2.0 Credentials

1. Go to "APIs & Services" > "Credentials"
2. Click "Create Credentials" > "OAuth 2.0 Client IDs"
3. Choose "Android" for Android app
4. Enter package name: `com.example.password_remember`
5. Generate SHA-1 fingerprint:
   ```bash
   cd android
   ./gradlew signingReport
   ```
6. Copy the SHA-1 fingerprint and paste it in the Google Cloud Console
7. Click "Create"

### Step 3: Configure iOS (if needed)

1. In Google Cloud Console, create another OAuth 2.0 Client ID
2. Choose "iOS" for iOS app
3. Enter bundle ID: `com.example.passwordRemember`
4. Click "Create"

## 📱 App Configuration

### Step 1: Update Firebase Options

Replace the placeholder values in `firebase_options.dart` with your actual Firebase configuration:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-actual-api-key',
  appId: 'your-actual-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  storageBucket: 'your-actual-project-id.appspot.com',
);
```

### Step 2: Update iOS Info.plist

Replace `YOUR_REVERSED_CLIENT_ID` in `ios/Runner/Info.plist` with your actual reversed client ID from `GoogleService-Info.plist`:

```xml
<string>com.googleusercontent.apps.YOUR_ACTUAL_CLIENT_ID</string>
```

### Step 3: Update Main.dart

Make sure your `main.dart` imports the Firebase options:

```dart
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

## 🧪 Testing

### Test Google Sign-In

1. Run the app: `flutter run`
2. Navigate to the login screen
3. Tap "Continue with Google"
4. Select your Google account
5. Verify you're redirected to the home screen

### Test Email/Password

1. Create a test account using the registration screen
2. Try logging in with the created credentials
3. Test the "Remember my password" functionality
4. Close and reopen the app to verify session persistence

### Test Error Handling

1. Try logging in with invalid credentials
2. Test network connectivity issues
3. Verify error messages are user-friendly

## 🔧 Troubleshooting

### Common Issues

#### Google Sign-In Not Working
- Verify SHA-1 fingerprint is correct
- Check package name matches exactly
- Ensure Google+ API is enabled
- Verify OAuth 2.0 credentials are configured

#### Firebase Connection Issues
- Check `google-services.json` is in correct location
- Verify Firebase project configuration
- Ensure Authentication is enabled in Firebase Console

#### Build Errors
- Run `flutter clean` and `flutter pub get`
- Check Flutter and Dart SDK versions
- Verify all dependencies are compatible

### Debug Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check Firebase configuration
flutterfire configure

# Generate SHA-1 fingerprint
cd android && ./gradlew signingReport
```

## 📋 Checklist

- [ ] Firebase project created
- [ ] Authentication enabled (Email/Password + Google)
- [ ] Android app added to Firebase
- [ ] iOS app added to Firebase (if needed)
- [ ] `google-services.json` downloaded and placed correctly
- [ ] `GoogleService-Info.plist` downloaded and placed correctly
- [ ] Google Cloud Console OAuth 2.0 credentials created
- [ ] SHA-1 fingerprint added to Google Cloud Console
- [ ] Firebase options updated with actual configuration
- [ ] iOS Info.plist updated with reversed client ID
- [ ] App tested with Google Sign-In
- [ ] App tested with Email/Password authentication
- [ ] Remember password functionality tested
- [ ] Error handling verified

## 🚀 Next Steps

Once setup is complete:

1. Test all authentication flows
2. Customize the UI to match your brand
3. Add additional security features if needed
4. Deploy to app stores
5. Monitor Firebase Analytics for usage insights

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review Firebase documentation
3. Check Flutter and plugin documentation
4. Create an issue in the repository

---

**Note**: Keep your Firebase configuration files secure and never commit them to public repositories. Use environment variables or secure storage for production deployments. 