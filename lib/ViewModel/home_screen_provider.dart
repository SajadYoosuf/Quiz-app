import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenProvider extends ChangeNotifier {
  //user Data
  String? currentUserName;
  File? profileImageFile;
  String? currentUserscore;
  String? profilImageNetwork;

  //check network for networkbased content
  bool checkNetwork = true;

  void checkInternet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      checkNetwork = false;
    } else {
      checkNetwork = true;
    }
    notifyListeners();
  }

  Future<void> fetchUserData(BuildContext context) async {
    try {
      Map<String, dynamic> result = await FirebaseFirestoreData.getUser();
      String score = await FirebaseFirestoreData.getLeaderBoardScore();
      if (result.isNotEmpty) {
        _processFirebaseUserData(result, score);
      } else {
        await _loadLocalUserData();
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $error')));
      await _loadLocalUserData();
    }
    notifyListeners();
  }

  void _processFirebaseUserData(Map<String, dynamic> result, String userScore) {
    String name = result[FirebaseKeys.userName];
    currentUserName = name.length > 14 ? name.substring(14, name.length) : name;
    currentUserscore = userScore;
    String imageSource = result[FirebaseKeys.userPhoto];
    if (imageSource.startsWith('http://') ||
        imageSource.startsWith('https://')) {
      profilImageNetwork = imageSource;
    } else {
      profileImageFile = File(imageSource);
    }
  }

  Future<void> _loadLocalUserData() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserName = prefs.getString(FirebaseKeys.userName);
    String? imagePath = prefs.getString(FirebaseKeys.userPhoto);
    if (imagePath != null) {
      if (await File(imagePath.startsWith('file://')
              ? imagePath.substring(7)
              : imagePath)
          .exists()) {
        profileImageFile = File(imagePath);
      }
    }
  }
}
