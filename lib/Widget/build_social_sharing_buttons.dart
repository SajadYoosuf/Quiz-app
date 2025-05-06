import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/social_media_sharing.dart';
import 'package:quiz_app/utilities/widget_to_image.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';

Widget socialMediaSharingButtons(
    BuildContext context,
    String image,
    SocailMediaSharing social,
    WidgetToImage widget,
    GlobalKey globalKey,
    SocialPlatform platform,
    String message) {
  // Get screen size using MediaQuery for responsive sizing
  var size = MediaQuery.of(context).size;
  var width = size.width;

  return InkWell(
    onTap: () {
      widget.capturePng(context, globalKey).then((value) {
        social.socialMediaSharing(platform, message, value, context);
      });
    },
    child: Container(
      width: width * 0.08, // Adjust the width based on screen width
      height: width * 0.08, // Adjust the height based on screen width
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
