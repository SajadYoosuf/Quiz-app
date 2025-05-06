import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Model/quiz_data_model.dart';

import 'package:quiz_app/ViewModel/quiz_rewiew_screen_provider.dart';
import 'package:quiz_app/Widget/QuizRewiewScreen/build_basic_details_row.dart';
import 'package:quiz_app/Widget/QuizRewiewScreen/build_quiz_rewiew_details.container.dart';
import 'package:quiz_app/Widget/custom_action_button.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:quiz_app/Model/quiz_category_model.dart';

class QuizRewiewScreen extends StatefulWidget {
  const QuizRewiewScreen(
      {super.key,
      required this.quizData,
      required this.options,
      required this.responseTimes,
      required this.markPerQuesion});
  final QuizData quizData;
  final List<String> options;
  final List<int> responseTimes;
  final List<int> markPerQuesion;

  @override
  State<QuizRewiewScreen> createState() => _QuizRewiewScreenState();
}

class _QuizRewiewScreenState extends State<QuizRewiewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizRewiewProvider>().calculateTheScoreAndTime(
          widget.markPerQuesion, widget.responseTimes);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);

    return Consumer<QuizRewiewProvider>(
      builder: (context, quizRewiewProvider, child) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: AppColors.primaryAppColor,
            appBar: AppBar(
              backgroundColor: AppColors.primaryAppColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                "Quiz Review",
                style: AppStyles.headingStyle,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQueryScreenSizes.screenWidth * 0.05),
                    child: Text(
                      'Category: ${CategoryDetails.categoryDetails[indexForCategoryFind!].quizCategoryName}',
                      style: AppStyles.subHeadingStyle,
                    ),
                  ),
                  buildBasicDetailsRow(
                    MediaQueryScreenSizes.screenWidth,
                    quizRewiewProvider,
                  ),
                  buildQuizRewiewDetailsContainer(
                      MediaQueryScreenSizes.screenWidth,
                      MediaQueryScreenSizes.screenheight,
                      widget.options,
                      widget.quizData,
                      widget.responseTimes,
                      widget.markPerQuesion),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomActionButton(
                        text: 'Go To HomePage',
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, AppRoutes.home),
                        width: MediaQueryScreenSizes.screenWidth,
                        height: MediaQueryScreenSizes.screenheight),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
