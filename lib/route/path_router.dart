import 'package:arcade/view/home/home_page.dart';
import 'package:arcade/view/home/list_page.dart';
import 'package:arcade/view/offline_page.dart';
import 'package:arcade/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class PathRouter {
  int navigationIndex = 0;

  Route<dynamic> generateRoute(RouteSettings settings) {
    String route = settings.name!;

    switch (route) {
      case '/main_page':
        return _builder(
          const HomePage(),
        );
      case '/list_page':
        return _builder(
          const ListPage(),
        );
      case '/offline':
        return _builder(
          const OfflinePage(),
          withBottomNavigation: false,
        );
      default:
        return _builder(
          const HomePage(),
        );
    }
  }

  PageRouteBuilder _builder(Widget widget, {bool withBottomNavigation = true}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Material(
        child: Scaffold(
          body: widget,
          bottomNavigationBar: withBottomNavigation ? BottomNavigation() : null,
        ),
      ),
    );
  }
}
