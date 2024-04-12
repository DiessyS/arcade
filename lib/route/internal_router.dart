import 'package:arcade/view/home/main_page.dart';
import 'package:arcade/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class InternalRouter {
  int bottomIndex = 0;

  Route<dynamic> generateRoute(RouteSettings settings) {
    String route = settings.name!;

    switch (route) {
      case 'main_page':
        return _builder(
          MainPage(),
        );
      default:
        return _builder(
          MainPage(),
        );
    }
  }

  PageRouteBuilder _builder(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Material(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 124),
              child: widget,
            ),
            BottomNavigation(),
          ],
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
