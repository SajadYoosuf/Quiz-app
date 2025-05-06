import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildNextButton(BuildContext context) {
  final provider = Provider.of<QuizScreenProvider>(context);
  MediaQueryScreenSizes.int(context);
  return SizedBox(
    height: MediaQueryScreenSizes.screenheight * 0.06,
    width: MediaQueryScreenSizes.screenWidth * 0.90,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () => provider.goToNextQuestion(context),
        child: const Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        )),
  );
}
