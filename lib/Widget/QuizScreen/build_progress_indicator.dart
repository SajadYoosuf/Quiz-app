import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_progress_bar.dart';

Widget buildProgressIndicator(
  QuizScreenProvider quizProvider,
  double width,
  double height,
) {
  return Container(
    width: width * 0.80,
    height: height * 0.05,
    decoration: BoxDecoration(
      border: const Border(
        top: BorderSide(color: Colors.white, width: 2),
        right: BorderSide(color: Colors.white, width: 2),
        bottom: BorderSide(color: Colors.white, width: 2),
        left: BorderSide(color: Colors.white, width: 2),
      ),
      borderRadius: BorderRadius.circular(22),
    ),
    child: buildProgressBar(quizProvider, width),
  );
}
