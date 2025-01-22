import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reward_popup/reward_popup.dart';
import '../Model/quiz_full_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/category_page.dart';
import '../View/score_display_page.dart';

class QuizPageFunctions extends ChangeNotifier {
  int time = 7000;
  int optionCheckeingIndex = 0;
  int currentIndex = 0;
  int checkingWhichIndexinsideAnswer = 0;
  List<int> markAddingForEachQuestionAnswer = [];
  int finalMark = 0;
  late Timer timer;

//for adding to shared preference to store local storage and display
  List<String> scoreHistory = [];
  List<String> categoryHistory = [];
  List<String> timeHistory = [];

  Future<void> storingDataToSharedPreference(
      List<String> score, List<String> takedTime, List<String> category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('scorekey', score);
    await prefs.setStringList('timeKey', takedTime);
    await prefs.setStringList('headingKey', category);
    print('fwofoiwjfnlfiwhf');
    notifyListeners();
  }

//each time user entering page then reinitilizing full variables
  void resetVariables(List<QuizFullData> fullData) {
    time = 7000;
    optionCheckeingIndex = 0;
    currentIndex = 0;
    checkingWhichIndexinsideAnswer = 0;
    markAddingForEachQuestionAnswer = [];
    finalMark = 0;
    fullData.shuffle();
    notifyListeners();
  }

  Future<void> recieveDataFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    scoreHistory = prefs.getStringList('scorekey') ?? [];
    timeHistory = prefs.getStringList('timeKey') ?? [];
    categoryHistory = prefs.getStringList('headingKey') ?? [];
    notifyListeners();
  }

  void displayCountDownTimer(context) {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      print(time);
      if (time == 0) {
        if (context.mounted) {
          timeOutPopup(context);
        }
        t.cancel();
      } else {
        time--;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void nextQuestionNavigation(String answer, List<QuizFullData> fullData,
      String heading, BuildContext context) {
    //checking for which option index placed answer
    if (answer == fullData[currentIndex].option1) {
      checkingWhichIndexinsideAnswer = 1;
    } else if (answer == fullData[currentIndex].option2) {
      checkingWhichIndexinsideAnswer = 2;
    } else if (answer == fullData[currentIndex].option3) {
      checkingWhichIndexinsideAnswer = 3;
    } else if (answer == fullData[currentIndex].option4) {
      checkingWhichIndexinsideAnswer = 4;
    }
    //after checking that index check with user selected and and assigning 10 mark
    if (checkingWhichIndexinsideAnswer == optionCheckeingIndex) {
      markAddingForEachQuestionAnswer.add(10);
    } else {
      markAddingForEachQuestionAnswer.add(0);
    }
    if (currentIndex == 9) {
      for (int marks in markAddingForEachQuestionAnswer) {
        //ignore: avoid print
        finalMark = finalMark + marks;
      }
      switch (finalMark) {
        case > 60:
          quizWinningPopup(context, finalMark, time, heading, fullData);
          break;
        case < 60:
          quizFailedPopup(context, finalMark, time, heading, fullData);
        default:
      }
      currentIndex--;
      optionCheckeingIndex = -1;
      notifyListeners();
    }
    currentIndex++;
    optionCheckeingIndex = -1;
    notifyListeners();
  }

  void previousQuestionNavigation() {
    if (currentIndex == 0) {
      currentIndex++;
    }
    currentIndex--;
    markAddingForEachQuestionAnswer.remove(currentIndex);
    optionCheckeingIndex = -1;
    notifyListeners();
  }

  void colorChanging(int index) {
    optionCheckeingIndex = index;
    notifyListeners();
  }

  Future<Null> quizWinningPopup(BuildContext context, int finalMark,
      int currentTime, String heading, List<QuizFullData> fullData) async {
    timer.cancel();
    showRewardPopup(
      context,
      enableDismissByTappingOutside: true,
      child: Center(
        child: Container(
          width: 250,
          height: 180,
          decoration: BoxDecoration(
              color: const Color(0xFF7559f3),
              borderRadius: BorderRadius.circular(22)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(
                  Icons.emoji_events,
                  color: Color.fromARGB(255, 245, 221, 3),
                  size: 40,
                ),
              ),
              const Center(
                child: Text(
                  "You finished the quiz",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Text(
                "Your mark: $finalMark",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        scoreHistory.add(finalMark.toString());
                        currentTime = 300 - currentTime;
                        timeHistory.add(currentTime.toString());
                        categoryHistory.add(heading);
                        storingDataToSharedPreference(
                            scoreHistory, timeHistory, categoryHistory);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScoreDisplayPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF896afd)),
                      child: const Center(
                          child: Text(
                        "                TAB\nSee Your Score Details",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              )
            ],
          ),
        ),
      ),
    ).then((_) => Future.delayed(const Duration(seconds: 1), () {
          scoreHistory.add(finalMark.toString());
          currentTime = 300 - currentTime;
          timeHistory.add(currentTime.toString());
          categoryHistory.add(heading);
          storingDataToSharedPreference(
              scoreHistory, timeHistory, categoryHistory);

          Navigator.pop(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()));
        }));
  }

  Future<Null> timeOutPopup(context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            icon: Center(
                child: Image.asset(
              'assets/images/time_out.png',
              color: const Color(0xFF8869fd),
            )),
            title: const Center(
              child: Text(
                "YOUR  SESSION TIME HAS OUT",
                style: TextStyle(
                    color: Color(0xFF8869fd),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                "TRY AGAIN",
                style: TextStyle(
                    color: Color(0xFF8869fd),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            actions: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF189afd)),
                      child: const Center(
                          child: Text(
                        "GO TO HOME PAGE",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => Future.delayed(const Duration(seconds: 1), () {
          timer.cancel();
          Navigator.pop(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()));
        }));
  }

  Future<Null> quizFailedPopup(BuildContext context, int finalMark,
      int timeRemaining, String quizHeading, List<QuizFullData> fullData) {
    timer.cancel();
    return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SizedBox(
            child: AlertDialog(
              icon: Center(
                  child: Image.asset(
                'assets/images/sad_image.png',
              )),
              title: const Center(
                child: Text(
                  "YOU FAILED IN THIS QUIZ",
                  style: TextStyle(
                      color: Color(0xFF8869fd),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text(
                  "YOUR FINALMARK:$finalMark",
                  style: const TextStyle(
                      color: Color(0xFF8869fd),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              actions: [
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          scoreHistory.add(finalMark.toString());
                          timeRemaining = 300 - timeRemaining;
                          timeHistory.add(timeRemaining.toString());
                          categoryHistory.add(quizHeading);
                          storingDataToSharedPreference(
                              scoreHistory, timeHistory, categoryHistory);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFfb8a3e)),
                        child: const Center(
                            child: Text(
                          "SEE THE SCOREPAGE",
                          style: TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
              ],
            ),
          );
        }).then((_) => Future.delayed(const Duration(seconds: 1), () {
          scoreHistory.add(finalMark.toString());
          timeRemaining = 300 - timeRemaining;
          timeHistory.add(timeRemaining.toString());
          categoryHistory.add(quizHeading);
          storingDataToSharedPreference(
              scoreHistory, timeHistory, categoryHistory);
          Navigator.pop(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => CategoryPage()));
        }));
  }
}
