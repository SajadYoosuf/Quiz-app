import 'package:flutter/material.dart';

List<Color> container = [
  const Color(0xFFd7eaf8),
  const Color(0xFFfbe4d0),
  const Color(0xFFebdbf4)
];
List<Color> containerwidgets = [
  const Color(0xFF39aeff),
  const Color(0xFFfe8711),
  const Color(0xFFa35fed)
];

class QuizFullData {
  String? question;
  String? images;
  String? answer;
  String? option1;
  String? option2;
  String? option3;
  String? option4;

  QuizFullData({
    this.question,
    this.images,
    this.answer,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
  });
}

class QuizCategoryDetails {
  String quizCategoryImages;
  String quizCategoryName;
  Color quizCategoryContainercolor;
  QuizCategoryDetails(
      {required this.quizCategoryName,
      required this.quizCategoryImages,
      required this.quizCategoryContainercolor});
}
