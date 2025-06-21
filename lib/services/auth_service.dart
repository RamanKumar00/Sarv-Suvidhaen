import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  bool _isLoading = false;
  bool _isRemembered = false;
  bool _isAuthenticated = false;
  String? _userEmail;
  String? _userName;
  
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  bool get isRemembered => _isRemembered;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  
  AuthService() {
    _checkRememberedUser();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        _isAuthenticated = false;
        _userEmail = null;
        _userName = null;
      } else {
        _isAuthenticated = true;
        _userEmail = user.email;
        _userName = user.displayName;
      }
      notifyListeners();
    });
  }
  
  // Check if user was previously remembered
  Future<void> _checkRememberedUser() async {
    // Firebase Auth handles session persistence automatically.
    // The authStateChanges listener above will handle user state.
  }
  
  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      UserCredential userCredential;

      if (kIsWeb) {
        // For web, use signInWithPopup which is the recommended flow.
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        // For mobile, use the existing google_sign_in flow.
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          // The user canceled the sign-in
          _isLoading = false;
          notifyListeners();
          return false;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }

      final User? user = userCredential.user;

      if (user != null) {
        _userEmail = user.email;
        _userName = user.displayName;
        _isAuthenticated = true;

        if (_isRemembered) {
          await _storeUserSession();
        }
      }

      _isLoading = false;
      notifyListeners();
      return _isAuthenticated;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error signing in with Google: $e');
      return false;
    }
  }
  
  // Email/Password Sign In with Remember functionality
  Future<bool> signInWithEmailAndPassword(
    String email, 
    String password, 
    bool rememberMe
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock authentication - accept any valid email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        _userEmail = email;
        _userName = email.split('@')[0]; // Use email prefix as name
        _isAuthenticated = true;
        _isRemembered = rememberMe;
        
        if (rememberMe) {
          await _storeUserSession();
          await _secureStorage.write(key: 'remember_user', value: 'true');
        } else {
          await _clearUserSession();
          await _secureStorage.delete(key: 'remember_user');
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error signing in with email: $e');
      return false;
    }
  }
  
  // Email/Password Registration
  Future<bool> createUserWithEmailAndPassword(
    String email, 
    String password, 
    bool rememberMe
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock registration - accept any valid email/password
      if (email.isNotEmpty && password.length >= 6) {
        _userEmail = email;
        _userName = email.split('@')[0]; // Use email prefix as name
        _isAuthenticated = true;
        _isRemembered = rememberMe;
        
        if (rememberMe) {
          await _storeUserSession();
          await _secureStorage.write(key: 'remember_user', value: 'true');
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Invalid registration data');
      }
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error creating user: $e');
      return false;
    }
  }
  
  // Store user session securely
  Future<void> _storeUserSession() async {
    try {
      // Store user email securely
      if (_userEmail != null) {
        await _secureStorage.write(key: 'user_email', value: _userEmail!);
      }
      
      // Store display name securely
      if (_userName != null) {
        await _secureStorage.write(key: 'user_name', value: _userName!);
      }
      
      // Store last login timestamp
      await _secureStorage.write(
        key: 'last_login', 
        value: DateTime.now().millisecondsSinceEpoch.toString()
      );
      
    } catch (e) {
      debugPrint('Error storing user session: $e');
    }
  }
  
  // Clear user session
  Future<void> _clearUserSession() async {
    try {
      await _secureStorage.delete(key: 'user_email');
      await _secureStorage.delete(key: 'user_name');
      await _secureStorage.delete(key: 'last_login');
    } catch (e) {
      debugPrint('Error clearing user session: $e');
    }
  }
  
  // Get stored user info
  Future<Map<String, String?>> getStoredUserInfo() async {
    try {
      final userEmail = await _secureStorage.read(key: 'user_email');
      final userName = await _secureStorage.read(key: 'user_name');
      final lastLogin = await _secureStorage.read(key: 'last_login');
      
      return {
        'email': userEmail,
        'name': userName,
        'lastLogin': lastLogin,
      };
    } catch (e) {
      debugPrint('Error getting stored user info: $e');
      return {};
    }
  }
  
  // Sign Out
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _googleSignIn.signOut();
      await _auth.signOut();
      
      await _clearUserSession();
      await _secureStorage.delete(key: 'remember_user');
      
      _isAuthenticated = false;
      _isRemembered = false;
      _userEmail = null;
      _userName = null;
      _isLoading = false;
      notifyListeners();
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error signing out: $e');
    }
  }
  
  // Update remember me preference
  Future<void> updateRememberMe(bool remember) async {
    _isRemembered = remember;
    
    if (remember) {
      if (_isAuthenticated) {
        await _storeUserSession();
      }
      await _secureStorage.write(key: 'remember_user', value: 'true');
    } else {
      await _clearUserSession();
      await _secureStorage.delete(key: 'remember_user');
    }
    
    notifyListeners();
  }
  
  // Check if user session is valid
  Future<bool> isSessionValid() async {
    try {
      final lastLogin = await _secureStorage.read(key: 'last_login');
      
      if (lastLogin == null) {
        return false;
      }
      
      // Check if session is not older than 30 days
      final lastLoginTime = DateTime.fromMillisecondsSinceEpoch(int.parse(lastLogin));
      final now = DateTime.now();
      final difference = now.difference(lastLoginTime).inDays;
      
      return difference <= 30;
      
    } catch (e) {
      debugPrint('Error checking session validity: $e');
      return false;
    }
  }
} 