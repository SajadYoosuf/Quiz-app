import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/Widget/ProfileScreen/build_profile_image_and_name.dart';
import 'package:quiz_app/Widget/ProfileScreen/build_profile_progress_container_list.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/utilities/constant.dart';

Stack buildProfileScreenBody(double width, double height, BuildContext context,
    ProfileScreenProvider profileProvider) {
  return Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          buildProfileImageAndName(width, height, profileProvider, context),
          const Text('Progress', style: AppStyles.subHeadingStyle),
          buildProfileProgressContainerList(
              context, width, height, profileProvider),
          CustomActionButton(
              text: 'Quiz History',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
              width: width,
              height: height),
          CustomActionButton(
              text: 'Achievements',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.achievement),
              width: width,
              height: height),
          CustomActionButton(
              text: 'Sign out',
              onPressed: () => profileProvider.signOut(context: context),
              width: width,
              height: height)
        ],
      ),
      Positioned(bottom: 0, child: buildNavigationWidget(context))
    ],
  );
}
