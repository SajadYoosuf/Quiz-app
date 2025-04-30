import 'package:quiz_app/View/LeaderBoard_screen.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/View/profile_screen.dart';
import 'package:quiz_app/Widget/navigation_column.dart';
import 'package:flutter/material.dart';

Container navigationWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: const Color.fromARGB(255, 77, 76, 76)),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.09,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        navigationColumn(context, Icons.home, 'Home', 0, HomeScreen()),
        navigationColumn(
            context, Icons.leaderboard, 'LeaderBoard', 1, LeaderboardScreen()),
        navigationColumn(context, Icons.person, 'Profile', 2, ProfileScreen())
      ],
    ),
  );
}
