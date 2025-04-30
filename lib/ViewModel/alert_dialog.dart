import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:quiz_app/Model/quiz_data.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/View/quiz_rewiew_screen.dart';
import 'package:quiz_app/ViewModel/quiz_related_functions.dart';
import 'package:quiz_app/ViewModel/socail_media_sharing.dart';
import 'package:quiz_app/ViewModel/widget_to_image.dart';
import 'package:quiz_app/Widget/social_media_sharing_buttons.dart';
import 'package:quiz_app/utilities/api_urls.dart';
import 'package:quiz_app/utilities/category_messages.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app/utilities/images.dart';

import 'package:social_sharing_plus/social_sharing_plus.dart';
import 'dart:io' show File, Platform;
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_share_plus/instagram_share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

class AlertDialogs extends QuizPageFunctions {
  static const List<SocialPlatform> platforms = SocialPlatform.values;
  GlobalKey globalKey = GlobalKey();
  WidgetToImage widgetToImage = WidgetToImage();
  SocailMediaSharing socailMediaSharing = SocailMediaSharing();

  alertDialogMaking(BuildContext context, List<String> achievement) {
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
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)),
                      width: width * 65,
                      height: 340,
                      child: Column(
                        children: [
                          Text(
                            achievement[0],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          CachedNetworkImage(
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            imageUrl: achievement[2],
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(
                              color: Colors.black,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              achievement[1],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Image.asset(
                                  welcomeLogo,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                                Text('@Mindspark')
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Achievement unlocked! 🎉 Share with friends?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
          // actions: <Widget>[],
        );
      },
    );
  }

  void alertDialogForQuit(
      BuildContext context, Function resetVariables, Timer timer) {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SizedBox(
            child: AlertDialog(
              title: const Center(
                child: Text(
                  "You Want Quit from this Quiz?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 8, 8, 8),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              content: const Text(
                "the current quiz progress is not storing when you quit",
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 4, 5),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      resetVariables();
                      Navigator.pop(
                        context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 9, 14)),
                    child: const Center(
                        child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ))),
                FilledButton(
                    onPressed: () {
                      final provider = Provider.of<QuizPageFunctions>(context,
                          listen: false);
                      provider.timer.cancel();
                      provider.controller.pause();

                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()))
                          .then((_) {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 8, 12)),
                    child: const Center(
                        child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ))),
              ],
            ),
          );
        });
  }

  static alertDialogForQuizWinningAndFailedAndQuit(
    BuildContext context,
    int finalMark,
    QuizData quizData,
    List<String> userChoosedOption,
    List<int> userTimings,
    List<int> userScores,
    String type,
  ) {
    final quizPage = Provider.of<QuizPageFunctions>(context, listen: false);

    quizPage.quizIsActivated = true;
    switch (type) {
      case 'win':
        print(quizData.results[0].category.name);
        String? message =
            getReviewMessage(finalMark, quizData.results[0].category.name);
        quizPage.timer.cancel();
        quizPage.controller.pause();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: 360,
                  child: Stack(
                    children: [
                      Container(
                        width: 250,
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.yellow,
                              size: 50,
                            ),
                            const Text(
                              "congratulations",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 80, 145),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Your score',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: finalMark.toString(),
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                              const TextSpan(
                                  text: '/100',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                            ])),
                            Text(message),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    },
                                    child: const Text(
                                      'Back To Home',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  FilledButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return QuizRewiewScreen(
                                              quizData: quizData,
                                              options: userChoosedOption,
                                              takedScores: userScores,
                                              takedTimes: userTimings);
                                        }));
                                      },
                                      child: const Text('Rewiew Your Quiz',
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Lottie.asset(
                            'assets/animation/Animation - 1744652046814.json',
                            frameRate: FrameRate.max),
                      )
                    ],
                  ),
                ),
              );
            });
      case 'failed':
        quizPage.timer.cancel();
        quizPage.controller.pause();
        String message = getReviewMessage(finalMark, 'failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              width: 250,
              height: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(22)),
              child: Column(
                children: [
                  const Icon(
                    Icons.heart_broken,
                    color: Colors.red,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Column(
                      children: [
                        FilledButton(
                          onPressed: () {
                            quizPage.resetVariables();
                            quizPage.fetchQuizData(
                                apiUrls[indexForCategoryFind!], context);

                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        FilledButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return QuizRewiewScreen(
                                    quizData: quizData,
                                    options: userChoosedOption,
                                    takedScores: userScores,
                                    takedTimes: userTimings);
                              }));
                            },
                            child: const Text('Rewiew Your Quiz',
                                style: TextStyle(color: Colors.white)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      default:
    }
    return null;
  }
}
