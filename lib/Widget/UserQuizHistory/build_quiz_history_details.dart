import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/Widget/UserQuizHistory/build_quiz_history_list_widget.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildQuizHistoryDetails(BuildContext context, double width,
    double hieght, List<QuizHistory> quizHistory) {
  return SizedBox(
    width: width,
    height: hieght,
    child: Stack(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CachedNetworkImage(
                imageUrl: AssetPaths.welcomeImageNetwork,
                width: width * 0.55, // Adjusted with MediaQuery
                height: hieght * 0.18, // Adjusted with MediaQuery
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: hieght * 0.66 - 1,
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Color(0xff7358ee),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                buildQuizHistoryListContainer(width, hieght, quizHistory)
              ]),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        Positioned(bottom: 0, child: buildNavigationWidget(context))
      ],
    ),
  );
}
