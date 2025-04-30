import 'dart:developer';
import 'dart:math';

import 'package:quiz_app/View/profile_screen.dart';
import 'package:quiz_app/ViewModel/local_storage.dart';
import 'package:quiz_app/Widget/navigation_widget.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../Model/quiz_full_data.dart';
import '../ViewModel/quiz_related_functions.dart';

class ScoreDisplayPage extends StatefulWidget {
  const ScoreDisplayPage({super.key});

  @override
  State<ScoreDisplayPage> createState() => _ScoreDisplayPageState();
}

class _ScoreDisplayPageState extends State<ScoreDisplayPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LocalStorageProvider>().recieveDataFromHive();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var hieght = size.height;
    return Consumer<LocalStorageProvider>(
        builder: (context, localStorage, child) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xff1f1147),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff1f1147),
            leading: IconButton(
              icon: const Icon(
                size: 30,
                Icons.arrow_back,
                color: Color.fromARGB(255, 240, 240, 242),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            centerTitle: true,
            title: const Text(
              "SCORE CARD",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: localStorage.quizHistory.isEmpty
              ? SizedBox(
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
                            width: 340,
                            height: 175,
                            imageUrl: welcomeNetworkImage,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
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
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                              color: const Color.fromARGB(255, 77, 76, 76),
                            ),
                            child: Center(
                              child: Text(
                                'The card is empty please attempt a quiz',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )),
                      ),
                      Positioned(bottom: 0, child: navigationWidget(context))
                    ],
                  ),
                )
              : SizedBox(
                  width: width,
                  height: hieght,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CachedNetworkImage(
                              imageUrl: welcomeNetworkImage,
                              width: 200,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: hieght * 0.66 - 1,
                            width: width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              color: const Color(0xff7358ee),
                            ),
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: hieght * 0.63 - 1,
                                width: width - 40,
                                child: ListView.separated(
                                    itemCount: localStorage.quizHistory.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      int currentIndex =
                                          (index + 1) % colors.length;
                                      return Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: width * 0.56,
                                        height: hieght * 0.10,
                                        decoration: BoxDecoration(
                                            color: colors[currentIndex],
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    colorsIcons[currentIndex],
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 70,
                                              child: Text(
                                                localStorage.quizHistory[index]
                                                    .cateogryHistory!,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 70,
                                              top: 40,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.scoreboard_outlined,
                                                    size: 30,
                                                    color: colorsIcons[
                                                        currentIndex],
                                                  ),
                                                  Text(
                                                    localStorage
                                                        .quizHistory[index]
                                                        .scoreHistory!
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: 205,
                                              top: 36,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    color: colorsIcons[
                                                        currentIndex],
                                                    size: 30,
                                                  ),
                                                  Text(
                                                    "${localStorage.quizHistory[index].timeHistory!}s",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 20,
                                        )),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Positioned(bottom: 0, child: navigationWidget(context))
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
