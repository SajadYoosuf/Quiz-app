import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildQuestionBox(
  QuizScreenProvider quizProvider,
  double width,
  double height,
) {
  return Positioned(
    top: 40,
    left: 10,
    child: Container(
      margin: EdgeInsets.only(left: width * 0.03),
      width: width * 0.90,
      height: height * 0.28,
      decoration: BoxDecoration(
        color: AppColors.secondaryAppColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
            quizProvider.quizData.results[quizProvider.currentIndex].question,
            style: AppStyles.subHeadingStyle),
      ),
    ),
  );
}
