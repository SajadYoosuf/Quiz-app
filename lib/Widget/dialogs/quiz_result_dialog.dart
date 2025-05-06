import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Model/quiz_data_model.dart';
import 'package:quiz_app/View/quiz_rewiew_screen.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/api_urls.dart';
import 'package:quiz_app/utilities/rewiew_message_category_wise.dart';
import 'package:quiz_app/utilities/constant.dart';

class QuizResultDialog {
  static void showWinDialog(
    BuildContext context,
    int finalMark,
    QuizData quizData,
    List<String> userChoosedOption,
    List<int> userTimings,
    List<int> userScores,
  ) {
    final quizPage = Provider.of<QuizScreenProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    String? message =
        getReviewMessage(finalMark, quizData.results[0].category.name);
    quizPage.timer.cancel();
    quizPage.controller.reset();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 360,
              child: Stack(
                children: [
                  Container(
                    width: width * 0.8,
                    height: 350,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.emoji_events,
                            color: Colors.yellow, size: 50),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          style: AppStyles.rewiewMessageStyle,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Lottie.asset(
                        'assets/animation/Animation - 1744652046814.json',
                        frameRate: FrameRate.max),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showFailedDialog(
    BuildContext context,
    int finalMark,
    QuizData quizData,
    List<String> userChoosedOption,
    List<int> userTimings,
    List<int> userScores,
  ) {
    final quizPage = Provider.of<QuizScreenProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    String? message =
        getReviewMessage(finalMark, quizData.results[0].category.name);
    quizPage.timer.cancel();
    quizPage.controller.reset();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: width * 0.7,
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
          child: Column(
            children: [
              const Icon(
                Icons.heart_broken,
                color: Colors.red,
                size: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: AppStyles.rewiewMessageStyle,
              ),
              Center(
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: () {
                        quizPage.controller.reset();
                        quizPage.resetVariables();
                        quizPage.fetchQuizData(
                            apiUrls[indexForCategoryFind!], context);

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Retry',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.review,
                              arguments: QuizRewiewScreen(
                                  quizData: quizData,
                                  options: userChoosedOption,
                                  markPerQuesion: userScores,
                                  responseTimes: userTimings));
                        },
                        child: Text('Rewiew Your Quiz',
                            style: TextStyle(color: AppColors.whiteColor)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
