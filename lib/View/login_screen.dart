import 'package:quiz_app/ViewModel/login_screen_provider.dart';
import 'package:quiz_app/Widget/build_action_button_with_image.dart';
import 'package:quiz_app/Widget/build_header_logo.dart';
import 'package:quiz_app/Widget/build_text_button.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/Widget/custom_text_field.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginPageProvider>(context);
    MediaQueryScreenSizes.int(context);

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      body: SingleChildScrollView(
        child: Form(
          key: loginProvider.loginPageFormKey,
          child: Column(
            children: [
              buildHeaderLogo(MediaQueryScreenSizes.screenWidth,
                  MediaQueryScreenSizes.screenheight),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.05),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.09,
                  child: buildCustomTextField(
                    context: context,
                    title: 'Email',
                    leftIcon: AppIcons.emailIcon,
                    controller: loginProvider.emailController,
                    validator: (value) => loginProvider.emailValidator(value!),
                  )),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.01),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.09,
                  child: buildCustomTextField(
                    context: context,
                    title: 'Password',
                    leftIcon: AppIcons.passwordIcon,
                    controller: loginProvider.passController,
                    validator: (value) =>
                        loginProvider.passwordValidator(value!),
                    obscureText: true,
                    isPassword: loginProvider.passCheck,
                    onVisibilityToggle: () =>
                        loginProvider.togglePasswordVisiblity(),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQueryScreenSizes.screenWidth * 0.60),
                  child:
                      buildTextButton(context, AppRoutes.reset, 'Password?')),
              CustomActionButton(
                text: 'Log in',
                width: MediaQueryScreenSizes.screenWidth * 0.70,
                height: MediaQueryScreenSizes.screenWidth * 0.07,
                onPressed: () {
                  if (loginProvider.loginPageFormKey.currentState!.validate()) {
                    loginProvider.loginWithEmailAndPassword(
                      loginProvider.emailController.text,
                      loginProvider.passController.text,
                      // ignore: use_build_context_synchronously
                      context,
                    );
                  }
                },
              ),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.02),
              const Align(
                alignment: Alignment.center,
                child: Text("Don't have an account?",
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.02),
              CustomActionButton(
                  text: 'Sign Up',
                  onPressed: () {
                    final authentication = context.read<LoginPageProvider>();
                    authentication.emailController.text = '';
                    authentication.passController.text = '';
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  width: MediaQueryScreenSizes.screenWidth,
                  height: MediaQueryScreenSizes.screenheight),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.02),
              const Align(
                alignment: Alignment.center,
                child: Text("or", style: TextStyle(color: Colors.white)),
              ),
              buildActionButtonWithImage(
                  MediaQueryScreenSizes.screenWidth, context)
            ],
          ),
        ),
      ),
    );
  }
}
