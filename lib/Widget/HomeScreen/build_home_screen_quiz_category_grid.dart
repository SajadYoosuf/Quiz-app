import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Model/quiz_category_model.dart';
import 'package:quiz_app/ViewModel/quiz_screen_provider.dart';
import 'package:quiz_app/utilities/api_urls.dart';
import 'package:quiz_app/utilities/constant.dart';

SizedBox buildHomeScreenQuizCategoryGrid(double width, double height) {
  return SizedBox(
    width: width,
    height: height * 0.61,
    child: GridView.builder(
      itemCount: CategoryDetails.categoryDetails.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 9,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.read<QuizScreenProvider>().controller.start();
            context.read<QuizScreenProvider>().resetVariables();
            indexForCategoryFind = index;
            Navigator.pushNamed(
              context,
              AppRoutes.quiz,
              arguments: apiUrls[index],
            );
          },
          child: Container(
            width: width * 0.42,
            height: height * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white10,
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.012),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: width * 0.35,
                      height: height * 0.13,
                      imageUrl: CategoryDetails
                          .categoryDetails[index].quizCategoryNetworkImages,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.012),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    CategoryDetails.categoryDetails[index].quizCategoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.02,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
