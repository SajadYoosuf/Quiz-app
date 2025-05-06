import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/profile_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

GestureDetector buildProfileImageContainer(
    ProfileScreenProvider profileProvider,
    BuildContext context,
    double width,
    double height) {
  return GestureDetector(
    onTap: () => profileProvider.showOptions(context),
    child: CircleAvatar(
      radius: width * 0.25,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.network(
          AssetPaths.profileImageNetwork,
          fit: BoxFit.cover,
          width: width * 0.5,
          height: width * 0.5,
          errorBuilder: (context, error, stackTrace) {
            // If network image fails, try file image
            return profileProvider.profileImageFile != null
                ? Image.file(
                    profileProvider.profileImageFile!,
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
  );
}
