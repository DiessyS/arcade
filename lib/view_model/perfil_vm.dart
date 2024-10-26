import 'package:flutter/material.dart';

class PerfilVM extends ChangeNotifier {
  bool showAllEvents = true;

  void changeView(bool showAllEvents) {
    this.showAllEvents = showAllEvents;
    notifyListeners();
  }
}
