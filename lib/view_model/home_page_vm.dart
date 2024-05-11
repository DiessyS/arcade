import 'package:arcade/enum/home_page_modes.dart';
import 'package:flutter/material.dart';

class HomePageVM extends ChangeNotifier {
  late HomePageModes mode;

  HomePageVM() {
    mode = HomePageModes.rasterMap;
  }

  changeModeTo(HomePageModes mode) {
    this.mode = mode;
    notifyListeners();
  }
}
