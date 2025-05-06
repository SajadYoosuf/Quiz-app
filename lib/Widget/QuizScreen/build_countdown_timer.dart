import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildCountdownTimer(QuizScreenProvider quizProvider, double width) {
  return Positioned(
    left: width * 0.40,
    top: 5,
    child: CircularCountDownTimer(
      controller: quizProvider.controller,
      width: 80,
      height: 80,
      initialDuration: 0,
      duration: quizProvider.time,
      isReverse: true,
      isReverseAnimation: true,
      fillColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
      ringColor: AppColors.blackColor,
    ),
  );
}
