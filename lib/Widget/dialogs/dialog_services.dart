import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/quiz_data_model.dart';
import 'package:quiz_app/Widget/dialogs/build_achievement_card.dart';
import 'package:quiz_app/Widget/dialogs/quit_confirmation_dialog.dart';
import 'package:quiz_app/Widget/dialogs/quiz_result_dialog.dart';

class DialogService {
  static void showAchievementDialog(
      BuildContext context, List<String> achievement) {
    AchievementDialog.show(context, achievement);
  }

  static void showQuitConfirmationDialog(BuildContext context, Timer timer) {
    QuitConfirmationDialog.show(context, timer);
  }

  static void showQuizResultDialog(
    BuildContext context,
    int finalMark,
    QuizData quizData,
    List<String> userChoosedOption,
    List<int> userTimings,
    List<int> userScores,
    String type,
  ) {
    if (type == 'win') {
      QuizResultDialog.showWinDialog(context, finalMark, quizData,
          userChoosedOption, userTimings, userScores);
    } else if (type == 'failed') {
      QuizResultDialog.showFailedDialog(context, finalMark, quizData,
          userChoosedOption, userTimings, userScores);
    }
  }
}
