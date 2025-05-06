import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_home_screen_connected_content.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';

SizedBox buildHomeScreenBody(
    HomeScreenProvider homeProvider,
    double width,
    double height,
    BuildContext context,
    LeaderBoardScreenProvider leaderBoardProvider) {
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      children: [
        homeProvider.checkNetwork
            ? buildHomeScreenConnectedContent(
                context, width, height, homeProvider, leaderBoardProvider)
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.amber,
                    ),
                    Text(
                      'please connect to internet',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
        Positioned(bottom: 0, child: buildNavigationWidget(context)),
      ],
    ),
  );
}
