import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_countdown_timer.dart';
import 'package:quiz_app/Widget/QuizScreen/build_question_box.dart';

Widget buildQuestionContainer(
  QuizScreenProvider quizProvider,
  double width,
  double height,
) {
  return SizedBox(
    height: height * 0.30,
    child: Stack(
      children: [
        buildQuestionBox(quizProvider, width, height),
        buildCountdownTimer(quizProvider, width),
      ],
    ),
  );
}
