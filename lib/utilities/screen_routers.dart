import 'package:flutter/material.dart';
import 'package:quiz_app/View/LeaderBoard_screen.dart';
import 'package:quiz_app/View/achievements_display_screen.dart';
import 'package:quiz_app/View/forgott_passwrd_screen.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/View/login_screen.dart';
import 'package:quiz_app/View/profile_screen.dart';
import 'package:quiz_app/View/quiz_history_screen.dart';
import 'package:quiz_app/View/quiz_rewiew_screen.dart';
import 'package:quiz_app/View/quiz_screen.dart';
import 'package:quiz_app/View/signup_screen.dart';
import 'package:quiz_app/utilities/constant.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.leaderboard:
        return MaterialPageRoute(builder: (_) => const LeaderboardScreen());
      case AppRoutes.history:
        return MaterialPageRoute(builder: (_) => const UserHistoryScreen());
      case AppRoutes.achievement:
        return MaterialPageRoute(
            builder: (_) => const AchievementsDisplayScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.review:
        final args = settings.arguments as QuizRewiewScreen;
        return MaterialPageRoute(
            builder: (_) => QuizRewiewScreen(
                  quizData: args.quizData,
                  options: args.options,
                  markPerQuesion: args.markPerQuesion,
                  responseTimes: args.responseTimes,
                ));
      case AppRoutes.quiz:
        String url = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => QuizScreen(
                  url: url,
                ));
      case AppRoutes.reset:
        return MaterialPageRoute(builder: (_) => const ForgottPasswrdScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
