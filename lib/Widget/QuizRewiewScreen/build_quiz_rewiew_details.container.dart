import 'package:flutter/material.dart';
import 'package:quiz_app/Model/quiz_data_model.dart';
import 'package:quiz_app/Widget/build_options_container.dart';

Widget buildQuizRewiewDetailsContainer(
    double width,
    double hieght,
    List<String> options,
    QuizData quizData,
    List<int> responseTimes,
    List<int> markPerQuestion) {
  return SizedBox(
    height: hieght * 0.7,
    width: width * 0.85,
    child: ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: hieght * 0.01,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Container(
          width: width * 0.75,
          margin: EdgeInsets.symmetric(vertical: hieght * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.03),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  color: Color.fromARGB(255, 77, 76, 76),
                ),
                width: width,
                child: Text(
                  "Q${index + 1}. ${quizData.results[index].question}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045,
                  ),
                ),
              ),
              SizedBox(height: hieght * 0.01),
              buildOptionsContainer(
                quizData.results[index].correctAnswer,
                Icons.check,
                'Answer: ',
                Colors.green,
              ),
              options[index] == quizData.results[index].correctAnswer
                  ? buildOptionsContainer(
                      options[index],
                      Icons.check_box,
                      'Your Choice: ',
                      Colors.green,
                    )
                  : buildOptionsContainer(
                      options[index],
                      Icons.cancel,
                      'Your Choice: ',
                      Colors.red,
                    ),
              if (options[index] == "Skipped")
                buildOptionsContainer(
                  'You Didn\'t Choose Anything',
                  Icons.cancel,
                  '',
                  Colors.red,
                ),
              if (options[index] != "Skipped") ...[
                buildOptionsContainer(
                  '${responseTimes[index]}',
                  Icons.timer,
                  'Taked Time :',
                  Colors.white,
                ),
                buildOptionsContainer(
                  '${markPerQuestion[index]}',
                  Icons.scoreboard_outlined,
                  'Score :',
                  Colors.blue,
                ),
              ],
            ],
          ),
        );
      },
    ),
  );
}
