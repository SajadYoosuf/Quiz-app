import 'package:quiz_app/Model/quiz_data.dart';
import 'package:quiz_app/ViewModel/alert_dialog.dart';
import 'package:quiz_app/Widget/quiz_page_widget.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/quiz_related_functions.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.url, super.key, required this.index});
  final String url;
  final int index;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<QuizData> future;
  @override
  void initState() {
    print('init state');
    print(Provider.of<QuizPageFunctions>(context, listen: false).apiCalled);
    if (!Provider.of<QuizPageFunctions>(context, listen: false).apiCalled) {
      future = Provider.of<QuizPageFunctions>(context, listen: false)
          .fetchQuizData(widget.url, context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return WillPopScope(
        onWillPop: () async => false,
        child: Consumer<QuizPageFunctions>(
            builder: (context, quizPageFuncitons, child) {
          AlertDialogs alertDialogs = AlertDialogs();
          return Scaffold(
              backgroundColor: Colors.black,
              body: FutureBuilder<QuizData>(
                  future: future,
                  builder: (context, snapshot) {
                    if (quizPageFuncitons.networkStatus ==
                        NetworkStatus.loaded) {
                      return Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    alertDialogs.alertDialogForQuit(
                                        context,
                                        quizPageFuncitons.resetVariables,
                                        quizPageFuncitons.timer),
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.white,
                                  size: 35,
                                )),
                            Container(
                              width: width * 0.80,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: const Border(
                                    top: BorderSide(
                                        color: Colors.white, width: 2),
                                    right: BorderSide(
                                        color: Colors.white, width: 2),
                                    bottom: BorderSide(
                                        color: Colors.white, width: 2),
                                    left: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Center(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 11,
                                      child: Container(
                                        width: 220,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 11,
                                      child: Container(
                                        width: quizPageFuncitons
                                            .currentQuestionIndexByContainerPercentage,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          color: const Color.fromARGB(
                                              255, 241, 217, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 5,
                                      child: Text(
                                        quizPageFuncitons.currentIndex == 9
                                            ? '10/10'
                                            : "0${quizPageFuncitons.currentIndex + 1}/10",
                                        style: const TextStyle(
                                          color: Color(0xFF32c8ad),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: height * 0.34,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 30,
                                left: 10,
                                child: Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    width: width * 0.90,
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 77, 76, 76),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          quizPageFuncitons
                                              .quizData
                                              .results[quizPageFuncitons
                                                  .currentIndex]
                                              .question,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ),
                              Positioned(
                                  left: 135,
                                  top: 0,
                                  child: CircularCountDownTimer(
                                    controller: quizPageFuncitons.controller,
                                    width: 80,
                                    height: 80,
                                    duration: quizPageFuncitons.time,
                                    isReverse: true,
                                    isReverseAnimation: true,
                                    fillColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    ringColor: Colors.black,
                                  ))
                              // Positioned(
                              //   left: 135,
                              //   top: 0,
                              //   child: CircularCountDownTimer(
                              //     radius: 40.0,
                              //     lineWidth: 7.0,
                              //     percent: 0.8,
                              //     center: Text(
                              //       quizPageFuncitons.time.toString(),
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20),
                              //     ),
                              //     progressColor: Colors.white,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        if (quizPageFuncitons.options.length == 2)
                          Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              optionContainer(
                                context,
                                containerColors[0],
                                optionIcons[0],
                                quizPageFuncitons.options[0],
                                0,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              optionContainer(
                                context,
                                containerColors[1],
                                optionIcons[1],
                                quizPageFuncitons.options[1],
                                1,
                              ),
                              SizedBox(
                                height: height * 0.17,
                              ),
                              nextButton(context, widget.index
                                  // 'Next',
                                  // 2,
                                  // quizFullData[quizPageFuncitons.currentIndex].answer!,
                                  // quizFullData,
                                  // categoryName,
                                  ),
                            ],
                          )
                        else
                          SizedBox(
                            height: height * 0.50,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.40,
                                  child: ListView.separated(
                                    reverse: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: quizPageFuncitons.options.length,
                                    itemBuilder: (context, index) =>
                                        optionContainer(
                                      context,
                                      containerColors[index],
                                      optionIcons[index],
                                      quizPageFuncitons.options[index],
                                      index,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                nextButton(context, widget.index
                                    // 'Next',
                                    // 2,
                                    // quizFullData[quizPageFuncitons.currentIndex].answer!,
                                    // quizFullData,
                                    // categoryName,
                                    ),
                              ],
                            ),
                          ),
                        // optionContainer(
                        //   context,
                        //   containerColors[0],
                        //   optionIcons[0],
                        //   snapshot.data!.results[0].incorrectAnswers[0],
                        //   1,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // optionContainer(
                        //   context,
                        //   containerColors[1],
                        //   optionIcons[1],
                        //   snapshot.data!.results[0].incorrectAnswers[1],
                        //   2,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // optionContainer(
                        //   context,
                        //   containerColors[2],
                        //   optionIcons[2],
                        //   snapshot.data!.results[0].incorrectAnswers[2],
                        //   3,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // optionContainer(
                        //   context,
                        //   containerColors[3],
                        //   optionIcons[3],
                        //   snapshot.data!.results[0].correctAnswer,
                        //   4,
                        // ),
                        // SizedBox(
                        //   height: height * 0.04,
                        // ),

                        // const SizedBox(
                        //   width: 20,
                        // ),
                      ]);
                    } else if (quizPageFuncitons.networkStatus ==
                        NetworkStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value: 30,
                        ),
                      );
                    } else if (quizPageFuncitons.networkStatus ==
                        NetworkStatus.error) {
                      print('somthing');
                      return Center(
                        child: const Icon(
                          Icons.error,
                          size: 250,
                          color: Colors.red,
                        ),
                      );
                    }
                    return const SizedBox();
                  }));
        }));
  }
}
