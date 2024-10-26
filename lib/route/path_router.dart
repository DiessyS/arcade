import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:arcade/view/home/map_page.dart';
import 'package:arcade/view/home/list_page.dart';
import 'package:arcade/view/home/login_page.dart';
import 'package:arcade/view/home/perfil_page.dart';
import 'package:arcade/view/home/users_page.dart';
import 'package:arcade/view/offline_page.dart';
import 'package:arcade/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PathRouter {
  int navigationIndex = 0;

  Route<dynamic> generateRoute(RouteSettings settings) {
    final String route = settings.name!;

    switch (route) {
      case '/login':
        return _builder(
          LoginPage(),
        );
      case '/map_page':
        return _builder(
          const MapPage(),
          protected: false,
        );
      case '/perfil_page':
        return _builder(
          PerfilPage(),
        );
      case '/users_page':
        return _builder(
          const UsersPage(),
        );
      case '/offline':
        return _builder(
          const OfflinePage(),
          withBottomNavigation: false,
          protected: false,
        );
      default:
        return _builder(
          const MapPage(),
        );
    }
  }

  PageRouteBuilder _builder(Widget widget, {bool withBottomNavigation = true, bool protected = true}) {
    if (protected && !service<AuthService>().isAuthenticated()) {
      return _pageBuilder(LoginPage());
    }

    return _pageBuilder(widget, withBottomNavigation: withBottomNavigation);
  }

  PageRouteBuilder _pageBuilder(Widget widget, {bool withBottomNavigation = true}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Material(
        child: Scaffold(
          body: widget,
          bottomNavigationBar: withBottomNavigation ? const BottomNavigation() : null,
        ),
      ),
    );
  }
}
