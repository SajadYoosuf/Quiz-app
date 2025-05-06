import 'package:flutter/material.dart';
import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildQuizHistoryListContainer(
    double width, double hieght, List<QuizHistory> quizHistory) {
  return SizedBox(
    height: hieght * 0.63 - 1,
    width: width - 40,
    child: ListView.separated(
        itemCount: quizHistory.length,
        itemBuilder: (BuildContext context, int index) {
          int currentIndex =
              (index + 1) % AppColors.quizHistoryBackgrounds.length;
          return Container(
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: width * 0.56,
            height: hieght * 0.10,
            decoration: BoxDecoration(
                color: AppColors.quizHistoryBackgrounds[currentIndex],
                borderRadius: BorderRadius.circular(14)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: width * 0.08, // Adjusted size
                    backgroundColor: AppColors.quizHistoryIcons[currentIndex],
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: hieght * 0.03), // Adjusted font size
                    ),
                  ),
                ),
                Positioned(
                  top: hieght * 0.01,
                  left: width * 0.2,
                  child: Text(
                    quizHistory[index].cateogryHistory!,
                    style: TextStyle(
                      fontSize: hieght * 0.03, // Adjusted font size
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  left: width * 0.2,
                  top: hieght * 0.05,
                  child: Row(
                    children: [
                      Icon(
                        Icons.scoreboard_outlined,
                        size: hieght * 0.04, // Adjusted icon size
                        color: AppColors.quizHistoryIcons[currentIndex],
                      ),
                      Text(
                        quizHistory[index].scoreHistory!.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: hieght * 0.03), // Adjusted font size
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: width * 0.6,
                  top: hieght * 0.05,
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppColors.quizHistoryIcons[currentIndex],
                        size: hieght * 0.04, // Adjusted icon size
                      ),
                      Text(
                        "${quizHistory[index].timeHistory!}s",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: hieght * 0.03), // Adjusted font size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            )),
  );
}
