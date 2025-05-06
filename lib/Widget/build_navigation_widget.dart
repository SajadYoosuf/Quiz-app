import 'package:quiz_app/Widget/build_navigation_column.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

Container buildNavigationWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.secondaryAppColor),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.09,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildNavigationColumn(context, Icons.home, 'Home', 0, AppRoutes.home),
        buildNavigationColumn(context, Icons.leaderboard, 'LeaderBoard', 1,
            AppRoutes.leaderboard),
        buildNavigationColumn(
            context, Icons.person, 'Profile', 2, AppRoutes.profile)
      ],
    ),
  );
}
