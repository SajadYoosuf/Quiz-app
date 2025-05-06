import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_options_layout_by_length.dart';
import 'package:quiz_app/Widget/QuizScreen/build_question_container.dart';
import 'package:quiz_app/Widget/QuizScreen/build_top_bar.dart';

Widget buildQuizContent(QuizScreenProvider quizProvider, double width,
    double height, BuildContext context) {
  return Column(
    children: [
      SizedBox(height: height * 0.05),
      buildTopBar(quizProvider, width, height, context),
      buildQuestionContainer(
        quizProvider,
        width,
        height,
      ),
      buildOptionsContainer(quizProvider, height, width, context),
    ],
  );
}
