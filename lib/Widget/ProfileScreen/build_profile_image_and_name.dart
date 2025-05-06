import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/Widget/ProfileScreen/build_profile_image.container.dart';
import 'package:quiz_app/Widget/build_profile_name_updating_textfield.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/utilities/constant.dart';

Align buildProfileImageAndName(double width, double height,
    ProfileScreenProvider profileProvider, BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Column(
      children: [
        buildProfileImageContainer(profileProvider, context, width, height),
        SizedBox(height: height * 0.01),
        profileProvider.isEdittingName
            ? buildProfileNameUpdatingTextField(
                context, width, height, profileProvider)
            : Row(
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.08,
                    child: Stack(
                      children: [
                        Positioned(
                          left: width * 0.20,
                          top: height * 0.02,
                          child: Text(
                            profileProvider.currentUserName ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.065,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        !profileProvider.isEdittingName
            ? CustomActionButton(
                text: 'Edit ProfileName',
                onPressed: () => profileProvider.startNameEditting(),
                width: width,
                height: height,
                textColor: AppColors.blackColor,
                backgroundColor: AppColors.whiteColor,
                borderColor: AppColors.blackColor,
              )
            : const SizedBox()
      ],
    ),
  );
}
