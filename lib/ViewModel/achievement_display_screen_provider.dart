import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Model/quiz_category_model.dart';
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/services/local_storage_service.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/dialogs/dialog_services.dart';
import 'package:quiz_app/utilities/achievement_messages.dart';

class AchievementDisplayScreenProvider extends ChangeNotifier {
  final LocalStorageService localStorage = LocalStorageService();
  DateTime now = DateTime.now();

  checkAchievementForMaking(BuildContext context) {
    List<QuizHistory> quizHistory = localStorage.recieveDataFromHive();
    localStorage.reciveBoolList();
    // First quiz achievement
    if (!localStorage.storingAchievementState[0] && quizHistory.length == 1) {
      _unlockAchievement(0, context);
      return;
    }
    // 5 quizzes achievement
    if (!localStorage.storingAchievementState[1] && quizHistory.length == 5) {
      _unlockAchievement(1, context);
      return;
    }
    // 10 quizzes achievement
    if (!localStorage.storingAchievementState[2] && quizHistory.length == 10) {
      _unlockAchievement(2, context);
      return;
    }
    // 25 quizzes achievement
    if (!localStorage.storingAchievementState[3] && quizHistory.length == 25) {
      _unlockAchievement(3, context);
      return;
    }
    // 50 quizzes achievement
    if (!localStorage.storingAchievementState[4] && quizHistory.length == 50) {
      _unlockAchievement(4, context);
      return;
    }
    // 100 quizzes achievement
    if (!localStorage.storingAchievementState[5] && quizHistory.length == 100) {
      _unlockAchievement(5, context);
      return;
    }
    // 200 quizzes achievement
    if (!localStorage.storingAchievementState[6] && quizHistory.length == 200) {
      _unlockAchievement(6, context);
      return;
    }

    // Additional achievements (add more based on your app requirements)
    _checkScoreAchievements(context, quizHistory);
    _checkDailyQuizAchievements(context, quizHistory);
    _checkCategoryAchievements(context, quizHistory);
  }

  // Check score-based achievements
  void _checkScoreAchievements(
      BuildContext context, List<QuizHistory> quizHistory) {
    // Perfect score (10/10)
    if (!localStorage.storingAchievementState[9]) {
      for (var quiz in quizHistory) {
        if (quiz.scoreHistory == 10) {
          _unlockAchievement(9, context);
          return;
        }
      }
    }
    // Almost perfect score (9/10)
    if (!localStorage.storingAchievementState[10]) {
      for (var quiz in quizHistory) {
        if (quiz.scoreHistory == 9) {
          _unlockAchievement(10, context);
          return;
        }
      }
    }
  }

  // Check daily quiz achievements
  void _checkDailyQuizAchievements(
      BuildContext context, List<QuizHistory> quizHistory) {
    if (!localStorage.storingAchievementState[7]) {
      int todayAttempts = 0;

      for (var quiz in quizHistory) {
        if (quiz.date == now.day.toString()) {
          todayAttempts++;
        }
      }

      if (todayAttempts >= 10) {
        _unlockAchievement(7, context);
        return;
      }
    }
  }

  // Check category-based achievements
  void _checkCategoryAchievements(
      BuildContext context, List<QuizHistory> quizHistory) {
    if (!localStorage.storingAchievementState[11]) {
      Set<String> completedCategories = {};

      for (var quiz in quizHistory) {
        completedCategories.add(quiz.cateogryHistory!);
      }

      if (completedCategories.length >=
          CategoryDetails.categoryDetails.length) {
        _unlockAchievement(11, context);
        return;
      }
    }
  }

  Future<void> _unlockAchievement(int index, BuildContext context) async {
    LocalStorageService localStorage = LocalStorageService();
    localStorage.reciveBoolList();
    localStorage.storingAchievementState[index] = true;
    await localStorage.storingBoolList(localStorage.storingAchievementState);
    // ignore: use_build_context_synchronously
    context.read<QuizScreenProvider>().quizIsActivated = false;
    // ignore: use_build_context_synchronously
    return DialogService.showAchievementDialog(
        // ignore: use_build_context_synchronously
        context,
        achievementMessages[index]!);
  }
}
