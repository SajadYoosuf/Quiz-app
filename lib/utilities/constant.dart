import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> quizHistoryBackgrounds = [
    Color(0xFF1f1147),
    Color(0xFF6a51dc),
    Color(0xFF3a0ca3),
    Color(0xFF240046),
    Color(0xFF5f0f40),
  ];

  static const List<Color> quizHistoryIcons = [
    Color(0xFFff5f1f),
    Color(0xFF00c896),
    Color(0xFFff0054),
    Color(0xFFffb000),
    Color(0xFF00b4d8),
  ];

  static List<Color> containerColors = List.generate(4, (_) => Colors.white);
  static Color primaryAppColor = const Color(0xFF121212);
  static Color secondaryAppColor = const Color.fromARGB(255, 77, 76, 76);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
}

class AppIcons {
  static const passwordIcon = Icon(Icons.password, color: Colors.white);
  static const emailIcon = Icon(Icons.email, color: Colors.white);
  static const nameIcon = Icon(Icons.person, color: Colors.white);
  static const rePasswordIcon = Icon(Icons.key, color: Colors.white);
  static List<IconData> optionIcons =
      List.generate(4, (_) => Icons.radio_button_unchecked_outlined);
}

class AppRoutes {
  static const String home = '/home';
  static const String leaderboard = '/leaderBoard';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String achievement = '/achievement';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String review = '/rewiew';
  static const String quiz = '/quiz';
  static const String reset = '/reset';
}

class AssetPaths {
  static const String googleLogo = 'assets/images/google_logo.jpg';
  static const String internetAnimation =
      'assets/animation/Animation - 1743850243095.json';
  static const String welcomeLogo = 'assets/images/final_logo.png';
  static const String profileAseetImage = 'assets/images/profileFileImage.jpg';

  static String profileImageNetwork =
      'https://img.freepik.com/...baby-watching-movie...';
  static const String welcomeImageNetwork =
      'https://img.freepik.com/...welcome-concept...';
}

class FirebaseKeys {
  static const String userScore = 'user_score';
  static const String userPhoto = 'user_photo';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userPassword = 'user_password';
}

const String quizHistoryHiveKey = 'quiz_history';

class MediaQueryScreenSizes {
  static late double screenWidth;
  static late double screenheight;
  static void int(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
  }
}

enum NetworkStatus { loading, loaded, error }

int? indexForCategoryFind;

class AuthResults {
  static const String loginSuccess = 'successfully login';
  static const String googleSignInSuccess = 'Successfully completed';
  static const String nullValueError =
      'Null check operator used on a null value';
}

class AppStyles {
  static const TextStyle subHeadingStyle = TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headingStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle rewiewMessageStyle =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  static const TextStyle smallHeadingStyle = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
}
