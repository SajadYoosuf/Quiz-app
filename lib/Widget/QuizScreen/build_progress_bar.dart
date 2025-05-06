import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildProgressBar(QuizScreenProvider quizProvider, double width) {
  return Stack(
    children: [
      Positioned(
        left: 15,
        top: 11,
        child: Container(
          width: 220,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppColors.whiteColor,
          ),
        ),
      ),
      Positioned(
        left: 15,
        top: 11,
        child: Container(
          width: quizProvider.currentQuestionIndexByContainerPercentage,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color.fromARGB(255, 241, 217, 1),
          ),
        ),
      ),
      Positioned(
        top: 8,
        right: 5,
        child: Text(
          quizProvider.currentIndex == 9
              ? '10/10'
              : "0${quizProvider.currentIndex + 1}/10",
          style: const TextStyle(
            color: Color(0xFF32c8ad),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
