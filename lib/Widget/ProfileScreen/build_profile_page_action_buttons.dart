import 'package:flutter/material.dart';

Widget buildProfilePageActionButtons(
    BuildContext context,
    String heading,
    Color color,
    String screenRoute,
    Color textColor,
    double width,
    double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        vertical: 8.0), // Add vertical spacing between buttons
    child: SizedBox(
      width: width *
          0.65, // Width passed to function (can be responsive or static)
      height: height * 0.065, // Height adjusted based on screen height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded button corners
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
              context, screenRoute); // Navigate to the given route
        },
        child: Text(
          heading,
          style: TextStyle(
            color: textColor,
            fontSize: 13, // Responsive text size
            fontWeight: FontWeight.bold, // Optional: to emphasize text
          ),
        ),
      ),
    ),
  );
}
