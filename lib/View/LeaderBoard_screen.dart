import 'dart:io';

import 'package:quiz_app/ViewModel/leaderboard_page.dart';
import 'package:quiz_app/Widget/leaderboard_top_widget.dart';
import 'package:quiz_app/Widget/navigation_widget.dart';
import 'package:quiz_app/utilities/firebase_keys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<String> image = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LeaderBoardProvider>(context, listen: false);
      provider.getLeaderBoardData(context);
      if (provider.top3List.length == 3) {
        for (var i = 0; i < provider.top3List.length; i++) {
          String type = provider.top3List[i][userPhoto];
          if (type.startsWith('http://') || type.startsWith('https://')) {
            image.add(provider.top3List[i][userPhoto]);
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<LeaderBoardProvider>(
        builder: (context, leaderBoard, child) {
      return Scaffold(
          backgroundColor: Colors.blueAccent,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: Colors.blueAccent,
            title: const Text(
              "LeaderBoard",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(
            children: [
              leaderBoard.top3List.length == 3
                  ? Stack(
                      children: [
                        leaderBoardTop(
                            context,
                            100,
                            120,
                            40,
                            leaderBoard.top3List[0][userName] ?? '',
                            leaderBoard.top3List[0][leaderBoardScore] ?? '0'),
                        Positioned(
                          top: 80,
                          left: 46,
                          child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  border: const Border(
                                      top: const BorderSide(
                                          color: Colors.green, width: 4.0),
                                      left: BorderSide(
                                          color: Colors.green, width: 4.0),
                                      bottom: BorderSide(
                                          color: Colors.green, width: 4.0),
                                      right: BorderSide(
                                          color: Colors.green, width: 4.0)),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      // ignore: unnecessary_null_comparison
                                      image: image[0] != null
                                          ? CachedNetworkImageProvider(image[0])
                                          : FileImage(leaderBoard.top3List[0]
                                              [userPhoto]),
                                      fit: BoxFit.cover))),
                        ),
                        const Positioned(
                          top: 140,
                          left: 70,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 104, 172, 106),
                            radius: 10,
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        leaderBoardTop(
                            context,
                            100,
                            100,
                            125,
                            leaderBoard.top3List[1][userName] ?? '',
                            leaderBoard.top3List[1][leaderBoardScore] ?? '0'),
                        Positioned(
                          top: 60,
                          left: 135,
                          child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  border: const Border(
                                      top: const BorderSide(
                                          color: Colors.blue, width: 4.0),
                                      left: BorderSide(
                                          color: Colors.blue, width: 4.0),
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 4.0),
                                      right: BorderSide(
                                          color: Colors.blue, width: 4.0)),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      // ignore: unnecessary_null_comparison
                                      image: image[1] != null
                                          ? CachedNetworkImageProvider(image[1])
                                          : FileImage(leaderBoard.top3List[1]
                                              [userPhoto]),
                                      fit: BoxFit.cover))),
                        ),
                        const Positioned(
                          top: 115,
                          left: 160,
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 10,
                              child: Icon(
                                Icons.emoji_events,
                                color: Colors.yellow,
                                size: 15,
                              )),
                        ),
                        leaderBoardTop(
                            context,
                            100,
                            120,
                            215,
                            leaderBoard.top3List[2][userName] ?? '',
                            leaderBoard.top3List[2][leaderBoardScore] ?? '0'),
                        Positioned(
                          top: 80,
                          left: 225,
                          child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  border: const Border(
                                      top: const BorderSide(
                                          color: Colors.red, width: 4.0),
                                      left: BorderSide(
                                          color: Colors.red, width: 4.0),
                                      bottom: BorderSide(
                                          color: Colors.red, width: 4.0),
                                      right: BorderSide(
                                          color: Colors.red, width: 4.0)),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      // ignore: unnecessary_null_comparison
                                      image: image[2] != null
                                          ? CachedNetworkImageProvider(image[2])
                                          : FileImage(leaderBoard.top3List[2]
                                              [userPhoto]),
                                      fit: BoxFit.cover))),
                        ),
                        const Positioned(
                          top: 137,
                          left: 247,
                          child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Text(
                                '3',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: width,
                            height: height * 0.64 + 0.2,
                            // clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(125),
                                    topRight: Radius.circular(125))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 60.0, left: 20, right: 20),
                              child: ListView.separated(
                                  itemCount: 10,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10,
                                      ),
                                  itemBuilder: (context, index) {
                                    String type = leaderBoard.leaderboard[index]
                                        [userPhoto];
                                    // ignore: unused_local_variable
                                    String? file;
                                    if (type.startsWith('http://') ||
                                        type.startsWith('https://')) {
                                      file = leaderBoard.leaderboard[index]
                                          [userPhoto];
                                    }
                                    return Container(
                                      // width: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: ListTile(
                                        leading: Text(
                                          (index + 4).toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        title: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    // ignore: unnecessary_null_comparison
                                                    image: file != null
                                                        ? CachedNetworkImageProvider(
                                                            file)
                                                        : FileImage(leaderBoard
                                                                .top3List[0]
                                                            [userPhoto]),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              leaderBoard.leaderboard[index]
                                                      [userName] ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: width * 0.10,
                                            ),
                                            Text(
                                              leaderBoard.leaderboard[index]
                                                      [leaderBoardScore] ??
                                                  0,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Positioned(bottom: 0, child: navigationWidget(context))
                      ],
                    )
                  : Center(
                      child: const Text(
                        "Nothing on your leaderboard",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
              Positioned(bottom: 0, child: navigationWidget(context))
            ],
          ));
    });
  }
}
