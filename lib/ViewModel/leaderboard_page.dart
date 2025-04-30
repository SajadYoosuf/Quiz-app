import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/firebase_keys.dart';
import 'package:flutter/material.dart';

class LeaderBoardProvider extends ChangeNotifier {
  List<Map<String, dynamic>> top3List = [];
  List<Map<dynamic, dynamic>> leaderboard = [];
  int? currentUserLeaderBoardRank;
  String score = '';
  Future<void> getLeaderBoardData(BuildContext context) async {
    print('somethign calling');
    var data = await FirebaseFirestoreData.getLeaderBoardData();
    score = await FirebaseFirestoreData.getLeaderBoardScore();
    print(data);
    print(score);
    List<int> reseversedList = [];
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        reseversedList.add(int.parse(data[i][leaderBoardScore]));
      }
      reseversedList.sort((b, a) => a.compareTo(b));
      for (var i = 0; i < data.length; i++) {
        print('called during loop');

        for (var j = i; j < data.length; j++) {
          if (i <= 2) {
            if (data[i][leaderBoardScore] == reseversedList[j]) {
              if (int.parse(score) == reseversedList[j]) {
                print('called during score');
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
    }

    print(top3List);
    print(leaderboard);
    notifyListeners();
  }
}
