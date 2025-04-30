import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/View/login_screen.dart';
import 'package:quiz_app/ViewModel/RouteObserver/observ_utils.dart';
import 'package:quiz_app/firebase_options.dart';

import 'package:quiz_app/utilities/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/ViewModel/home_page_functions.dart';
import 'package:quiz_app/ViewModel/leaderboard_page.dart';
import 'package:quiz_app/ViewModel/local_storage.dart';
import 'package:quiz_app/ViewModel/login_page.dart';
import 'package:quiz_app/ViewModel/navigation.dart';
import 'package:quiz_app/ViewModel/profile_page_functions.dart';
import 'package:quiz_app/ViewModel/reset_password_page.dart';
import 'package:quiz_app/ViewModel/signup_provider.dart';
import 'ViewModel/quiz_related_functions.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'ViewModel/quiz_related_functions.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuizHistoryAdapter());

  await Hive.openBox<QuizHistory>(quizHistoryHiveKey);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  bool auth = prefs.getBool(
        'auth',
      ) ??
      false;
  print(auth);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MyApp(
      auth: auth,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.auth});
  final bool auth;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuizPageFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResetPasswordPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => LeaderBoardProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LocalStorageProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePageFunctions()),
        ChangeNotifierProvider(create: (_) => Navigation())
      ],
      child: MaterialApp(
          navigatorObservers: [ObserverUtils.routeObserver],
          home: auth ? const HomeScreen() : LoginScreen()),
    );
  }
}
