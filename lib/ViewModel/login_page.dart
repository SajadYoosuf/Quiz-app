import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPageProvider extends ChangeNotifier {
  bool passCheck = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

//this for visiblity the password for every textfied on login page and sign up page
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
    }
    notifyListeners();
  }

  String? validityChecking(String type, String value) {
    switch (type) {
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
          return 'Please enter your password';
        }

        return null;
      default:
    }
    notifyListeners();
    return null;
  }

  void loginWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    await FirebaseAuthentication.loginWithEmailAndPassword(
            emailAddress, password)
        .then((onValue) async {
      if (onValue == 'No user found for that email.') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(onValue, style: TextStyle(color: Colors.white))));
      } else if (onValue == ' you enterd Wrong password ') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(onValue, style: TextStyle(color: Colors.white))));
      } else {
        final prefs = await SharedPreferences.getInstance();

        prefs.setBool('auth', true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login successfully',
                style: TextStyle(color: Colors.white))));
        Future.delayed(const Duration(seconds: 2));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    FirebaseAuthentication.signInWithGoogle().then((onValue) async {
      if (onValue == 'Null check operator used on a null value') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please choose an account',
                style: TextStyle(color: Colors.white))));
      } else if (onValue != 'Successfully completed') {
        // Do something with the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          onValue,
          style: TextStyle(color: Colors.white),
        )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully completed',
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
