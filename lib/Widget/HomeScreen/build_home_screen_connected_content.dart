import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/Widget/HomeScreen/home_score&rank_container.dart';

Column buildHomeScreenConnectedContent(
    BuildContext context,
    double width,
    double height,
    HomeScreenProvider homeProvider,
    LeaderBoardScreenProvider leaderBoardProvider) {
  return Column(
    children: [
      SizedBox(height: height * 0.03),
      Align(
        alignment: Alignment.topCenter,
        child: buildHomeScoreAndRankContainer(
          context,
          width,
          homeProvider.currentUserscore ?? '0',
          leaderBoardProvider.currentUserLeaderBoardRank ?? 0,
        ),
      ),
      SizedBox(height: height * 0.02),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Let's play",
            style: TextStyle(
              color: Colors.white,
              fontSize: height * 0.025,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}
