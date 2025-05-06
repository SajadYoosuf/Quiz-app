import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreenProvider extends ChangeNotifier {
  List<Map<String, dynamic>> top3List = [];
  List<Map<String, dynamic>> leaderboard = [];
  int? currentUserLeaderBoardRank;
  String score = '';
  List<File> image = [];
  List<String> networkImages = [];

  Future<void> getLeaderBoardData(BuildContext context) async {
    // Fetch leaderboard data and current user's score
    final data = await FirebaseFirestoreData.getLeaderBoardData();

    score = (await FirebaseFirestoreData.getLeaderBoardScore());
    if (data.isEmpty) return;
    for (int i = 0; i < data.length; i++) {
      for (int j = i + 1; j < data.length; j++) {
        if (int.parse(data[i][FirebaseKeys.userScore]) <
            int.parse(data[j][FirebaseKeys.userScore])) {
          var temp = data[i];
          data[i] = data[j];
          data[j] = temp;
        }
      }
    }

    // Find current user's rank
    if (int.parse(score) > 0) {
      for (int i = 0; i < data.length; i++) {
        if (int.parse(data[i][FirebaseKeys.userScore]) == int.parse(score)) {
          currentUserLeaderBoardRank = i;
          break;
        }
      }
    }
    top3List = data.take(3).toList();
    leaderboard = data.skip(3).toList();

    notifyListeners();
  }

  ImageProvider getImageProvider(String photoPath) {
    if (!photoPath.startsWith('http')) {
      return FileImage(File(photoPath));
    } else {
      final networkImage = photoPath.replaceAll('"', '');
      return CachedNetworkImageProvider(networkImage);
    }
  }
}
