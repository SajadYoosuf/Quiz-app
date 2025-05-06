// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/home_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

AppBar buildHomeScreenAppBar(
    HomeScreenProvider homeScreen, double width, double hieght) {
  return AppBar(
    backgroundColor: AppColors.primaryAppColor,
    automaticallyImplyLeading: false,
    title: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text("Hi, ${homeScreen.currentUserName ?? ''}",
              style: AppStyles.subHeadingStyle),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text("Let's make this productive",
              style: AppStyles.subHeadingStyle),
        )
      ],
    ),
    actions: [
      CircleAvatar(
        radius: width * 0.10,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            homeScreen.profilImageNetwork!,
            fit: BoxFit.cover,
            width: width * 0.5,
            height: width * 0.5,
            errorBuilder: (context, error, stackTrace) {
              // If network image fails, try file image
              return homeScreen.profileImageFile != null
                  ? Image.file(
                      homeScreen.profileImageFile!,
                      fit: BoxFit.cover,
                      width: width * 0.5,
                      height: width * 0.5,
                    )
                  : Image.asset(
                      AssetPaths.profileAseetImage,
                      fit: BoxFit.cover,
                      width: width * 0.5,
                      height: width * 0.5,
                    );
            },
          ),
        ),
      ),
    ],
  );
}
