import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/quiz_full_data.dart';
import '../ViewModel/quiz_page_functions.dart';
import 'Widget/quiz_page_widget.dart';

// ignore: must_be_immutable
class QuizPage extends StatelessWidget {
  const QuizPage(
      {required this.categoryName, required this.quizFullData, super.key});

  final String categoryName;
  final List<QuizFullData> quizFullData;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizPageFunctions>(
        builder: (context, quizPageFuncitons, child) {
      Duration duration = Duration(seconds: quizPageFuncitons.time);
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () {
          quizPageFuncitons.timer.cancel();
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: const Color(0xFF1f1147),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xFF1f1147),
              title: Text(
                categoryName,
                style: const TextStyle(
                    color: Color(0xFF36e9ba),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: Row(
                  children: [
                    Text(
                      quizPageFuncitons.currentIndex == 9
                          ? '10/10'
                          : "0${quizPageFuncitons.currentIndex + 1}/10",
                      style: const TextStyle(
                        color: Color(0xFF32c8ad),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 230,
                    ),
                    Text("$minutes:$seconds",
                        style: const TextStyle(
                            color: Color(
                              0xFF32c8ad,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    quizFullData[quizPageFuncitons.currentIndex].question!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                width: 270,
                height: 150,
                decoration: BoxDecoration(
                    color: const Color(0xFF1f1147),
                    borderRadius: BorderRadius.circular(14)),
                child: Image.asset(
                  quizFullData[quizPageFuncitons.currentIndex].images!,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        margin: const EdgeInsets.only(left: 0),
                        width: 270,
                        height: 150,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1f1147),
                            borderRadius: BorderRadius.circular(14)));
                  },
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: optionContainer(
                  context,
                  quizFullData[quizPageFuncitons.currentIndex].option1!,
                  1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: optionContainer(
                  context,
                  quizFullData[quizPageFuncitons.currentIndex].option2!,
                  2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: optionContainer(
                  context,
                  quizFullData[quizPageFuncitons.currentIndex].option3!,
                  3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: optionContainer(
                  context,
                  quizFullData[quizPageFuncitons.currentIndex].option4!,
                  4,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: questionChangingButton(
                        context,
                        'Previos',
                        1,
                        quizFullData[quizPageFuncitons.currentIndex].answer!,
                        quizFullData,
                        categoryName,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: questionChangingButton(
                        context,
                        'Next',
                        2,
                        quizFullData[quizPageFuncitons.currentIndex].answer!,
                        quizFullData,
                        categoryName,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ])),
      );
    });
  }
}
