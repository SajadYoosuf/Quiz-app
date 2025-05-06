import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/Widget/ProfileScreen/build_profile_progress_card.dart';

SizedBox buildProfileProgressContainerList(BuildContext context, double width,
    double height, ProfileScreenProvider profileProvider) {
  return SizedBox(
    height: height * 0.2,
    width: width * 0.85,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        buildProfileProgressCard(
          context,
          Icons.emoji_events,
          profileProvider.totalPoints.toString(),
          'Total Points Earned',
          gradientColors: [Colors.blueAccent, Colors.green],
        ),
        SizedBox(height: height * 0.02),
        buildProfileProgressCard(
          context,
          Icons.calendar_month,
          profileProvider.attemptCountOnToday.toString(),
          'Today Total Attempt',
          gradientColors: [Colors.orange, Colors.red],
        ),
        SizedBox(height: height * 0.02),
        buildProfileProgressCard(
          context,
          Icons.leaderboard,
          profileProvider.averageScore.toString(),
          'Average Quiz Score',
          gradientColors: [Colors.purple, Colors.pink],
        ),
        SizedBox(height: height * 0.02),
        buildProfileProgressCard(
          context,
          Icons.insights,
          profileProvider.totalAttempt.toString(),
          'Total number of quizzes attempted',
          gradientColors: [Colors.teal, Colors.blue],
        ),
        SizedBox(height: height * 0.02),
        buildProfileProgressCard(
          context,
          Icons.electric_bolt,
          profileProvider.highestScore.toString(),
          'Highest score ever achieved in a single quiz',
          gradientColors: [Colors.yellow, Colors.green],
        ),
        SizedBox(height: height * 0.02),
        buildProfileProgressCard(
          context,
          Icons.timelapse,
          profileProvider.totalTimeSpent,
          'Total time spent answering quizzes',
          gradientColors: [Colors.indigo, Colors.blueGrey],
        ),
      ],
    ),
  );
}
