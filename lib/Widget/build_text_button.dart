import 'package:flutter/material.dart';

Widget buildTextButton(
    BuildContext context, String screenRoute, String heading) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, screenRoute);
    },
    child: const Text(
      'Password?',
      style: TextStyle(color: Colors.white),
    ),
  );
}
