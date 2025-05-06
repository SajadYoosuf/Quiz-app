import 'package:quiz_app/Model/quiz_history.dart';
// import 'package:quiz_app/View/LeaderBoard_screen.dart';
// import 'package:quiz_app/View/achievements_display_screen.dart';
// import 'package:quiz_app/View/home_screen.dart';
// import 'package:quiz_app/View/login_screen.dart';
// import 'package:quiz_app/View/profile_screen.dart';
// import 'package:quiz_app/View/quiz_history_screen.dart';
// import 'package:quiz_app/View/signup_screen.dart';
import 'package:quiz_app/ViewModel/quiz_rewiew_screen_provider.dart';
// import 'package:quiz_app/firebase_options.dart';

import 'package:quiz_app/utilities/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/ViewModel/login_screen_provider.dart';
import 'package:quiz_app/ViewModel/navigation_provider.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/ViewModel/forgot_password_screen_provider.dart';
import 'package:quiz_app/ViewModel/signup_screen_provider.dart';
import 'package:quiz_app/utilities/screen_routers.dart';
import 'ViewModel/quiz_screen_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
          create: (_) => QuizScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ForgotPasswordScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LeaderBoardScreenProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ProfileScreenProvider()),
        ChangeNotifierProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => QuizRewiewProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: Router.generateRoute,
        initialRoute: auth ? AppRoutes.home : AppRoutes.login,
        navigatorObservers: [routeObserver],
      ),
    );
  }
}
