import 'package:flutter/material.dart';

//home screen top scoreboard (ranking/points) displaying container
Widget scoreBoardContainer(
    BuildContext context, double width, String score, int rank) {
  return Container(
    width: width * 0.90,
    height: 70,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: const Color.fromARGB(255, 77, 76, 76)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.emoji_events,
          color: Color.fromARGB(255, 243, 185, 60),
          size: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Ranking",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            Text(
              rank.toString(),
              style: TextStyle(
                  color: Color.fromARGB(255, 86, 203, 230), fontSize: 18),
            )
          ],
        ),
        VerticalDivider(
          color: Color.fromARGB(255, 143, 142, 142),
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
        Icon(
          Icons.paid_outlined,
          color: Color.fromARGB(255, 243, 185, 60),
          size: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Points",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            Text(
              score,
              style: TextStyle(
                  color: Color.fromARGB(255, 86, 203, 230), fontSize: 18),
            )
          ],
        ),
      ],
    ),
  );
}
