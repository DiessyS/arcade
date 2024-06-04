import 'package:arcade/models/user.dart';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AuthVM extends ChangeNotifier {
  login(String identifier, String password, BuildContext context) {
    try {
      service<AuthService>().login(identifier, password);
      Navigator.pop(context);
    } catch (e) {
      showToast(
        'Não é possivel efetuar o login ${e.toString()}',
        position: ToastPosition.bottom,
      );
    }
    notifyListeners();
  }

  User? getUser() {
    return service<AuthService>().user;
  }

  logout() {
    service<AuthService>().logout();
    notifyListeners();
  }

  isAuthenticated() {
    return service<AuthService>().isAuthenticated();
  }

  isUserManager() {
    User? user = service<AuthService>().user;
    if (user == null) {
      return false;
    }
    return service<AuthService>().user!.manager;
  }
}
