import 'dart:io';

import 'package:quiz_app/View/achievements_display_screen.dart';
import 'package:quiz_app/View/quiz_history_screen.dart';
import 'package:quiz_app/ViewModel/RouteObserver/observ_utils.dart';
import 'package:quiz_app/ViewModel/profile_page_functions.dart';
import 'package:quiz_app/Widget/navigation_widget.dart';
import 'package:quiz_app/Widget/profile_page_buttons.dart';
import 'package:quiz_app/Widget/profile_widget.dart';
import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfilePageFunctions>().profilePageProgressMaking();
        Provider.of<ProfilePageFunctions>(context, listen: false)
            .fetchUserData(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    ObserverUtils.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    print('calling the route');
    Provider.of<ProfilePageFunctions>(context, listen: false).refreshVaribles();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfilePageFunctions>(context);
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1c1c1c),
      body: Stack(
        children: [
          Skeletonizer(
            enabled: profile.isLoad,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => profile.showOptions(context),
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: profile.imagePath != null
                                        ? FileImage(profile.imagePath!)
                                        : NetworkImage(profileImage),
                                    fit: BoxFit.cover))),
                      ),
                      profile.tappedForNameChange
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 100,
                                        top: 20,
                                        child: SizedBox(
                                            width: width * 0.50,
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  profile.userNameController,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  hintStyle: const TextStyle(
                                                      color: Colors.white),
                                                  fillColor: Colors.black,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22))),
                                            )),
                                      ),
                                      Positioned(
                                        left: 270,
                                        top: 10,
                                        child: IconButton(
                                            onPressed: () {
                                              profile.updateData(
                                                  profile
                                                      .userNameController.text,
                                                  context);
                                            },
                                            icon: const Icon(
                                              Icons.check,
                                              size: 40,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                SizedBox(
                                  width: width,
                                  height: 70,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 110,
                                        top: 20,
                                        child: Text(
                                          profile.currentUserName ??
                                              'Sajad Yoosuf',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors

                                      Positioned(
                                        left: 250,
                                        top: 10,
                                        child: IconButton(
                                            onPressed: () {
                                              profile.chagne();
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Progress',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      profilePrgressCard(
                          context,
                          Icons.emoji_events,
                          profile.totalPoints.toString(),
                          'Total Points Earned'),
                      const SizedBox(
                        height: 10,
                      ),
                      profilePrgressCard(
                          context,
                          Icons.calendar_month,
                          profile.attemptCountOnToday.toString(),
                          'Today Total Attempt'),
                      const SizedBox(
                        height: 10,
                      ),
                      profilePrgressCard(context, Icons.leaderboard,
                          profile.percentage.toString(), 'Average Quiz Score'),
                      const SizedBox(
                        height: 10,
                      ),
                      profilePrgressCard(
                          context,
                          Icons.insights,
                          profile.totalAttempt.toString(),
                          'Total number of quizzes attempted'),
                      const SizedBox(
                        height: 10,
                      ),
                      profilePrgressCard(
                          context,
                          Icons.electric_bolt,
                          profile.highestScore.toString(),
                          'Highest score ever achieved in a single quiz '),
                      const SizedBox(
                        height: 10,
                      ),
                      profilePrgressCard(
                          context,
                          Icons.timelapse,
                          profile.totalTimeSpent,
                          'Total time spent answering quizzes'),
                    ],
                  ),
                ),
                profilePageButtons(context, 'View Quiz History', Colors.white,
                    const QuizHistoryScreen(), Colors.black, 250),
                const SizedBox(
                  height: 10,
                ),
                profilePageButtons(context, 'View Achievements', Colors.white,
                    const AchievementsDisplayScreen(), Colors.black, 250),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 76, 76)),
                  onPressed: () => profile.signOut(context: context),
                  child: const Text('Sign out',
                      style: TextStyle(color: Colors.white)),
                )),
              ],
            ),
          ),
          Positioned(bottom: 0, child: navigationWidget(context))
        ],
      ),
    );
  }
}
