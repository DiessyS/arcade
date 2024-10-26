import 'package:arcade/models/user.dart';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AuthVM extends ChangeNotifier {
  Future login(String identifier, String password, BuildContext context) async {
    try {
      await service<AuthService>().login(identifier, password);
      Navigator.of(context).pushNamed('/perfil_page');
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

  logout(context) async {
    await service<AuthService>().logout();
    Navigator.of(context).pushNamed('/login_page');
  }

  bool isAuthenticated() {
    return service<AuthService>().isAuthenticated();
  }

  bool isUserManager() {
    User? user = service<AuthService>().user;
    if (user == null) {
      return false;
    }
    return service<AuthService>().user!.manager;
  }
}
