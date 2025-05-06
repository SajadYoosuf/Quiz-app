import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildLeaderboardContainer(double width, double height,
    LeaderBoardScreenProvider leaderBoardProvider) {
  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.03),
      child: ListView.builder(
        itemCount: leaderBoardProvider.leaderboard.length,
        itemBuilder: (context, index) {
          final ImageProvider imageProvider = leaderBoardProvider
              .getImageProvider(leaderBoardProvider.leaderboard[index]
                      [FirebaseKeys.userPhoto] ??
                  AssetPaths.profileImageNetwork);

          return Card(
            color: const Color.fromARGB(255, 77, 76, 76),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: height * 0.008),
            child: ListTile(
              leading: Text(
                (index + 4).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.045,
                ),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.05,
                    backgroundImage: imageProvider,
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: Text(
                      leaderBoardProvider.leaderboard[index]
                              [FirebaseKeys.userName] ??
                          'Player',
                      style: TextStyle(
                          fontSize: width * 0.04, color: Colors.white),
                    ),
                  ),
                  Text(
                    leaderBoardProvider.leaderboard[index]
                            [FirebaseKeys.userScore] ??
                        '0',
                    style:
                        TextStyle(fontSize: width * 0.04, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
