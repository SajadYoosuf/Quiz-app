import 'package:quiz_app/ViewModel/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ViewModel/signup_provider.dart';

//this textfield for login and signup
Widget textField(BuildContext coxt, String title, Icon leftIcon, bool passCheck,
    bool visiblityCheck, TextEditingController controller, int screen) {
  final login = Provider.of<LoginPageProvider>(coxt);
  final signUp = Provider.of<SignUpPageProvider>(coxt);

  return passCheck
      ? TextFormField(
          controller: controller,
          obscureText: visiblityCheck,
          style: TextStyle(color: Colors.white),
          obscuringCharacter: '*',
          validator: (value) => screen == 1
              ? login.validityChecking(title, value!)
              : signUp.validityChecking(title, value!),
          decoration: InputDecoration(
              prefixIcon: leftIcon,
              suffixIcon: InkWell(
                  onTap: () => screen == 1
                      ? login.changeVisiblity(title)
                      : signUp.changeVisiblity(title),
                  child: visiblityCheck
                      ? Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        )
                      : Icon(Icons.visibility, color: Colors.white)),
              filled: true,
              hintText: title,
              hintStyle: TextStyle(color: Colors.white),
              fillColor: Colors.black,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(22))),
        )
      : TextFormField(
          controller: controller,
          validator: (value) => screen == 1
              ? login.validityChecking(title, value!)
              : signUp.validityChecking(title, value!),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: leftIcon,
              filled: true,
              hintText: title,
              hintStyle: TextStyle(color: Colors.white),
              fillColor: Colors.black,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(22))),
        );
}
