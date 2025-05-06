import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final Color borderColor;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderRadius = 20,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
