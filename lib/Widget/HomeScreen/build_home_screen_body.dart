import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/Widget/HomeScreen/build_home_screen_connected_content.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';
import 'package:quiz_app/utilities/constant.dart';

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
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.amber,
                    ),
                    Text(
                      'please connect to internet',
                      style: TextStyle(color: AppColors.whiteColor),
                    )
                  ],
                ),
              ),
        Positioned(bottom: 0, child: buildNavigationWidget(context)),
      ],
    ),
  );
}
