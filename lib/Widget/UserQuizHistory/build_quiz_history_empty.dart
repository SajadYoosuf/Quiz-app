import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildQuizHistoryEmptyWidget(
    BuildContext context, double width, double hieght) {
  return SizedBox(
    width: width,
    height: hieght,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: width * 0.85, // Adjusted with MediaQuery
              height: hieght * 0.25, // Adjusted with MediaQuery
              imageUrl: AssetPaths.welcomeImageNetwork,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hieght * 0.22),
          child: Container(
              height: hieght * 0.90,
              width: width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: AppColors.secondaryAppColor,
              ),
              child: const Center(
                child: Text(
                  'The card is empty please attempt a quiz',
                  style: AppStyles.subHeadingStyle, // Adjusted font size
                ),
              )),
        ),
        Positioned(bottom: 0, child: buildNavigationWidget(context))
      ],
    ),
  );
}
