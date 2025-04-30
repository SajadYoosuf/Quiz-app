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

  Future<void> storingDataToHive(QuizHistory quizHistory) async {
    Box<QuizHistory> quizBox = Hive.box<QuizHistory>(quizHistoryHiveKey);
    quizBox.add(quizHistory);
  }

  storingBoolList(List<bool> boolList) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> tempList = boolList.map((e) => e ? 'true' : 'false').toList();

    print('Storing list:');
    print(tempList);

    await prefs.setStringList('achive', tempList); // Store fresh list
  }

  Future<List<bool>> reciveBoolList() async {
    final prefs = await SharedPreferences.getInstance();

    // Load fresh list
    List<String> loadedList =
        prefs.getStringList('achive') ?? List.generate(15, (_) => 'false');

    // Map to bool list
    storingAchievementState = loadedList.map((e) => e == 'true').toList();

    print('Loaded bool list: $storingAchievementState');

    return storingAchievementState;
  }

  List<QuizHistory> recieveDataFromHive() {
    print('object');
    Box<QuizHistory> quizBox = Hive.box<QuizHistory>(quizHistoryHiveKey);
    quizHistory = quizBox.values.toList(growable: true);

    return quizHistory;
  }
}
