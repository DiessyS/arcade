import 'package:arcade/models/user.dart';
import 'package:arcade/service/models/user_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';

class UsersVM extends ChangeNotifier {
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

  Future removeUser(int id) async {
    await service<UserService>().delete(id);
    notifyListeners();
  }

  Future banStateUser(int id, bool banned) async {
    await service<UserService>().update(id, banned);
    notifyListeners();
  }
}
