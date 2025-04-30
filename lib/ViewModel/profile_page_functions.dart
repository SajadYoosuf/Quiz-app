import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:io' show File, Platform;
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/View/login_screen.dart';
import 'package:quiz_app/ViewModel/local_storage.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/firebase_keys.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageFunctions extends ChangeNotifier {
  File? imagePath;
  double percentage = 0;
  int totalPoints = 0;
  int attemptCountOnToday = 0;
  int totalAttempt = 0;
  int highestScore = 0;
  String totalTimeSpent = '';
  int lessTime = 0;
  bool tappedForNameChange = false;
  TextEditingController userNameController = TextEditingController();
  String? currentUserName;
  bool isLoad = true;
  var connectivityResult = (Connectivity().checkConnectivity());

  final picker = ImagePicker();
  void chagne() {
    userNameController.text = '';
    tappedForNameChange = true;
    notifyListeners();
  }

  void refreshVaribles() {
    print('called success');
    percentage = 0;
    totalPoints = 0;
    attemptCountOnToday = 0;
    totalAttempt = 0;
    highestScore = 0;
    totalTimeSpent = '';
    lessTime = 0;
    notifyListeners();
  }

  Future getImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('please turn on your network')));
      } else {
        imagePath = File(pickedFile.path);
        print(pickedFile.path);
        String result = await FirebaseFirestoreData.updateUserData(
            userPhoto, imagePath.toString());
        print(result);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('profile_photo', imagePath.toString());
      }
    }
    notifyListeners();
  }

//Image Picker function to get image from camera
  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('please turn on your network')));
      } else {
        imagePath = File(pickedFile.path);
        String result = await FirebaseFirestoreData.updateUserData(
            userPhoto, imagePath.toString());
        print(result);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('profile_photo', imagePath.toString());
      }
    }
    notifyListeners();
  }

  Future showOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera(context);
            },
          ),
        ],
      ),
    );
    notifyListeners();
  }

  updateData(String text, BuildContext context) async {
    // ignore: unnecessary_null_comparison
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('please enter your name')));
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('please turn on your network')));
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_name', text);
        currentUserName = text;
        String result =
            await FirebaseFirestoreData.updateUserData(userName, text);
        print(result);
        tappedForNameChange = false;
      }
    }
    notifyListeners();
  }

  secondsToHourMinutesSeconds(int seconds) {
    int hour = (seconds / 3600).toInt();
    int minutes = ((seconds % 3600) / 60).toInt();
    int second = ((seconds % 3600) % 60).toInt();
    totalTimeSpent = '${hour}h ${minutes}m ${second}s';
    notifyListeners();
  }

  Future<Null> fetchUserData(BuildContext context) async {
    var imageD;

    String? result = await FirebaseFirestoreData.getUser();
    print('result is $result');
    // ignore: avoid_print
    if (result == 'successfully fetched userData') {
      print(FirebaseFirestoreData.userData);
      userName = FirebaseFirestoreData.userData[1];
      imageD = FirebaseFirestoreData.userData[3];
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

    isLoad = false;
    notifyListeners();
  }

  String? validityChecking(String value) {
    if (value.isEmpty) {
      return 'please enter a name';
    }
    notifyListeners();
    return null;
  }

  void profilePageProgressMaking() {
    int seconds = 0;
    LocalStorageProvider localStorage = LocalStorageProvider();
    List<QuizHistory> quizHistory = localStorage.recieveDataFromHive();
    if (quizHistory.isNotEmpty) {
      lessTime = quizHistory[0].timeHistory!;
      for (var i = 0; i < quizHistory.length; i++) {
        final now = DateTime.now();
        if (highestScore < quizHistory[i].scoreHistory!) {
          highestScore = quizHistory[i].scoreHistory!;
        }
        if (lessTime > quizHistory[i].timeHistory!) {
          lessTime = quizHistory[i].timeHistory!;
        }
        if (quizHistory[i].date == now.day.toString()) {
          attemptCountOnToday++;
        }

        seconds += quizHistory[i].timeHistory!;
        // totalTimeSpent +=
        totalPoints += quizHistory[i].scoreHistory!;
      }
      secondsToHourMinutesSeconds(seconds);
      totalAttempt = quizHistory.length;
      percentage = totalPoints / quizHistory.length.toInt();
    }
    notifyListeners();
  }

  Future<void> signOut({required BuildContext context}) async {
    await FirebaseAuthentication.signOut().then((onValue) async {
      if (onValue != 'Succesfully sign out') {
        print('the result of sign out is $onValue');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          onValue,
          style: TextStyle(color: Colors.white),
        )));
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', false);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
          'Succesfully sign out',
          style: TextStyle(color: Colors.white),
        )));
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
}
