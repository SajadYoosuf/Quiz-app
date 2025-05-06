import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreenProvider extends ChangeNotifier {
  TextEditingController newPassController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  bool passwordCheck = true;
  bool repeatPassCheck = true;
  void togglePasswordVisiblity(String fieldName) {
    if (fieldName == "Password") {
      passwordCheck = !passwordCheck;
    } else {
      repeatPassCheck = !repeatPassCheck;
    }
    notifyListeners();
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
      return 'Password must include one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must include  one number';
    }
    if (!RegExp(r'[!@#\$%\^&\*~]').hasMatch(value)) {
      return 'Password must include one special character';
    }

    return null;
  }

  String? repeatPasswordValidator(String value) {
    if (value != newPassController.text) {
      return 'Please confirm your password';
    } else if (value.isEmpty) {
      return 'Please enter The matching password';
    }
    return null;
  }

  Future<Null>? resetPassword(String newPassword, BuildContext context) async {
    try {
      String result = await FirebaseAuthentication.resetPassword(newPassword);
      _handleResetResult(result, newPassword, context);
    } catch (e) {
      _showMessage(context, 'An unexpected error occurred: ${e.toString()}');
    }

    return null;
  }

  void _handleResetResult(
      String result, String newPassword, BuildContext context) {
    if (result == 'Successfully changed your password') {
      // Update password in Firestore
      FirebaseFirestoreData.updateUserData('password', newPassword);
      _showMessage(context, result);

      // Clear form fields after successful reset
      newPassController.clear();
      repeatPassController.clear();
    } else {
      _showMessage(context, result);
    }
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
    newPassController.dispose();
    repeatPassController.dispose();
    super.dispose();
  }
}
