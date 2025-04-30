import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpPageProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool passCheck = true;
  bool repeatPassCheck = true;

  void changeVisiblity(String check) {
    switch (check) {
      case 'Password':
        switch (passCheck) {
          case true:
            passCheck = false;
            break;
          case false:
            passCheck = true;
            break;
        }
        break;

      case 'Repeat Password':
        switch (repeatPassCheck) {
          case true:
            repeatPassCheck = false;
            break;
          case false:
            repeatPassCheck = true;
            break;
        }
        break;
    }
    notifyListeners();
  }

  String? validityChecking(String type, String value) {
    switch (type) {
      case 'UserName':
        if (value.isEmpty) {
          return 'Please enter your name';
        }
      case 'Email':
        if (value.isEmpty) {
          return 'Please enter your email address';
        }
        if (!value.contains('@gmail.com')) {
          return 'Please enter a valid email address';
        }
        return null;
      case 'Password':
        if (value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (!RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%\^&\*~]).{8,}$')
            .hasMatch(value)) {
          return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
        }

        return null;
      case 'Repeat Password':
        if (value != passwordController.text) {
          return 'Repeat Password Not Matching With Password';
        } else if (value.isEmpty) {
          return 'Please enter The matching password';
        }

      default:
    }
    notifyListeners();
    return null;
  }

  Future<Null>? registerNewUserWithEmailAndPassword(
      String email, String password, String userName, BuildContext context) {
    FirebaseAuthentication.registerWithEmailAndPassword(email, password)
        .then((onValue) async {
      if (onValue == 'The password provided is too weak.') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          onValue,
          style: TextStyle(color: Colors.white),
        )));
      } else if (onValue == 'The account already exists for that email.') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(onValue, style: TextStyle(color: Colors.white))));
      } else if (onValue != 'account created succesfully') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(onValue, style: TextStyle(color: Colors.white))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('account created succesfully',
                style: TextStyle(color: Colors.white))));
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_name', userName);
        prefs.setBool('auth', true);
        FirebaseFirestoreData.addUser(
            fullName: userName, email: email, password: password, photoUrl: '');
        Future.delayed(const Duration(seconds: 2))
            .then((onValue) => Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen())));
      }
    });
    return null;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    FirebaseAuthentication.signInWithGoogle().then((onValue) async {
      if (onValue != 'Successfully completed') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(onValue)));
      } else {
        // Do something with the user
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('account created succesfully',
                style: TextStyle(color: Colors.white))));
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', true);
        Future.delayed(const Duration(seconds: 2))
            .then((onValue) => Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen())));
      }
    });
  }
}
