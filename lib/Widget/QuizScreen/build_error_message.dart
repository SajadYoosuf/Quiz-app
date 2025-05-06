import 'package:flutter/material.dart';

Widget buildErrorMessage(double height, BuildContext context) {
  return Center(
    child: Column(
      children: [
        SizedBox(height: height * 0.50),
        const Icon(
          Icons.warning,
          color: Colors.amber,
          size: 50,
        ),
        const Text(
          'Please connect to internet',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Back To Home',
            style: TextStyle(fontSize: 17),
          ),
        ),
      ],
    ),
  );
}
