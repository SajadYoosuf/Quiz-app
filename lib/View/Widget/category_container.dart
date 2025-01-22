import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/quiz_full_data.dart';
import '../../ViewModel/quiz_page_functions.dart';
import '../quiz_page.dart';

Widget categoryContainer(
  BuildContext context,
  String categoryName,
  String categoryImage,
  Color containerColor,
  List<QuizFullData> quizFullData,
) {
  var functions = Provider.of<QuizPageFunctions>(context);
  var size = MediaQuery.of(context).size;
  var width = size.width;
  var hieght = size.height;
  return GestureDetector(
    onTap: () {
      functions.resetVariables(quizFullData);

      functions.displayCountDownTimer(context);

      functions.recieveDataFromSharedPreference();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(
            categoryName: categoryName,
            quizFullData: quizFullData,
          ),
        ),
      );
    },
    // ignore: use_build_context_synchronously

    child: Container(
      height: hieght * 0.19,
      width: width * 0.80,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          Center(
            child: Image.asset(
              categoryImage,
              width: 150,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
