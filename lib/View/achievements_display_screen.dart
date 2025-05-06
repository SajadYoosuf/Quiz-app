import 'package:quiz_app/Widget/AchievementDIsplayScreen/build_achievement_card_list.dart';
import 'package:quiz_app/services/local_storage_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utilities/constant.dart';

class AchievementsDisplayScreen extends StatefulWidget {
  const AchievementsDisplayScreen({super.key});

  @override
  State<AchievementsDisplayScreen> createState() =>
      _AchievementsDisplayScreenState();
}

class _AchievementsDisplayScreenState extends State<AchievementsDisplayScreen> {
  late List<bool> storingAchievementState = [];
  void fetchBoolList() async {
    storingAchievementState =
        await context.read<LocalStorageService>().reciveBoolList();
  }

  @override
  void initState() {
    super.initState();
    fetchBoolList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("ACHIEVEMENT CARDS", style: AppStyles.headingStyle),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: MediaQueryScreenSizes.screenWidth * 0.07,
          ),
        ),
      ),
      backgroundColor: AppColors.primaryAppColor,
      body: storingAchievementState.isNotEmpty
          ? buildAchievementCardList(MediaQueryScreenSizes.screenWidth,
              MediaQueryScreenSizes.screenheight, storingAchievementState)
          : SizedBox(
              width: MediaQueryScreenSizes.screenWidth,
              height: MediaQueryScreenSizes.screenheight,
              child: const Center(
                child: Text(
                  "You have not achieved any card",
                  textAlign: TextAlign.center,
                  style: AppStyles.subHeadingStyle,
                ),
              ),
            ),
    );
  }
}
