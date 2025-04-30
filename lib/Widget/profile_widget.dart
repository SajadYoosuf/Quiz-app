import 'package:flutter/material.dart';

Widget profilePrgressCard(
    BuildContext context, IconData icon, String title, String heading) {
  return Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color.fromARGB(255, 212, 208, 208)),
        child: Icon(icon),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(heading,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ),
      )
    ],
  );
}
