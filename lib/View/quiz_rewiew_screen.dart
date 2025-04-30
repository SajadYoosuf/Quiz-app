import 'package:quiz_app/Model/quiz_data.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/ViewModel/category.dart';
import 'package:quiz_app/Widget/options_container.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';

class QuizRewiewScreen extends StatefulWidget {
  const QuizRewiewScreen(
      {super.key,
      required this.quizData,
      required this.options,
      required this.takedTimes,
      required this.takedScores});
  final QuizData quizData;
  final List<String> options;

  final List<int> takedTimes;

  final List<int> takedScores;

  @override
  State<QuizRewiewScreen> createState() => _QuizRewiewScreenState();
}

class _QuizRewiewScreenState extends State<QuizRewiewScreen> {
  int? totalScore = 0;
  int? totalTime;

  @override
  void initState() {
    for (var i = 0; i < widget.takedScores.length; i++) {
      print(totalScore);
      print(totalTime);
      print(widget.takedScores[i]);
      totalScore = totalScore! + widget.takedScores[i];
      totalTime = totalTime! + widget.takedTimes[i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.options);
    print(widget.takedTimes);
    print(widget.takedScores);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Quiz Review",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Text(
              'Category:${CategoryDetails.categoryDetails[indexForCategoryFind!].quizCategoryName}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                SizedBox(width: width * 0.10),
                Icon(
                  Icons.scoreboard_rounded,
                  color: Colors.green,
                  size: 20,
                ),
                Text(
                  'Total Score : ${totalScore}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: width * 0.07),
                Icon(
                  Icons.timer,
                  color: Colors.black,
                  size: 20,
                ),
                Text(
                  'Total Time : ${totalTime}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.73,
              width: width * 0.83,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      width: width * 0.75,
                      height: height * 0.30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: const Border(
                              top: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.10,
                            width: width * 0.90,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  topLeft: Radius.circular(22),
                                ),
                                color: Colors.blue),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "   Q${index + 1}.${widget.quizData.results[index].question}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: optionsContainer(
                                widget.quizData.results[index].correctAnswer,
                                Icons.check,
                                'Answer: ',
                                Colors.green),
                          ),
                          // if (widget.options[index] ==
                          //     widget.quizData.results[index].correctAnswer)
                          widget.options[index] ==
                                  widget.quizData.results[index].correctAnswer
                              ? optionsContainer(
                                  widget.options[index],
                                  Icons.check_box,
                                  'Your Choice: ',
                                  Colors.green)
                              : const SizedBox(),
                          widget.options[index] !=
                                  widget.quizData.results[index].correctAnswer
                              ? optionsContainer(widget.options[index],
                                  Icons.cancel, 'Your choice: ', Colors.red)
                              : const SizedBox(),
                          widget.options[index] == "Error"
                              ? optionsContainer('You Dont Choosed Anything',
                                  Icons.error, 'Your choice :', Colors.red)
                              : const SizedBox(),

                          widget.options[index] != 'Error'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    optionsContainer(
                                        widget.takedTimes[index].toString(),
                                        Icons.timer,
                                        'Taked Time :',
                                        Colors.black),
                                    optionsContainer(
                                        widget.takedScores[index].toString(),
                                        Icons.scoreboard_outlined,
                                        'Score :',
                                        Colors.blue),
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: widget.options.length),
            ),
            // SizedBox(
            //   height: 30,
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen())),
                  child: const Text('Back To Home')),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
