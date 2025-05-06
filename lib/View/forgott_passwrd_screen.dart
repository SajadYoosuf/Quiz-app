import 'package:quiz_app/ViewModel/forgot_password_screen_provider.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/Widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utilities/constant.dart';

class ForgottPasswrdScreen extends StatelessWidget {
  const ForgottPasswrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider =
        Provider.of<ForgotPasswordScreenProvider>(context);

    MediaQueryScreenSizes.int(context);

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryAppColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: MediaQueryScreenSizes.screenWidth * 0.065,
          ),
        ),
        title: const Text('Forgot Password', style: AppStyles.headingStyle),
      ),
      body: Form(
        key: forgotPasswordProvider.forgotPasswordFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQueryScreenSizes.screenWidth * 0.05,
              vertical: MediaQueryScreenSizes.screenheight * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.08,
                  child: buildCustomTextField(
                    context: context,
                    title: 'Password',
                    leftIcon: AppIcons.passwordIcon,
                    controller: forgotPasswordProvider.newPassController,
                    validator: (value) =>
                        forgotPasswordProvider.passwordValidator(value!),
                    isPassword: true,
                    obscureText: forgotPasswordProvider.passwordCheck,
                    onVisibilityToggle: () => forgotPasswordProvider
                        .togglePasswordVisiblity('Password'),
                  )),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.03),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.90,
                  height: MediaQueryScreenSizes.screenheight * 0.08,
                  child: buildCustomTextField(
                    context: context,
                    title: 'Repeat Password',
                    leftIcon: AppIcons.rePasswordIcon,
                    controller: forgotPasswordProvider.repeatPassController,
                    validator: (value) =>
                        forgotPasswordProvider.repeatPasswordValidator(value!),
                    isPassword: true,
                    obscureText: forgotPasswordProvider.repeatPassCheck,
                    onVisibilityToggle: () => forgotPasswordProvider
                        .togglePasswordVisiblity('Repeat Password'),
                  )),
              SizedBox(height: MediaQueryScreenSizes.screenheight * 0.05),
              SizedBox(
                  width: MediaQueryScreenSizes.screenWidth * 0.5,
                  height: MediaQueryScreenSizes.screenheight * 0.06,
                  child: CustomActionButton(
                      text: 'Change Password',
                      onPressed: () {
                        if (forgotPasswordProvider
                            .forgotPasswordFormKey.currentState!
                            .validate()) {
                          forgotPasswordProvider.resetPassword(
                            forgotPasswordProvider.repeatPassController.text,
                            context,
                          );
                        }
                      },
                      width: MediaQueryScreenSizes.screenWidth,
                      height: MediaQueryScreenSizes.screenheight)),
            ],
          ),
        ),
      ),
    );
  }
}
