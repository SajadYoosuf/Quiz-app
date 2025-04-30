import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends ChangeNotifier {
  TextEditingController newPassController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  bool passwordCheck = true;
  bool repeatPassCheck = true;

  void changeVisiblity(String check) {
    switch (check) {
      case 'Password':
        switch (passwordCheck) {
          case true:
            passwordCheck = false;
            break;
          case false:
            passwordCheck = true;
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

  Future<Null>? resetPassword(String newPassword, BuildContext context) {
    FirebaseAuthentication.resetPassword(newPassword).then((onValue) {
      if (onValue != 'Successfully changed your password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(onValue)));
      } else {
        FirebaseFirestoreData.updateUserData('password', newPassword);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully changed your password')));
      }
    });
    return null;
  }
}
