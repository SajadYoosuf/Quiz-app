import 'package:flutter/material.dart';

import 'package:quiz_app/Widget/build_social_sharing_buttons.dart';
import 'package:quiz_app/utilities/social_media_sharing.dart';
import 'package:quiz_app/utilities/widget_to_image.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';

class AchievementDialog {
  static void show(BuildContext context, List<String> achievement) {
    final GlobalKey globalKey = GlobalKey();
    final WidgetToImage widgetToImage = WidgetToImage();
    final SocailMediaSharing socailMediaSharing = SocailMediaSharing();
    const List<SocialPlatform> platforms = SocialPlatform.values;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          content: Container(
            height: height * 0.54,
            width: width * 70,
            color: Colors.white,
            child: Column(
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: Container(/* Same content as before */),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Achievement unlocked! 🎉 Share with friends?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialMediaSharingButtons(
                        context,
                        'assets/images/facebook_logo.png',
                        socailMediaSharing,
                        widgetToImage,
                        globalKey,
                        platforms[0],
                        achievement[1]),
                    socialMediaSharingButtons(
                        context,
                        'assets/images/linkedin_logo.png',
                        socailMediaSharing,
                        widgetToImage,
                        globalKey,
                        platforms[1],
                        achievement[1]),
                    socialMediaSharingButtons(
                        context,
                        'assets/images/Reddit_Logo.png',
                        socailMediaSharing,
                        widgetToImage,
                        globalKey,
                        platforms[2],
                        achievement[1]),
                    socialMediaSharingButtons(
                        context,
                        'assets/images/twitter_logo.png',
                        socailMediaSharing,
                        widgetToImage,
                        globalKey,
                        platforms[3],
                        achievement[1]),
                    socialMediaSharingButtons(
                        context,
                        'assets/images/WhatsApp_icon.png',
                        socailMediaSharing,
                        widgetToImage,
                        globalKey,
                        platforms[4],
                        achievement[1]),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
