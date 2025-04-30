import 'package:quiz_app/ViewModel/local_storage.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementsDisplayScreen extends StatefulWidget {
  const AchievementsDisplayScreen({super.key});

  @override
  State<AchievementsDisplayScreen> createState() =>
      _AchievementsDisplayScreenState();
}

class _AchievementsDisplayScreenState extends State<AchievementsDisplayScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        context.read<LocalStorageProvider>().reciveBoolList();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = Provider.of<LocalStorageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "ACHIEVEMENT CARDS",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
        ),
        backgroundColor: Colors.black,
        body: localStorage.storingAchievementState[0] == true
            ? ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (localStorage.storingAchievementState[index] == true) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22)),
                        width: 350,
                        height: 300,
                        child: Column(
                          children: [
                            Text(
                              achievementMessages[index]![0],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            CachedNetworkImage(
                              imageUrl: achievementMessages[index]![2],
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const CircularProgressIndicator(
                                color: Colors.black,
                              ),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                achievementMessages[index]![1],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ));
                  }
                })
            : Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 400),
                  child: Text(
                    "You have no achieved any card",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ));
  }
}
