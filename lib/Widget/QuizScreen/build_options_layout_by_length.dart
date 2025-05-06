import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_multi_options_layout.dart';
import 'package:quiz_app/Widget/QuizScreen/build_two_options_layout.dart';

Widget buildOptionsContainer(QuizScreenProvider quizProvider, double height,
    double width, BuildContext context) {
  if (quizProvider.options.length == 2) {
    return buildTwoOptionsLayout(quizProvider, height, width, context);
  } else {
    return buildMultiOptionsLayout(quizProvider, height, width, context);
  }
}
