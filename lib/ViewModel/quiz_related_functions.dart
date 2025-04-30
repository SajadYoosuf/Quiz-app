import 'dart:async';
import 'package:quiz_app/Model/quiz_data.dart';
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/ViewModel/alert_dialog.dart';
import 'package:quiz_app/ViewModel/category.dart';
import 'package:quiz_app/ViewModel/local_storage.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/services/trivia_api.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

class QuizPageFunctions extends ChangeNotifier {
  double currentQuestionIndexByContainerPercentage = 22;
  int time = 30;
  final CountDownController _controller = CountDownController();

  CountDownController get controller => _controller;
  set countDownController(CountDownController controller) {
    controller = _controller;
  }

  final now = DateTime.now();

  String? url;
  List<int> userCurrentOptionChoosingTimings = [];
  int optionCheckeingIndex = 0;
  int currentIndex = 0;
  int checkingWhichIndexinsideAnswer = 0;
  List<int> markAddingForEachQuestion = [];
  String seconds = '';
  int finalMark = 0;
  late Timer timer;
  late QuizData quizData;
  int totalTime = 0;
  bool alradyAttempt = false;
  List<String> userChoosedOption = [];
  bool apiCalled = false;
  bool isChecked = false;
  bool quizIsActivated = false;
  NetworkStatus _networkStatus = NetworkStatus.loading;
  NetworkStatus get networkStatus => _networkStatus;
  List<String> options = [];
//for adding to shared preference to store local storage and display
  LocalStorageProvider localStorage = LocalStorageProvider();

  void refreshVariables() {
    for (var i = 0; i < containerColors.length; i++) {
      containerColors[i] = Colors.white;
      optionIcons[i] = Icons.radio_button_unchecked_outlined;
    }
    notifyListeners();
  }

  void checkingTheAnswer(int index) {
    if (!isChecked) {
      if (options[index] == quizData.results[currentIndex].correctAnswer) {
        markAddingForEachQuestion.add(1);
        userChoosedOption.add(quizData.results[currentIndex].correctAnswer);
        userCurrentOptionChoosingTimings.add(30 - time);
        containerColors[index] = Colors.blue;
        optionIcons[index] = Icons.check_circle;
      } else {
        for (var i = 0;
            i <= quizData.results[currentIndex].incorrectAnswers.length;
            i++) {
          if (options[i] == quizData.results[currentIndex].correctAnswer) {
            print('this is currect answer but you not selected');
            print(options[i]);
            print('this is currect answerfrom api but you not selected');

            print(quizData.results[currentIndex].correctAnswer);
            containerColors[i] = Colors.blue;
            optionIcons[i] = Icons.check_circle;
            break;
          }
        }
      }
      if (options[index] != quizData.results[currentIndex].correctAnswer) {
        markAddingForEachQuestion.add(0);
        userChoosedOption.add(options[index]);
        userCurrentOptionChoosingTimings.add(30 - time);
        containerColors[index] = Colors.red;
        optionIcons[index] = Icons.cancel;
      }
      isChecked = true;
    }
    notifyListeners();
  }

  void optionListMaking(QuizData quizData) {
    print('function is calling');
    options.clear();
    for (int i = 0;
        i <= quizData.results[currentIndex].incorrectAnswers.length;
        i++) {
      if (i == quizData.results[currentIndex].incorrectAnswers.length) {
        options.add(quizData.results[currentIndex].correctAnswer);
        alradyAttempt = true;
        containerColors.add(Colors.white);
        optionIcons.add(
          Icons.radio_button_unchecked_outlined,
        );
      } else {
        containerColors.add(Colors.white);
        optionIcons.add(
          Icons.radio_button_unchecked_outlined,
        );
        options.add(quizData.results[currentIndex].incorrectAnswers[i]);
      }
      notifyListeners();
    }
    print(containerColors);
    options.shuffle();
  }

  Future<QuizData> fetchQuizData(String url, BuildContext context) async {
    this.url = url;
    _networkStatus = NetworkStatus.loading;
    try {
      quizData = await TriviaApi().getQuizData(url);
    } catch (e) {
      _networkStatus = NetworkStatus.error;
    }
    // ignore: unnecessary_null_comparison
    if (quizData == null) {
      _networkStatus = NetworkStatus.error;
    } else {
      _networkStatus = NetworkStatus.loaded;
      quizData.results.shuffle();
      apiCalled = true;
      displayCountDownTimer(context);
      optionListMaking(quizData);
    }
    notifyListeners();
    return quizData;
  }

//each time user entering page then reinitilizing full variables
  void resetVariables() {
    print('called');
    time = 30;
    currentIndex = 0;
    markAddingForEachQuestion.clear();
    finalMark = 0;
    apiCalled = false;
    userCurrentOptionChoosingTimings.clear();
    currentQuestionIndexByContainerPercentage = 22;
    userChoosedOption.clear();
    isChecked = false;
    refreshVariables();
    notifyListeners();
  }

  void displayCountDownTimer(context) {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time == 0) {
        nextButton(context, 0);

        t.cancel();
      } else {
        print(time);
        time -= 1;
      }
    });
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  void nextButton(BuildContext context, int index) async {
    // ignore: unnecessary_null_comparison
    if (currentIndex == 9) {
      timer.cancel();
      controller.pause();
      for (var element in markAddingForEachQuestion) {
        finalMark += element;
      }
      for (var element in userCurrentOptionChoosingTimings) {
        totalTime += element;
      }
      var quizHistory = QuizHistory(
          cateogryHistory: CategoryDetails
              .categoryDetails[indexForCategoryFind!].quizCategoryName,
          timeHistory: totalTime,
          scoreHistory: finalMark,
          date: now.day.toString());
      localStorage.storingDataToHive(quizHistory);
      if (finalMark >= 1) {
        String score = await FirebaseFirestoreData.getLeaderBoardScore();
        if (score.contains(RegExp(r'\d'))) {
          print(
              'your  recent score is $score  and current score is $finalMark');
          score = (int.parse(score) + finalMark).toString();
          FirebaseFirestoreData.addUserLeaderboardInfo(score: score);
        } else {
          print(score ?? 'nothing on score');
          FirebaseFirestoreData.addUserLeaderboardInfo(
              score: finalMark.toString());
        }

        // ignore: void_checks
        return AlertDialogs.alertDialogForQuizWinningAndFailedAndQuit(
          context,
          finalMark,
          quizData,
          userChoosedOption,
          userCurrentOptionChoosingTimings,
          markAddingForEachQuestion,
          'win',
        );
      } else {
        // ignore: void_checks
        return AlertDialogs.alertDialogForQuizWinningAndFailedAndQuit(
          context,
          finalMark,
          quizData,
          userChoosedOption,
          userCurrentOptionChoosingTimings,
          markAddingForEachQuestion,
          'faled',
        );
      }
    } else {
      timer.cancel();
      controller.pause();
      if (userChoosedOption.length - 1 < currentIndex) {
        markAddingForEachQuestion.add(0);
        userCurrentOptionChoosingTimings.add(0);
        userChoosedOption.add('Error');
      }
      refreshVariables();
      controller.restart();
      currentQuestionIndexByContainerPercentage += 22;
      currentIndex++;
      time = 30;
      optionListMaking(quizData);
      displayCountDownTimer(context);
      isChecked = false;
    }

    notifyListeners();
  }

  checkAchievementForMaking(BuildContext context) {
    int attemptForADay = 0;
    LocalStorageProvider localStorage = LocalStorageProvider();
    localStorage.reciveBoolList();
    print(localStorage.storingAchievementState);
    List<QuizHistory> quizHistory = localStorage.recieveDataFromHive();
    if (!localStorage.storingAchievementState[0]) {
      if (localStorage.quizHistory.length == 1) {
        return _unlockAchievement(0, context);
      }
    } else if (!localStorage.storingAchievementState[1]) {
      if (quizHistory.length == 5) {
        return _unlockAchievement(1, context);
      }
    } else if (!localStorage.storingAchievementState[2]) {
      if (quizHistory.length == 10) {
        return _unlockAchievement(2, context);
      }
    } else if (!localStorage.storingAchievementState[3]) {
      if (quizHistory.length == 10) {
        return _unlockAchievement(3, context);
      }
    } else if (!localStorage.storingAchievementState[4]) {
      if (quizHistory.length == 50) {
        return _unlockAchievement(4, context);
      }
    } else if (!localStorage.storingAchievementState[5]) {
      if (quizHistory.length == 100) {
        return _unlockAchievement(5, context);
      }
    } else if (!localStorage.storingAchievementState[6]) {
      if (quizHistory.length == 200) {
        return _unlockAchievement(6, context);
      }
    } else if (!localStorage.storingAchievementState[7]) {
      for (var i = 0; i < quizHistory.length;) {
        if (quizHistory[i].date != now.day.toString()) {
          attemptForADay = 0;
        } else {
          attemptForADay++;
        }
        if (attemptForADay == 10) {
          return _unlockAchievement(7, context);
        }
        break;
      }
    } else if (!localStorage.storingAchievementState[8]) {
      for (var i = 0; i < quizHistory.length; i++) {
        if (quizHistory[i].timeHistory! <= 30) {
          return _unlockAchievement(8, context);
        }
      }
    } else if (!localStorage.storingAchievementState[9]) {
      for (var i = 0; i < quizHistory.length; i++) {
        if (quizHistory[i].scoreHistory! == 10) {
          return _unlockAchievement(9, context);
        }
      }
    } else if (!localStorage.storingAchievementState[10]) {
      for (var i = 0; i < quizHistory.length; i++) {
        if (quizHistory[i].scoreHistory! == 9) {
          return _unlockAchievement(10, context);
        }
      }
    } else if (!localStorage.storingAchievementState[11]) {
      for (var i = 0; i < quizHistory.length; i++) {
        if (quizHistory[i].cateogryHistory !=
            quizHistory[i + 1].cateogryHistory) {
          attemptForADay++;
          if (attemptForADay == CategoryDetails.categoryDetails.length) {
            return _unlockAchievement(11, context);
          }
        }
      }
    } else if (!localStorage.storingAchievementState[12]) {
      for (var i = 0; i < quizHistory.length; i++) {
        attemptForADay += quizHistory[i].scoreHistory!;
        if (attemptForADay >= 5) {
          return _unlockAchievement(12, context);
        }
      }
    } else if (!localStorage.storingAchievementState[13]) {
      return _unlockAchievement(13, context);
    } else if (!localStorage.storingAchievementState[14]) {
      for (var i = 0; i < quizHistory.length; i++) {
        if (quizHistory[i].scoreHistory! == 1000) {
          return _unlockAchievement(14, context);
        }
      }
    }
  }

  Future<void> _unlockAchievement(int index, BuildContext context) async {
    LocalStorageProvider localStorage = LocalStorageProvider();

    localStorage.reciveBoolList();
    print(localStorage.storingAchievementState);
    AlertDialogs alertDialogs = AlertDialogs();
    localStorage.storingAchievementState[index] = true;
    await localStorage.storingBoolList(localStorage.storingAchievementState);
    quizIsActivated = false;
    // ignore: use_build_context_synchronously
    return alertDialogs.alertDialogMaking(context, achievementMessages[index]!);
  }
}
