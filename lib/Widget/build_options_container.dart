import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildOptionsContainer(
    String text, IconData icon, String head, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          head,
          style: AppStyles.smallHeadingStyle,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: AppStyles.smallHeadingStyle,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ),
  );
}
