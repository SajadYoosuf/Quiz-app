import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_error_message.dart';
import 'package:quiz_app/Widget/QuizScreen/build_loading_indicator.dart';
import 'package:quiz_app/Widget/dialogs/build_quiz_screen_content.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildContentBasedOnNetworkStatus(QuizScreenProvider quizProvider,
    double width, double height, BuildContext context) {
  switch (quizProvider.networkStatus) {
    case NetworkStatus.loaded:
      return buildQuizContent(quizProvider, width, height, context);
    case NetworkStatus.loading:
      return buildLoadingIndicator();
    case NetworkStatus.error:
      return buildErrorMessage(height, context);
  }
}
