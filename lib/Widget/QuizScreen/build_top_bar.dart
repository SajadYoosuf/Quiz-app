import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_progress_indicator.dart';
import 'package:quiz_app/Widget/dialogs/dialog_services.dart';

Widget buildTopBar(QuizScreenProvider quizProvider, double width, double height,
    BuildContext context) {
  return Row(
    children: [
      IconButton(
        onPressed: () => DialogService.showQuitConfirmationDialog(
          context,
          quizProvider.timer,
        ),
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
          size: 35,
        ),
      ),
      buildProgressIndicator(quizProvider, width, height),
    ],
  );
}
