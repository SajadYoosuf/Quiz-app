import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/achievement_messages.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildAchievementCardList(
    double width, double height, List<bool> storingAchievementState) {
  return ListView.separated(
    padding: EdgeInsets.symmetric(
      horizontal: width * 0.05,
      vertical: height * 0.02,
    ),
    separatorBuilder: (context, index) => SizedBox(height: height * 0.02),
    itemCount: 2,
    itemBuilder: (context, index) {
      if (storingAchievementState[index] == true) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          width: width * 0.9,
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                achievementMessages[index]![0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.06,
                ),
              ),
              SizedBox(height: height * 0.015),
              CachedNetworkImage(
                imageUrl: achievementMessages[index]![2],
                progressIndicatorBuilder: (context, url, progress) => SizedBox(
                  width: width * 0.1,
                  height: height * 0.1,
                  child: CircularProgressIndicator(
                    color: AppColors.blackColor,
                  ),
                ),
                width: width * 0.5,
                height: height * 0.5,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                  size: width * 0.15,
                ),
              ),
              SizedBox(height: height * 0.015),
              Text(
                achievementMessages[index]![1],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.045,
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );
}
