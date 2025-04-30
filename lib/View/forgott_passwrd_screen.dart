import 'package:quiz_app/ViewModel/reset_password_page.dart';
import 'package:quiz_app/ViewModel/signup_provider.dart';
import 'package:quiz_app/Widget/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgottPasswrdScreen extends StatelessWidget {
  ForgottPasswrdScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final resetPassword = Provider.of<ResetPasswordPage>(context);
    final reset = Provider.of<SignUpPageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF1f1147),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1f1147),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 50),
          child: Column(
            children: [
              SizedBox(
                  width: width * 0.90,
                  height: 70,
                  child: textField(
                      context,
                      'Password',
                      const Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                      true,
                      reset.passCheck,
                      resetPassword.newPassController,
                      2)),
              SizedBox(
                  width: width * 0.90,
                  height: 70,
                  child: textField(
                      context,
                      'Repeat Password',
                      const Icon(
                        Icons.key,
                        color: Colors.white,
                      ),
                      true,
                      reset.repeatPassCheck,
                      resetPassword.repeatPassController,
                      2)),
              SizedBox(
                width: width * 0.50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                    side: const BorderSide(
                        color: Colors.white,
                        width: 2), // Set the border color and width
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resetPassword.resetPassword(
                          resetPassword.repeatPassController.text, context);
                    }
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
