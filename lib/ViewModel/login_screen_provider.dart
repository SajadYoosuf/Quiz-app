import 'package:email_validator/email_validator.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPageProvider extends ChangeNotifier {
  bool passCheck = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final loginPageFormKey = GlobalKey<FormState>();

  void togglePasswordVisiblity() {
    passCheck = !passCheck;
    notifyListeners();
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  void loginWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    String currentEmail = emailAddress.trim();
    try {
      String result = await FirebaseAuthentication.loginWithEmailAndPassword(
          currentEmail, password);
      await _handleLoginResult(result, context);
    } catch (e) {
      _showMessage(context, 'An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      String result = await FirebaseAuthentication.signInWithGoogle();
      await _handleGoogleSignInResult(result, context);
    } catch (e) {
      _showMessage(context, 'An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> _handleLoginResult(String result, BuildContext context) async {
    if (result == AuthResults.loginSuccess) {
      await _saveAuthState();
      _showMessage(context, 'Login successful');
      _navigateToHome(context);
    } else {
      _showMessage(context, result);
    }
  }

  /// Handles Google sign-in result and performs appropriate actions
  Future<void> _handleGoogleSignInResult(
      String result, BuildContext context) async {
    if (result == AuthResults.googleSignInSuccess) {
      await _saveAuthState();
      _showMessage(context, 'Login successful');
      _navigateToHome(context);
    } else if (result == AuthResults.nullValueError) {
      _showMessage(context, 'Please choose an account');
    } else {
      _showMessage(context, result);
    }
  }

  /// Saves authentication state to shared preferences
  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', true);
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    // Clean up controllers when the provider is disposed
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
