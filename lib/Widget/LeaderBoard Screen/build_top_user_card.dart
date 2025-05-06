import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildTopUserCard(
    BuildContext context,
    LeaderBoardScreenProvider leaderBoard,
    int index,
    Color badgeColor,
    double width,
    double height) {
  String name = leaderBoard.top3List[index][FirebaseKeys.userName] ?? 'Player';
  String score = leaderBoard.top3List[index][FirebaseKeys.userScore] ?? '0';
  String rank = (index + 1).toString();
  double avatarSize = width * 0.2;

  return Container(
    width: width * 0.28,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: avatarSize,
              backgroundColor: Colors.white,
              backgroundImage: leaderBoard.getImageProvider(
                  leaderBoard.top3List[index][FirebaseKeys.userPhoto] ??
                      AssetPaths.profileImageNetwork),
            ),
            CircleAvatar(
              radius: avatarSize * 0.2,
              backgroundColor: badgeColor,
              child: Text(
                rank,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: avatarSize * 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.04),
        ),
        Text(
          score,
          style: TextStyle(color: Colors.white70, fontSize: width * 0.035),
        ),
      ],
    ),
  );
}
