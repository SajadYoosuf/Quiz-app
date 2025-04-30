import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/firebase_keys.dart';
import 'package:flutter/material.dart';

class LeaderBoardProvider extends ChangeNotifier {
  List<Map<String, dynamic>> top3List = [];
  List<Map<dynamic, dynamic>> leaderboard = [];
  int? currentUserLeaderBoardRank;
  Future<void> getLeaderBoardData(BuildContext context) async {
    var data = await FirebaseFirestoreData.getLeaderBoardData();
    String score = await FirebaseFirestoreData.getLeaderBoardScore();
    List<int> reseversedList = [];
    for (var i = 0; i < data.length; i++) {
      reseversedList.add(int.parse(data[i][leaderBoardScore]));
    }
    reseversedList.sort((b, a) => a.compareTo(b));
    for (var i = 0; i < data.length; i++) {
      for (var j = i; j < data.length; j++) {
        if (i <= 2) {
          if (data[i][leaderBoardScore] == reseversedList[j]) {
            if (int.parse(score) == reseversedList[j]) {
              currentUserLeaderBoardRank = j;
            }
            top3List.add(data[j]);
          }
        } else {
          if (int.parse(score) == reseversedList[i]) {
            currentUserLeaderBoardRank = j;
          }
          leaderboard.add(data[j]);
        }
      }
    }
    // print(top3List);
    // print(leaderboard);
    notifyListeners();
  }
}
