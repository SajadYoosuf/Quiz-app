import 'package:quiz_app/ViewModel/socail_media_sharing.dart';
import 'package:quiz_app/ViewModel/widget_to_image.dart';
import 'package:flutter/material.dart';

import 'package:social_sharing_plus/social_sharing_plus.dart';

Widget socialMediaSharingButtons(
    BuildContext context,
    String image,
    SocailMediaSharing social,
    WidgetToImage widget,
    GlobalKey globalKey,
    SocialPlatform platform,
    String message) {
  return InkWell(
    onTap: () {
      widget.capturePng(context, globalKey).then((value) {
        social.socialMediaSharing(platform, message, value, context);
      });
    },
    child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover))),
  );
}
