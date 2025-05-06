import 'package:quiz_app/Model/quiz_history.dart';
import 'package:quiz_app/Widget/UserQuizHistory/build_quiz_history_details.dart';
import 'package:quiz_app/Widget/UserQuizHistory/build_quiz_history_empty.dart';
import 'package:quiz_app/Widget/UserQuizHistory/build_user_quiz_history_appBar.dart';
import 'package:quiz_app/services/local_storage_service.dart';
import 'package:quiz_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  late List<QuizHistory> quizHistory = [];

  void fetchQuizHistory() async {
    quizHistory = context.read<LocalStorageService>().recieveDataFromHive();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var hieght = size.height;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: AppColors.primaryAppColor,
          appBar: buildUserQuizHistoryAppBar(context),
          body: quizHistory.isEmpty
              ? buildQuizHistoryEmptyWidget(context, width, hieght)
              : buildQuizHistoryDetails(context, width, hieght, quizHistory)),
    );
  }
}
