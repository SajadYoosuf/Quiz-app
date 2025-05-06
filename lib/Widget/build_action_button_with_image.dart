import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ViewModel/login_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

//this using for login page google sign in
Widget buildActionButtonWithImage(double width, BuildContext context) {
  return SizedBox(
    width: width * 0.50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      onPressed: () async {
        context.read<LoginPageProvider>().signInWithGoogle(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Sign in with ', style: TextStyle(color: Colors.white)),
          Container(
            width: width * 0.08,
            height: width * 0.08,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AssetPaths.googleLogo),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
