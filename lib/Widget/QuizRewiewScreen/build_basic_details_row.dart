import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_rewiew_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildBasicDetailsRow(
    double width, QuizRewiewProvider quizRewiewProvider) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.scoreboard_rounded,
        color: Colors.green,
        size: width * 0.05,
      ),
      Text(
        'Total Score : ${quizRewiewProvider.totalScore}',
        style: AppStyles.smallHeadingStyle,
      ),
      SizedBox(width: width * 0.07),
      Icon(
        Icons.timer,
        color: Colors.white,
        size: width * 0.05,
      ),
      Text(
        'Total Time : ${quizRewiewProvider.totalTimeSpent}',
        style: AppStyles.smallHeadingStyle,
      ),
    ],
  );
}
