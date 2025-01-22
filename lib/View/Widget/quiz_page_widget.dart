import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/quiz_full_data.dart';
import '../../ViewModel/quiz_page_functions.dart';

Widget optionContainer(
  BuildContext context,
  String options,
  int buttonIndex,
) {
  final provider = Provider.of<QuizPageFunctions>(context);
  var size = MediaQuery.of(context).size;
  var width = size.width;
  var hieght = size.height;
  return GestureDetector(
    onTap: () {
      provider.colorChanging(buttonIndex);
    },
    child: Container(
      padding: EdgeInsets.only(top: hieght * 0.01),
      width: width - 50,
      height: hieght * 08,
      decoration: BoxDecoration(
          color: buttonIndex == provider.optionCheckeingIndex
              ? const Color(0xFF36e9ba)
              : const Color(0xFF1f1147),
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF8f71fd),
              child: Text(
                buttonIndex.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                options,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget questionChangingButton(
    BuildContext context,
    String buttonName,
    int buttonIndex,
    String answer,
    List<QuizFullData> fullData,
    String heading) {
  final provider = Provider.of<QuizPageFunctions>(context);

  return SizedBox(
    height: 50,
    width: 50,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6949fe),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          switch (buttonIndex) {
            case 1:
              provider.previousQuestionNavigation();
              break;
            case 2:
              provider.nextQuestionNavigation(
                answer,
                fullData,
                heading,
                context,
              );
              break;
            default:
          }
        },
        child: Text(
          buttonName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
  );
}
