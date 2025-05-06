import 'package:flutter/material.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';

class SocailMediaSharing {
  Future<void> socialMediaSharing(
    SocialPlatform platform,
    String message,
    String mediaPath,
    BuildContext context, {
    bool isMultipleShare = false,
  }) async {
    final String content =
        "Just unlocked the\"$message\" badge on MindSpark! 🧠";

    await SocialSharingPlus.shareToSocialMedia(
      platform,
      content,
      media: mediaPath,
      isOpenBrowser: true,
      onAppNotInstalled: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('${platform.name.toUpperCase()} is not installed.'),
          ));
      },
    );
  }
}
