import 'package:flutter/material.dart';

import '../ViewModel/quiz_screen_provider.dart';

Widget buildQuizOptionContainer(
    BuildContext context,
    Color color,
    IconData icon,
    String options,
    int buttonIndex,
    QuizScreenProvider quizProvider,
    double width,
    double hieght) {
  return GestureDetector(
    onTap: () {
      quizProvider.checkAnswer(buttonIndex);
    },
    child: Container(
      width: width * 0.80,
      height: hieght * 0.08,
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color, width: 2),
            right: BorderSide(color: color, width: 2),
            bottom: BorderSide(color: color, width: 2),
            left: BorderSide(color: color, width: 2),
          ),
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                options,
                style: TextStyle(
                    color: color, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  color: color,
                ))
          ],
        ),
      ),
    ),
  );
}
