// ignore: file_names
import 'package:quiz_app/ViewModel/leaderboard_screen_provider.dart';
import 'package:quiz_app/Widget/LeaderBoard%20Screen/build_leaderBoard_container.dart';
import 'package:quiz_app/Widget/LeaderBoard%20Screen/build_top_user_card.dart';
import 'package:quiz_app/Widget/build_navigation_widget.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaderBoardScreenProvider>().getLeaderBoardData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<LeaderBoardScreenProvider>(
        builder: (context, leaderboardProvider, child) {
      return Scaffold(
        backgroundColor: const Color(0xff0c697e),
        appBar: AppBar(
          backgroundColor: const Color(0xff0c697e),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Leaderboard",
            style: AppStyles.headingStyle,
          ),
        ),
        body: leaderboardProvider.top3List.length == 3
            ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTopUserCard(context, leaderboardProvider, 1,
                            Colors.amber.shade600, width, height),
                        buildTopUserCard(context, leaderboardProvider, 0,
                            Colors.orange.shade900, width, height),
                        buildTopUserCard(context, leaderboardProvider, 2,
                            Colors.grey.shade400, width, height),
                      ],
                    ),
                  ),
                  buildLeaderboardContainer(width, height, leaderboardProvider)
                ],
              )
            : Center(
                child: Text(
                  "Nothing on your leaderboard",
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                ),
              ),
        bottomNavigationBar: buildNavigationWidget(context),
      );
    });
  }
}
