import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/quiz_related_functions.dart';

Widget optionContainer(
  BuildContext context,
  Color color,
  IconData icon,
  String options,
  int buttonIndex,
) {
  final provider = Provider.of<QuizPageFunctions>(context);
  var size = MediaQuery.of(context).size;
  var width = size.width;
  var hieght = size.height;
  return GestureDetector(
    onTap: () {
      provider.checkingTheAnswer(buttonIndex);
    },
    child: Container(
      padding: EdgeInsets.only(top: hieght * 0.01),
      width: width * 0.90,
      height: 70,
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
            // const SizedBox(
            //   width: 40,
            // ),
            // Expanded(
            //   child: Text(
            //     '1',
            //     style: const TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 17),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

Widget nextButton(BuildContext context, int index) {
  final provider = Provider.of<QuizPageFunctions>(context);
  var size = MediaQuery.of(context).size;
  var width = size.width;
  var hieght = size.height;
  return SizedBox(
    height: 50,
    width: width * 0.90,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () => provider.nextButton(context, index),
        child: Text(
          'Next',
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        )),
  );
}
