import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

AppBar buildUserQuizHistoryAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primaryAppColor,
    leading: IconButton(
      icon: Icon(
        size: 30,
        Icons.arrow_back,
        color: AppColors.whiteColor,
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.profile);
      },
    ),
    centerTitle: true,
    title: const Text(
      "SCORE CARD",
      style: AppStyles.headingStyle,
    ),
  );
}
