import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';

class LoginVM extends ChangeNotifier {
  login(String identifier, String password, BuildContext context) {
    try {
      service<AuthService>().login(identifier, password);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  getUser() {
    return service<AuthService>().user;
  }

  logout() {
    service<AuthService>().logout();
    notifyListeners();
  }

  isAuthenticated() {
    return service<AuthService>().isAuthenticated();
  }
}
