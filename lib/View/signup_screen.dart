import 'package:quiz_app/ViewModel/signup_screen_provider.dart';
import 'package:quiz_app/Widget/build_header_logo.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/Widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utilities/constant.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);
    final signUpPage = Provider.of<SignUpPageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      body: SingleChildScrollView(
        child: Form(
          key: signUpPage.signUpPageFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeaderLogo(MediaQueryScreenSizes.screenWidth,
                  MediaQueryScreenSizes.screenheight),
              SizedBox(
                  height: MediaQueryScreenSizes.screenheight *
                      0.03), // Adjust space between sections
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.08,
                  child: buildCustomTextField(
                      context: context,
                      title: 'UserName',
                      leftIcon: AppIcons.nameIcon,
                      controller: signUpPage.nameController,
                      validator: (value) =>
                          signUpPage.userNameValidator(value!))),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.08,
                  child: buildCustomTextField(
                      context: context,
                      title: 'Email',
                      leftIcon: AppIcons.emailIcon,
                      controller: signUpPage.emailController,
                      validator: (value) => signUpPage.emailValidator(value!))),
              SizedBox(
                width: MediaQueryScreenSizes.screenWidth * 0.90,
                height: MediaQueryScreenSizes.screenheight * 0.08,
                child: buildCustomTextField(
                  context: context,
                  title: 'Password',
                  leftIcon: AppIcons.passwordIcon,
                  controller: signUpPage.passwordController,
                  validator: (value) => signUpPage.passwordValidator(value!),
                  onVisibilityToggle: () =>
                      signUpPage.togglePasswordVisibility('Password'),
                ),
              ),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.08,
                  child: buildCustomTextField(
                    context: context,
                    title: 'Repeat Password',
                    leftIcon: AppIcons.rePasswordIcon,
                    controller: signUpPage.repeatPasswordController,
                    validator: (value) =>
                        signUpPage.repeatPasswordValidator(value!),
                    onVisibilityToggle: () =>
                        signUpPage.togglePasswordVisibility('Repeat Password'),
                  )),
              SizedBox(
                  height: MediaQueryScreenSizes.screenheight *
                      0.02), // Adjust space between form and button
              CustomActionButton(
                  text: 'Sign up',
                  onPressed: () {
                    if (signUpPage.signUpPageFormKey.currentState!.validate()) {
                      signUpPage.registerNewUserWithEmailAndPassword(
                        signUpPage.emailController.text,
                        signUpPage.passwordController.text,
                        signUpPage.nameController.text,
                        context,
                      );
                    }
                  },
                  width: MediaQueryScreenSizes.screenWidth,
                  height: MediaQueryScreenSizes.screenheight),
              SizedBox(
                  height: MediaQueryScreenSizes.screenheight *
                      0.02), // Adjust space after sign up button
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                  height: MediaQueryScreenSizes.screenheight *
                      0.02), // Adjust space before login button
              CustomActionButton(
                  text: 'Log in',
                  onPressed: () {
                    signUpPage.emailController.text = '';
                    signUpPage.passwordController.text = '';
                    signUpPage.nameController.text = '';
                    signUpPage.repeatPasswordController.text = '';
                    Navigator.pop(context);
                  },
                  width: MediaQueryScreenSizes.screenWidth,
                  height: MediaQueryScreenSizes.screenheight),
            ],
          ),
        ),
      ),
    );
  }
}
