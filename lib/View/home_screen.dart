// import 'dart:math';

import 'dart:io';

import 'package:quiz_app/View/quiz_screen.dart';
import 'package:quiz_app/ViewModel/category.dart';
import 'package:quiz_app/ViewModel/home_page_functions.dart';
import 'package:quiz_app/ViewModel/leaderboard_page.dart';
import 'package:quiz_app/ViewModel/quiz_related_functions.dart';
import 'package:quiz_app/Widget/navigation_widget.dart';
import 'package:quiz_app/Widget/score_board_container.dart';
import 'package:quiz_app/utilities/api_urls.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int? rank;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<QuizPageFunctions>().quizIsActivated) {
        context.read<QuizPageFunctions>().checkAchievementForMaking(context);
      }
      context.read<HomePageProvider>().fetchUserData(context);
      context.read<LeaderBoardProvider>().getLeaderBoardData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    // double crossAxisCount = width / (250);
    final homePage = Provider.of<HomePageProvider>(context);
    final leaderBoard = Provider.of<LeaderBoardProvider>(
      context,
    );
    return Skeletonizer(
      enableSwitchAnimation: true,
      enabled: homePage.isload,
      child: Scaffold(
        backgroundColor: const Color(0xFF1c1c1c),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1c1c1c),
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Hi, ${homePage.userName ?? ''}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Let's make this productive",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          actions: [
            Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: homePage.imagePath != null
                            ? FileImage(homePage.imagePath!)
                            : NetworkImage(profileImage),
                        fit: BoxFit.cover)))
          ],
        ),
        body: SizedBox(
          width: width,
          height: hieght,
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: scoreBoardContainer(
                          context,
                          width,
                          homePage.score ?? '0',
                          leaderBoard.currentUserLeaderBoardRank ?? 0)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Let's play",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    width: width,
                    height: hieght * 0.61,
                    child: GridView.builder(
                      itemCount: CategoryDetails.categoryDetails.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Provider.of<QuizPageFunctions>(context,
                                    listen: false)
                                .resetVariables();
                            indexForCategoryFind = index;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return QuizScreen(
                                  url: apiUrls[index], index: index);
                            }));
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 170,
                                height: 260,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color:
                                        const Color.fromARGB(255, 77, 76, 76)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 100,
                                          imageUrl: CategoryDetails
                                              .categoryDetails[index]
                                              .quizCategoryNetworkImages,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          CategoryDetails.categoryDetails[index]
                                              .quizCategoryName,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(bottom: 0, child: navigationWidget(context))
            ],
          ),
        ),
      ),
    );
  }
}
