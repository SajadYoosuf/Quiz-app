import 'dart:io';
import 'dart:io' show File;
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/services/local_storage_service.dart';
import 'package:quiz_app/services/firebase_auth.dart';
import 'package:quiz_app/services/firebase_firestore.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenProvider extends ChangeNotifier {
  //user profile Data
  File? profileImageFile;
  String? profileNetworkImage;
  String? currentUserName;
  bool isEdittingName = false;

  TextEditingController nameController = TextEditingController();
  // bool isLoading = true;

  //user current statistics
  double averageScore = 0;
  int totalPoints = 0,
      attemptCountOnToday = 0,
      totalAttempt = 0,
      highestScore = 0,
      fastestCompletionTime = 0;
  String totalTimeSpent = '';

  final ImagePicker _imagePicker = ImagePicker();
  var connectivityResult = Connectivity().checkConnectivity();

  void startNameEditting() {
    nameController.text = '';
    isEdittingName = true;
    notifyListeners();
  }

// reset when screen push or pop time
  void resetStatistics() {
    averageScore = 0;
    totalPoints = attemptCountOnToday =
        totalAttempt = highestScore = fastestCompletionTime = 0;
    totalTimeSpent = '';
    notifyListeners();
  }

  Future getImageFromGallery(BuildContext context) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      profileImageFile = File(pickedFile.path);
      await _updateProfileImage(context, pickedFile.path);
    }
    notifyListeners();
  }

//Image Picker function to get image from camera
  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      profileImageFile = File(pickedFile.path);
      await _updateProfileImage(context, pickedFile.path);

      profileImageFile = File(pickedFile.path);
      String result = await FirebaseFirestoreData.updateUserData(
          FirebaseKeys.userPhoto, profileImageFile.toString());
      print(result);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(FirebaseKeys.userPhoto, profileImageFile.toString());
    }
    notifyListeners();
  }

  /// Update the profile image in Firebase and SharedPreferences
  Future<void> _updateProfileImage(
      BuildContext context, String fileImage) async {
    if (!await _isNetworkAvailable(context)) return;

    String result = await FirebaseFirestoreData.updateUserData(
        FirebaseKeys.userPhoto, fileImage);

    if (result == 'Success') {
      // Save to local storage as well
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(FirebaseKeys.userPhoto, fileImage);
      notifyListeners();
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile image: $result')));
    }
  }

  /// Update the user's name
  Future<void> updateUserName(String newName, BuildContext context) async {
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your name')));
      return;
    }

    // First check if we're connected to the internet
    if (!await _isNetworkAvailable(context)) {
      // Just save locally if offline
      _saveUserNameLocally(newName);
      return;
    }

    // Update on Firebase
    String result = await FirebaseFirestoreData.updateUserData(
        FirebaseKeys.userName, newName);

    if (result == 'Success') {
      _saveUserNameLocally(newName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update name: $result')));
    }
  }

  /// Save user name to SharedPreferences and update state
  Future<void> _saveUserNameLocally(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
    currentUserName = name;
    isEdittingName = false;
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

  formatToTotalTime(int seconds) {
    int hour = (seconds / 3600).toInt();
    int minutes = ((seconds % 3600) / 60).toInt();
    int second = ((seconds % 3600) % 60).toInt();
    totalTimeSpent = '${hour}h ${minutes}m ${second}s';
    notifyListeners();
  }

  /// Fetch user data from Firebase or local storage
  Future<void> fetchUserData(BuildContext context) async {
    try {
      Map<String, dynamic> result = await FirebaseFirestoreData.getUser();

      if (result.isNotEmpty) {
        // Data from Firebase
        _processFirebaseUserData(result);
      } else {
        // Data from SharedPreferences
        await _loadLocalUserData();
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $error')));
      await _loadLocalUserData();
    }

    notifyListeners();
  }

  String? validityChecking(String value) {
    if (value.isEmpty) {
      return 'please enter a name';
    }
    if (value.length > 12) {
      return 'Name should be 12 characters or less';
    }
    return null;
  }

  /// Process user data from Firebase
  void _processFirebaseUserData(Map<String, dynamic> userData) {
    String name = userData[FirebaseKeys.userName];
    currentUserName =
        name.length <= 14 ? name : name.substring(14, name.length);

    var imageSource = userData[FirebaseKeys.userPhoto];
    if (imageSource.startsWith('http://') ||
        imageSource.startsWith('https://')) {
      profileNetworkImage = imageSource;
      profileImageFile = null;
    } else {
      profileImageFile = File(imageSource);
      profileNetworkImage = null;
    }
  }

  /// Load user data from SharedPreferences
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

  void calculateProfileStatistics() {
    // int seconds = 0;
    LocalStorageService localStorage = LocalStorageService();
    List<QuizHistory> quizHistory = localStorage.recieveDataFromHive();
    if (quizHistory.isEmpty) {
      return;
    }
    // Initialize with first quiz values
    fastestCompletionTime = quizHistory[0].timeHistory ?? 0;
    highestScore = quizHistory[0].scoreHistory ?? 0;

    final today = DateTime.now().day.toString();

    // Reset counters
    totalAttempt = 0;
    totalPoints = 0;
    int totalSeconds = 0;

    for (var quiz in quizHistory) {
      if ((quiz.scoreHistory ?? 0) > highestScore) {
        highestScore = quiz.scoreHistory!;
      }
      // Update fastest completion time
      if ((quiz.timeHistory ?? 0) < fastestCompletionTime &&
          quiz.timeHistory! > 0) {
        fastestCompletionTime = quiz.timeHistory!;
      }
      // Count today's attempts
      if (quiz.date == today) {
        totalAttempt++;
      }
      totalSeconds += quiz.timeHistory ?? 0;
      totalPoints += quiz.scoreHistory ?? 0;
    }
    totalAttempt = quizHistory.length;
    averageScore = totalPoints / totalAttempt;
    formatToTotalTime(totalSeconds);
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      String result = await FirebaseAuthentication.signOut();
      if (result == 'Succesfully sign out') {
        // Clear local auth state
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully signed out')));
        // Navigate to login screen
        Navigator.popAndPushNamed(context, AppRoutes.login);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign out error: $error')));
    }
  }

  /// Check if the device is connected to the internet
  Future<bool> _isNetworkAvailable(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isConnected = connectivityResult != ConnectivityResult.none;

    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No internet connection available')));
    }

    return isConnected;
  }
}
