import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_next_button.dart';
import 'package:quiz_app/Widget/build_quiz_options_container.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildTwoOptionsLayout(QuizScreenProvider quizProvider, double height,
    double width, BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 50),
      buildQuizOptionContainer(
          context,
          AppColors.containerColors[0],
          AppIcons.optionIcons[0],
          quizProvider.options[0],
          0,
          quizProvider,
          width,
          height),
      const SizedBox(height: 30),
      buildQuizOptionContainer(
          context,
          AppColors.containerColors[1],
          AppIcons.optionIcons[1],
          quizProvider.options[1],
          1,
          quizProvider,
          width,
          height),
      SizedBox(height: height * 0.17),
      buildNextButton(context),
    ],
  );
}
