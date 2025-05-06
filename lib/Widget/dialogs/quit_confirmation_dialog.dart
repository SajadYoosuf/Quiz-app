import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

class QuitConfirmationDialog {
  static void show(BuildContext context, Timer timer) {
    final quizPage = Provider.of<QuizScreenProvider>(context, listen: false);
    quizPage.controller.pause();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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
            "The current quiz progress will not be stored when you quit",
            style: TextStyle(
                color: Color.fromARGB(255, 4, 4, 5),
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                quizPage.controller.resume();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 11, 9, 14)),
              child: const Center(
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                quizPage.timer.cancel();
                quizPage.controller.reset();
                Navigator.popAndPushNamed(context, AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 10, 8, 12)),
              child: const Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
