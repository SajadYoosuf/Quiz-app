import 'package:quiz_app/Widget/QuizScreen/build_quiz_screen_content_based_on_network_status.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/quiz_screen_provider.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.url, super.key});
  final String url;
  // final int index;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    final quizPage = context.read<QuizScreenProvider>();
    if (!quizPage.apiCalled) {
      quizPage.fetchQuizData(widget.url, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryScreenSizes.int(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<QuizScreenProvider>(
        builder: (context, quizProvider, child) {
          return Scaffold(
              backgroundColor: AppColors.primaryAppColor,
              body: buildContentBasedOnNetworkStatus(
                  quizProvider,
                  MediaQueryScreenSizes.screenWidth,
                  MediaQueryScreenSizes.screenheight,
                  context));
        },
      ),
    );
  }
}
