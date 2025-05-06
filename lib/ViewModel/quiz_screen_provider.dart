import 'dart:async';
import 'package:quiz_app/Model/quiz_category_model.dart';
import 'package:quiz_app/Model/quiz_data_model.dart';
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/Widget/dialogs/dialog_services.dart';
import 'package:quiz_app/services/local_storage_service.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/services/api_services.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class QuizScreenProvider extends ChangeNotifier {
  //controller for countdowncircular
  final CountDownController _controller = CountDownController();
  CountDownController get controller => _controller;

//timer related
  int time = 30;
  late Timer timer;
  int totalTime = 0;

  // Quiz progress tracking
  double currentQuestionIndexByContainerPercentage = 22;
  int currentIndex = 0;
  int finalMark = 0;
  bool apiCalled = false;

// Question handling
  String? url;
  late QuizData quizData;
  List<String> options = [];
  bool alreadyAttempt = false;
  bool isChecked = false;

  // User response tracking
  List<int> responseTimings = [];
  List<String> userChosenOptions = [];
  List<int> marksPerQuestion = [];

  // Achievements tracking
  bool quizIsActivated = false;

  // Network state
  NetworkStatus _networkStatus = NetworkStatus.loading;
  NetworkStatus get networkStatus => _networkStatus;
  // Local storage
  LocalStorageService localStorage = LocalStorageService();
  final DateTime now = DateTime.now();

  Future<void> fetchQuizData(String url, BuildContext context) async {
    this.url = url;
    _networkStatus = NetworkStatus.loading;
    notifyListeners();

    try {
      quizData = await TriviaApi().getQuizData(url);
      _networkStatus = NetworkStatus.loaded;
      quizData.results.shuffle();
      apiCalled = true;
      // Initialize quiz UI
      // ignore: use_build_context_synchronously
      startCountdownTimer(context);
      prepareQuestionOptions();
    } catch (e) {
      _networkStatus = NetworkStatus.error;
    }

    notifyListeners();
  }

  // Prepare the options for current question
  void prepareQuestionOptions() {
    options.clear();

    // Add incorrect answers
    _addIncorrectAnswers();

    // Add correct answer
    _addCorrectAnswer();

    // Shuffle options to randomize positions
    options.shuffle();
    notifyListeners();
  }

  void _addIncorrectAnswers() {
    for (int i = 0;
        i < quizData.results[currentIndex].incorrectAnswers.length;
        i++) {
      options.add(quizData.results[currentIndex].incorrectAnswers[i]);
      AppColors.containerColors.add(Colors.white);
      AppIcons.optionIcons.add(Icons.radio_button_unchecked_outlined);
    }
  }

  // Add correct answer to options
  void _addCorrectAnswer() {
    options.add(quizData.results[currentIndex].correctAnswer);
    AppColors.containerColors.add(Colors.white);
    AppIcons.optionIcons.add(Icons.radio_button_unchecked_outlined);
    alreadyAttempt = true;
  }

  void startCountdownTimer(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time == 0) {
        goToNextQuestion(context);
        t.cancel();
      } else {
        time -= 1;
        notifyListeners();
      }
    });
  }

  // Reset visual state of options
  void resetOptionVisuals() {
    for (var i = 0; i < AppColors.containerColors.length; i++) {
      AppColors.containerColors[i] = Colors.white;
      AppIcons.optionIcons[i] = Icons.radio_button_unchecked_outlined;
    }
    notifyListeners();
  }

  // Handle option selection
  void checkAnswer(int index) {
    if (isChecked) return;

    final bool isCorrect =
        options[index] == quizData.results[currentIndex].correctAnswer;

    if (isCorrect) {
      _handleCorrectAnswer(index);
    } else {
      _handleIncorrectAnswer(index);
    }

    isChecked = true;
    notifyListeners();
  }

  // Handle correct answer selection
  void _handleCorrectAnswer(int index) {
    marksPerQuestion.add(1);
    userChosenOptions.add(quizData.results[currentIndex].correctAnswer);
    responseTimings.add(30 - time);

    // Update UI
    AppColors.containerColors[index] = Colors.blue;
    AppIcons.optionIcons[index] = Icons.check_circle;
  }

  // Handle incorrect answer selection
  void _handleIncorrectAnswer(int index) {
    marksPerQuestion.add(0);
    userChosenOptions.add(options[index]);
    responseTimings.add(30 - time);

    // Update UI - mark selected option as wrong
    AppColors.containerColors[index] = Colors.red;
    AppIcons.optionIcons[index] = Icons.cancel;

    // Show the correct answer
    _highlightCorrectAnswer();
  }

  // Highlight the correct answer
  void _highlightCorrectAnswer() {
    for (var i = 0; i < options.length; i++) {
      if (options[i] == quizData.results[currentIndex].correctAnswer) {
        AppColors.containerColors[i] = Colors.blue;
        AppIcons.optionIcons[i] = Icons.check_circle;
        break;
      }
    }
  }

  // Move to next question or finish quiz
  void goToNextQuestion(BuildContext context) async {
    // Check if quiz is complete
    if (currentIndex == 9) {
      await _finishQuiz(context);
      return;
    }

    // Handle transition to next question
    timer.cancel();

    // If user didn't answer, record as skipped
    if (userChosenOptions.length - 1 < currentIndex) {
      marksPerQuestion.add(0);
      responseTimings.add(0);
      userChosenOptions.add('Skipped');
    }

    // Reset for next question
    resetOptionVisuals();
    controller.restart();
    currentQuestionIndexByContainerPercentage += 22;
    currentIndex++;
    time = 30;
    prepareQuestionOptions();
    startCountdownTimer(context);
    isChecked = false;

    notifyListeners();
  }

  // Handle quiz completion
  Future<void> _finishQuiz(BuildContext context) async {
    // Stop timer and calculate results
    timer.cancel();
    controller.reset();

    // Calculate final score
    _calculateFinalScore();

    // Save quiz history
    _saveQuizHistory();

    // Update leaderboard if score > 0
    if (finalMark >= 1) {
      await _updateLeaderboard();

      // Show results dialog - win
      return DialogService.showQuizResultDialog(context, finalMark, quizData,
          userChosenOptions, responseTimings, marksPerQuestion, 'win');
    } else {
      return DialogService.showQuizResultDialog(context, finalMark, quizData,
          userChosenOptions, responseTimings, marksPerQuestion, 'failed');
      // Show results dialog - failed
    }
  }

  // Calculate final score and total time
  void _calculateFinalScore() {
    finalMark = 0;
    totalTime = 0;

    for (var mark in marksPerQuestion) {
      finalMark += mark;
    }

    for (var time in responseTimings) {
      totalTime += time;
    }
  }

  // Save quiz history to local storage
  void _saveQuizHistory() {
    final quizHistory = QuizHistory(
      cateogryHistory: CategoryDetails
          .categoryDetails[indexForCategoryFind!].quizCategoryName,
      timeHistory: totalTime,
      scoreHistory: finalMark,
      date: now.day.toString(),
    );

    localStorage.storingDataToHive(quizHistory);
  }

  // Update user's leaderboard score
  Future<void> _updateLeaderboard() async {
    String score = await FirebaseFirestoreData.getLeaderBoardScore();
    finalMark = finalMark > 10 ? 10 : finalMark;
    score = !score.contains('0') ? '0' : score;
    score = (int.parse(score) + finalMark).toString();

    await FirebaseFirestoreData.updateLeaderboardScore(score: score);
  }

  // Reset all quiz variables for a new quiz
  void resetVariables() {
    time = 30;
    currentIndex = 0;
    marksPerQuestion.clear();
    finalMark = 0;
    apiCalled = false;
    responseTimings.clear();
    currentQuestionIndexByContainerPercentage = 22;
    userChosenOptions.clear();
    controller.restart();
    isChecked = false;
    resetOptionVisuals();
    notifyListeners();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    controller.reset();
    super.dispose();
  }
}
