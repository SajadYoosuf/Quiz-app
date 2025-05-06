import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPageProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final signUpPageFormKey = GlobalKey<FormState>();

  bool passCheck = true;
  bool repeatPassCheck = true;

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Enter a valid email Address';
    }
    return null;
  }

  String? userNameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'need one lowercase letter,one number,';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'issing one number';
    }
    if (!RegExp(r'[!@#\$%\^&\*~]').hasMatch(value)) {
      return 'missing one special character';
    }

    return null;
  }

  String? repeatPasswordValidator(String value) {
    if (value != passwordController.text) {
      return 'Please enter The matching password';
    } else if (value.isEmpty) {
      return 'Please confirm your password';
    }
    return null;
  }

  /// Toggles password visibility for specified field
  void togglePasswordVisibility(String fieldName) {
    if (fieldName == 'Password') {
      passCheck = !passCheck;
    } else if (fieldName == 'RepeatPassword') {
      repeatPassCheck = !repeatPassCheck;
    }
    notifyListeners();
  }

  Future<Null>? registerNewUserWithEmailAndPassword(String email,
      String password, String fullName, BuildContext context) async {
    String currentEmail = email.trim();
    try {
      String result = await FirebaseAuthentication.registerWithEmailAndPassword(
        currentEmail,
        password,
      );
      await _handleRegistrationResult(
          result, fullName, email, password, context);
    } catch (e) {
      _showMessage(context, 'An unexpected error occurred: ${e.toString()}');
    }

    return null;
  }

  /// Handles the result of the registration process
  Future<void> _handleRegistrationResult(String result, String fullName,
      String email, String password, BuildContext context) async {
    if (result == 'account created succesfully') {
      // Save user info and navigate to home
      await _saveUserData(fullName);

      // Add user to Firestore database
      await FirebaseFirestoreData.addUser(
        fullName,
        email,
        password,
        FirebaseAuthentication.user?.photoURL ?? AssetPaths.profileImageNetwork,
      );

      _showMessage(context, 'Account created successfully');
      _navigateToHome(context);
    } else {
      // Show error message
      _showMessage(context, result);
    }
  }

  Future<void> _saveUserData(String fullName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(FirebaseKeys.userName, fullName);
    await prefs.setBool('auth', true);
  }

  void _navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when the provider is disposed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }
}
