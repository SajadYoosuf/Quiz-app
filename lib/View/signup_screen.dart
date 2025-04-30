import 'package:quiz_app/ViewModel/signup_provider.dart';
import 'package:quiz_app/Widget/textField.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var hieght = size.height;
    final signUpPage = Provider.of<SignUpPageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1f1147),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 50, left: 0),
                  width: width,
                  height: hieght * 0.30,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 44, 23, 96),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(130),
                      bottomRight: Radius.circular(130),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/final_logo.png',
                    width: 100,
                    height: 30,
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: width * 0.90,
                  height: 70,
                  child: textField(
                      context,
                      'UserName',
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      false,
                      false,
                      signUpPage.nameController,
                      2)),
              SizedBox(
                  width: width * 0.90,
                  height: 70,
                  child: textField(
                      context,
                      'Email',
                      const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      false,
                      false,
                      signUpPage.emailController,
                      2)),
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
                      signUpPage.passCheck,
                      signUpPage.passwordController,
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
                      signUpPage.repeatPassCheck,
                      signUpPage.repeatPasswordController,
                      2)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    print(signUpPage.emailController.text);
                    signUpPage.registerNewUserWithEmailAndPassword(
                        signUpPage.emailController.text,
                        signUpPage.passwordController.text,
                        signUpPage.nameController.text,
                        context);
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                  ),
                  side: BorderSide(
                      color: Colors.white,
                      width: 2), // Set the border color and width

                  backgroundColor: Colors.black,
                  minimumSize: Size(width * 0.70, 50),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                  ),
                  side: BorderSide(
                      color: Colors.white,
                      width: 2), // Set the border color and width

                  backgroundColor: Colors.black,
                  minimumSize: Size(width * 0.70, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
