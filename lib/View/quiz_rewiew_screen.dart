import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Model/quiz_data.dart';
import 'package:quiz_app/View/home_screen.dart';
import 'package:quiz_app/ViewModel/category.dart';
import 'package:quiz_app/ViewModel/quiz_rewiew_provider.dart';
import 'package:quiz_app/Widget/options_container.dart';
import 'package:quiz_app/utilities/constant.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizRewiewProvider>(context, listen: false)
          .calculateTheScoreAndTime(widget.takedScores, widget.takedTimes);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final quizRewiewProvider = Provider.of<QuizRewiewProvider>(context);
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
        body: SingleChildScrollView(
          // Wrap the entire body in SingleChildScrollView
          child: Column(
            children: [
              Text(
                'Category:${CategoryDetails.categoryDetails[indexForCategoryFind!].quizCategoryName}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  SizedBox(width: width * 0.10),
                  const Icon(
                    Icons.scoreboard_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                  Text(
                    'Total Score : ${quizRewiewProvider.totalScore}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: width * 0.07),
                  const Icon(
                    Icons.timer,
                    color: Colors.black,
                    size: 20,
                  ),
                  Text(
                    'Total Time : ${quizRewiewProvider.totalTimeSpent}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.73,
                width: width * 0.83,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: widget.options.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: width * 0.75,
                        height: height * 0.28,
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
                            Column(
                              children: [
                                optionsContainer(
                                    widget
                                        .quizData.results[index].correctAnswer,
                                    Icons.check,
                                    'Answer: ',
                                    Colors.green),
                                widget.options[index] ==
                                        widget.quizData.results[index]
                                            .correctAnswer
                                    ? optionsContainer(
                                        widget.options[index],
                                        Icons.check_box,
                                        'Your Choice: ',
                                        Colors.green)
                                    : optionsContainer(
                                        widget.options[index],
                                        Icons.cancel,
                                        'Your choice: ',
                                        Colors.red),
                                widget.options[index] == "Error"
                                    ? optionsContainer(
                                        'You Dont Choosed Anything',
                                        Icons.cancel,
                                        '',
                                        Colors.red)
                                    : const SizedBox(),
                                widget.options[index] != 'Error'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          optionsContainer(
                                              widget.takedTimes[index]
                                                  .toString(),
                                              Icons.timer,
                                              'Taked Time :',
                                              Colors.black),
                                          optionsContainer(
                                              widget.takedScores[index]
                                                  .toString(),
                                              Icons.scoreboard_outlined,
                                              'Score :',
                                              Colors.blue),
                                        ],
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                    child: const Text('Back To Home')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
