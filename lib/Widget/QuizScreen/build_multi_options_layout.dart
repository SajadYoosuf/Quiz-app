import 'package:flutter/material.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/Widget/QuizScreen/build_next_button.dart';
import 'package:quiz_app/Widget/build_quiz_options_container.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildMultiOptionsLayout(QuizScreenProvider quizProvider, double height,
    double width, BuildContext context) {
  return SizedBox(
    height: height * 0.50,
    child: Column(
      children: [
        SizedBox(
          height: height * 0.40,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: quizProvider.options.length,
            itemBuilder: (context, index) => buildQuizOptionContainer(
                context,
                AppColors.containerColors[index],
                AppIcons.optionIcons[index],
                quizProvider.options[index],
                index,
                quizProvider,
                width,
                height),
          ),
        ),
        const SizedBox(height: 40),
        buildNextButton(context),
      ],
    ),
  );
}
