// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildHomeScoreAndRankContainer(
    BuildContext context, double width, String score, int rank) {
  // Using MediaQuery to adjust the size of the container for different screen sizes
  var size = MediaQuery.of(context).size;
  var containerWidth = size.width * 0.90;

  return Container(
    width: containerWidth,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: AppColors.secondaryAppColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Ranking Icon and Text
        const Icon(
          Icons.emoji_events,
          color: Color.fromARGB(255, 243, 185, 60),
          size: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ranking",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            Text(
              rank.toString(),
              style: const TextStyle(
                  color: Color.fromARGB(255, 86, 203, 230), fontSize: 18),
            ),
          ],
        ),
        // Vertical Divider
        const VerticalDivider(
          color: Color.fromARGB(255, 143, 142, 142),
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
        // Points Icon and Text
        const Icon(
          Icons.paid_outlined,
          color: Color.fromARGB(255, 243, 185, 60),
          size: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Points",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            Text(
              score,
              style: const TextStyle(
                  color: Color.fromARGB(255, 86, 203, 230), fontSize: 18),
            ),
          ],
        ),
      ],
    ),
  );
}
