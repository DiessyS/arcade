import 'package:flutter/material.dart';

class BottomNavigationVM extends ChangeNotifier {
  int lastNavigationIndex = 1;
  int navigationIndex = 1;
  double lastNavigationPositionValue = 1;

  setIndex(int index) {
    if (index == 0) {
      return;
    }

    lastNavigationIndex = navigationIndex;
    navigationIndex = index;

    notifyListeners();
  }

  // To trigger button hide the index must be 2 coming from 0 or 1
  canHideButton() {
    return lastNavigationIndex == 1 && navigationIndex == 0 || navigationIndex == 2;
  }

  // To trigger button show the index must be 0 or 1 coming from 2
  canShowButton() {
    return (lastNavigationIndex == 2 || lastNavigationIndex == 0) && navigationIndex == 1;
  }

  Color getColorByActivity(index) {
    return (navigationIndex == index) ? Colors.black.withOpacity(0.08) : Colors.transparent;
  }
}
