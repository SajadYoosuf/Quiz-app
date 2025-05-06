import 'package:flutter/material.dart';

//this both for login and signup page heading
Widget buildHeaderLogo(double width, double height) {
  return Container(
    padding: EdgeInsets.only(top: height * 0.05),
    width: width,
    height: height * 0.30,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 44, 23, 96),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(130),
        bottomRight: Radius.circular(130),
      ),
    ),
    child: Image.asset(
      'assets/images/final_logo.png',
      width: width * 0.25,
      height: height * 0.1,
      fit: BoxFit.contain,
    ),
  );
}
