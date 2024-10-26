import 'package:arcade/theme/theme_tokens.dart';
import 'package:flutter/material.dart';

class BottomNavigationVM extends ChangeNotifier {
  int navigationIndex = 1;

  setIndex(int index) {
    navigationIndex = index;
    notifyListeners();
  }

  /*

  ##022026
   */

  Color getColorByActivity(index) {
    return (navigationIndex == index) ? Color(0xFFD6E1D6) : Colors.transparent;
  }
}
