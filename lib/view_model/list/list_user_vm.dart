import 'package:arcade/models/user.dart';
import 'package:arcade/models/user_model.dart';
import 'package:arcade/service/models/user_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';

class ListUsersVM extends ChangeNotifier {
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<List<User>> getUsers() async {
    List<User> user = await service<UserService>().getAll();
    return user;
  }
}
