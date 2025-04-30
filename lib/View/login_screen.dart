import 'package:quiz_app/View/forgott_passwrd_screen.dart';
import 'package:quiz_app/View/signup_screen.dart';
import 'package:quiz_app/ViewModel/login_page.dart';
import 'package:quiz_app/ViewModel/reset_password_page.dart';
import 'package:quiz_app/Widget/textField.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authentication = Provider.of<LoginPageProvider>(context);
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var hieght = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1f1147),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                    height: 20,
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 50,
              ),
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
                      authentication.emailController,
                      1)),
              const SizedBox(
                height: 10,
              ),
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
                      authentication.passCheck,
                      authentication.passController,
                      1)),
              // SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 243),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgottPasswrdScreen()));
                  },
                  child: const Text(
                    'Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    Future.delayed(const Duration(seconds: 1)).then((_) {
                      authentication.loginWithEmailAndPassword(
                          authentication.emailController.text,
                          authentication.passController.text,
                          context);
                    });
                  }
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
                  side: const BorderSide(
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
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
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
                  side: const BorderSide(
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
                  "or",
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
                  onPressed: () async {
                    authentication.signInWithGoogle(context).then((onValue) {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Sign in with ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(google),
                                fit: BoxFit.fitWidth)),
                      ),
                    ],
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
