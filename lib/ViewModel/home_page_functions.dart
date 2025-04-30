import 'dart:io';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider extends ChangeNotifier {
  String? userName;
  File? imagePath;
  String? score;
  bool isload = true;
  Future<Null> fetchUserData(BuildContext context) async {
    var imageD;

    String? result = await FirebaseFirestoreData.getUser();
    print('result is $result');
    // ignore: avoid_print
    if (result == 'successfully fetched userData') {
      print(FirebaseFirestoreData.userData);
      userName = FirebaseFirestoreData.userData[0];
      imageD = FirebaseFirestoreData.userData[1];
      print("the user name $userName the photo is $imageD");
      if (imageD.startsWith('http://') || imageD.startsWith('https://')) {
        profileImage = imageD;
      } else {
        imagePath = File(imageD);
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      userName = prefs.getString('user_name')!;
      imageD = prefs.getString('profile_photo')!;
      if (imageD.startsWith('http://') || imageD.startsWith('https://')) {
        profileImage = imageD;
      } else {
        imagePath = File(imageD);
      }
    }

    isload = false;
    notifyListeners();
  }
}
