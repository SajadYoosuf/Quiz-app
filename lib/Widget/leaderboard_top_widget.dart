import 'package:flutter/material.dart';

Widget leaderBoardTop(BuildContext context, double hieght, double top,
    double left, String name, String score) {
  return Positioned(
    top: top,
    left: left,
    child: SizedBox(
      height: hieght * 4,
      child: Stack(
        children: [
          Container(
              width: 90,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  color: Color.fromARGB(255, 250, 248, 248)),
              child: Center(
                  child: Column(
                children: [
                  Text(name),
                  SizedBox(
                    height: 5,
                  ),
                  Text(score)
                ],
              ))),
        ],
      ),
    ),
  );
}
