import 'package:flutter/material.dart';

class QuizRewiewProvider extends ChangeNotifier {
  int totalScore = 0;
  int totalTime = 0;
  String totalTimeSpent = '';
  secondsToHourMinutesSeconds(int seconds) {
    int minutes = ((seconds % 3600) / 60).toInt();
    int second = ((seconds % 3600) % 60).toInt();
    if (seconds <= 59) {
      totalTimeSpent = '${second}s';
    } else {
      totalTimeSpent = '${minutes}m ${second}s';
    }
    notifyListeners();
  }

  calculateTheScoreAndTime(List<int> takedScores, List<int> takedTimes) {
    for (var i = 0; i < takedScores.length; i++) {
      totalScore += takedScores[i];
      totalTime += takedTimes[i];
    }
    secondsToHourMinutesSeconds(totalTime);
  }
}
