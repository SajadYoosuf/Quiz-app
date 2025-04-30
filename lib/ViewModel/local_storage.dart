import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageProvider extends ChangeNotifier {
  List<QuizHistory> quizHistory = [];
  List<bool> storingAchievementState = List.generate(
      achievementMessages.length, (int index) => false,
      growable: false);
  List<String> getList = List.generate(
      achievementMessages.length, (int index) => 'false',
      growable: false);
  Future<void> storingDataToHive(QuizHistory quizHistory) async {
    Box<QuizHistory> quizBox = Hive.box<QuizHistory>(quizHistoryHiveKey);
    quizBox.add(quizHistory);
    notifyListeners();
  }

  storingBoolList(List<bool> boolList) async {
    final prefs = await SharedPreferences.getInstance();
    print(boolList.length);
    for (int i = 0; i < boolList.length; i++) {
      if (boolList[i]) {
        getList.add('true');
      } else {
        getList.add('false');
      }
    }
    prefs.setStringList('achive', getList);
  }

  Future<List<bool>> reciveBoolList() async {
    final prefs = await SharedPreferences.getInstance();
    getList = prefs.getStringList('achive') ?? getList;
    print('this is getList');
    print(getList);

    for (var i = 0; i < getList.length; i++) {
      if (getList[i] == 'false') {
        storingAchievementState[i] = false;
      } else {
        storingAchievementState[i] = true;
      }
    }
    print('this is actual list');
    print(storingAchievementState);

    return storingAchievementState;
  }

  List<QuizHistory> recieveDataFromHive() {
    print('object');
    Box<QuizHistory> quizBox = Hive.box<QuizHistory>(quizHistoryHiveKey);
    quizHistory = quizBox.values.toList(growable: true);
    notifyListeners();

    return quizHistory;
  }
}
