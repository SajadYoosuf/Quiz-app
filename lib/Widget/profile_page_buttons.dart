import 'package:flutter/material.dart';

Widget profilePageButtons(BuildContext context, String heading, Color color,
    Widget screen, Color textColor, double width) {
  return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: Text(
            heading,
            style: TextStyle(color: textColor),
          )));
}
