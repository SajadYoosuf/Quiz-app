import 'package:quiz_app/ViewModel/achievement_display_screen_provider.dart';
import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/HomeScreen/build_home_screen_appBar.dart';
import 'package:quiz_app/Widget/HomeScreen/build_home_screen_body.dart';

import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenProvider>().checkInternet();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<QuizScreenProvider>().quizIsActivated) {
        context
            .read<AchievementDisplayScreenProvider>()
            .checkAchievementForMaking(context);
      }
      context.read<HomeScreenProvider>().fetchUserData(context);
      context.read<LeaderBoardScreenProvider>().getLeaderBoardData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);

    return Consumer2<HomeScreenProvider, LeaderBoardScreenProvider>(
      builder: (context, homeProvider, leaderBoardProvider, child) {
        return Scaffold(
            backgroundColor: AppColors.primaryAppColor,
            appBar: buildHomeScreenAppBar(
                homeProvider,
                MediaQueryScreenSizes.screenWidth,
                MediaQueryScreenSizes.screenheight),
            body: buildHomeScreenBody(
                homeProvider,
                MediaQueryScreenSizes.screenWidth,
                MediaQueryScreenSizes.screenheight,
                context,
                leaderBoardProvider));
      },
    );
  }
}
