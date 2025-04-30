import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  int currentIndex = 0;
  void navigation(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
