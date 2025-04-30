import 'package:flutter/material.dart';

Widget optionsContainer(String text, IconData icon, String head, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: color,
        size: 20,
      ),
      Text(
        head,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Expanded(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    ],
  );
}
