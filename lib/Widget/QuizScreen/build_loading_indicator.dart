import 'package:flutter/material.dart';
import 'package:quiz_app/utilities/constant.dart';

Widget buildLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(
      color: AppColors.whiteColor,
      value: 30,
    ),
  );
}
